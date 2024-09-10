import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_google_translate/flutter_google_translate.dart';
import 'package:flutter_google_translate/src/util/ping.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

Logger gLogger = Logger(
  printer: PrettyPrinter(methodCount: 0),
);

class TranslateException implements Exception {
  final String message;

  TranslateException(this.message);

  @override
  String toString() {
    return 'TranslateException{message: $message}';
  }
}

/// Use demo:
/// ```
// class SelfTranslateUtil {
//   late Translation _translation;
//   static SelfTranslateUtil? _instance;
//
//   static Translation get translation => instance._translation;
//
//   SelfTranslateUtil._privateConstructor() {
//     final gltKey = ""; // Get your google translate key.
//     _translation = Translation(apiKey: gltKey);
//   }
//
//   static SelfTranslateUtil get instance =>
//       _instance ??= SelfTranslateUtil._privateConstructor();
//
//   Future translateText(String text, int messageId) async {
//     try {
//       await _translation.translateWithCache(text, messageId);
//     } on TranslateException catch (e) {
//       showCustomToast(e.message);
//     }
//   }
// }
///```
class TranslateUtil extends TranslateDataManage {
  String get apiKey {
    return '';
  }

  Translation? _translation;

  Future<String?> translateWithCache(String text, String messageId,
      {String? to, bool cache = true}) async {
    String targetLanguage = to ?? getDefLocaleStr();
    if (cache) {
      TranslateItem? translateItem =
          await DbTranslateUtil.instance().getData(text, targetLanguage);
      if (translateItem != null) {
        setOk(
          originContent: text,
          result: translateItem.resultContent,
          targetLanguage: targetLanguage,
          messageId: messageId,
        );
        return null;
      }
    }
    if (GetUtils.isNullOrBlank(apiKey)!) {
      throw TranslateException('Config error');
    }

    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.none)) {
      throw TranslateException('Please enable network.');
    }

    setTranslating(messageId);
    try {
      final pingResult = await PingGoogleUtil.pingGoogle();
      gLogger.d("pingResult::$pingResult");
      if (!pingResult) {
        throw TranslateException('Google can not connect.');
      }

      _translation ??= Translation(apiKey: apiKey);

      /// The model can't declaration on class because will be change by next word.
      TranslationModel _translated =
          TranslationModel(translatedText: '', detectedSourceLanguage: '');

      try {
        _translated =
            await _translation!.translate(text: text, to: targetLanguage);
      } on Exception catch (e, s) {
        gLogger.e(
          'request translate error::${e.toString()}\n'
          '${s.toString()}',
        );
        throw TranslateException('Google connect error.');
      }
      gLogger.d(
          '_translated::${_translated.translatedText}, origin is $text,  detectedSourceLanguage :${_translated.detectedSourceLanguage} ');

      /// Insert Data.
      await DbTranslateUtil.instance().insertData(
          originContent: text,
          resultContent: _translated.translatedText,
          targetLanguage: targetLanguage);

      /// return and store data.
      return setOk(
        originContent: text,
        result: _translated.translatedText,
        targetLanguage: targetLanguage,
        messageId: messageId,
      );
    } on Exception catch (e, s) {
      if (e is! TranslateException) gLogger.e('GoogleTranslate::error::$e\n$s');
      setError(messageId);
      rethrow;
    }
  }
}

enum TranslateStatus {
  none,
  translating,
  translated,
  error,
}

class TranslateDataManage {
  /// The key is message ID.
  RxMap<String, TranslateStatus> translatingMap =
      <String, TranslateStatus>{}.obs;

  /// The key is origin content.
  /// and the value is the translated content with language.
  RxMap<String, Map<String, String>> translateResult =
      <String, Map<String, String>>{}.obs;

  TranslateStatus status(String messageId) {
    return translatingMap.containsKey(messageId)
        ? translatingMap[messageId]!
        : TranslateStatus.none;
  }

  /// Please call this after change language.
  void clear() {
    translatingMap.clear();
  }

  void setTranslating(String messageId) {
    translatingMap[messageId] = TranslateStatus.translating;
  }

  String setOk({
    required String originContent,
    required String result,
    required String targetLanguage,
    required String messageId,
  }) {
    translateResult[originContent] = {targetLanguage: result};
    translatingMap[messageId] = TranslateStatus.translated;
    return result;
  }

  void setError(String messageId) {
    translatingMap[messageId] = TranslateStatus.error;
  }

  /// Get translate result, if not contain will return the origin content.
  String get(String textMessage, {String? to}) {
    if (!translateResult.containsKey(textMessage)) {
      return textMessage;
    }
    final textMapResult = translateResult[textMessage]!;
    String targetLanguage = to ?? getDefLocaleStr();
    if (!textMapResult.containsKey(targetLanguage)) {
      return textMessage;
    }
    return textMapResult[targetLanguage]!;
  }
}
