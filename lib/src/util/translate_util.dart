import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_compose_ui_modifiers/flutter_compose_ui_modifiers.dart';
import 'package:flutter_google_translate/flutter_google_translate.dart';
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
//   static get translation => instance._translation;
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
//       await _translation.translateText(text, messageId);
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

  late Translation _translation;

  TranslationModel _translated =
      TranslationModel(translatedText: '', detectedSourceLanguage: '');
  TranslationModel _detected =
      TranslationModel(translatedText: '', detectedSourceLanguage: '');

  Future translateText(String text, int messageId, {String? to}) async {
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
      if ((await MPingGoogleUtil.pingGoogle()).not()) {
        throw TranslateException('Google can not connect.');
      }

      _translation = Translation(apiKey: apiKey);
      String targetLanguage = to ?? Get.locale?.languageCode ?? 'en';
      try {
        _translated =
            await _translation.translate(text: text, to: targetLanguage);
      } on Exception catch (e, s) {
        gLogger.e(
          'request translate error::${e.toString()}\n'
          '${s.toString()}',
        );
        throw TranslateException('Google connect error.');
      }
      _detected = await _translation.detectLang(text: text);
      gLogger.d(
          '_translated::${_translated.translatedText}, _detected :${_detected.detectedSourceLanguage} ');
      setOk(
        originContent: text,
        result: _translated.translatedText,
        targetLanguage: targetLanguage,
        messageId: messageId,
      );
    } on Exception catch (e, s) {
      gLogger.e('$e\n$s');
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
  RxMap<int, TranslateStatus> translatingMap = <int, TranslateStatus>{}.obs;

  /// The key is origin content.
  /// and the value is the translated content with language.
  RxMap<String, Map<String, String>> translateResult =
      <String, Map<String, String>>{}.obs;

  TranslateStatus status(int messageId) {
    return translatingMap.containsKey(messageId)
        ? translatingMap[messageId]!
        : TranslateStatus.none;
  }

  void setTranslating(int messageId) {
    translatingMap[messageId] = TranslateStatus.translating;
  }

  void setOk({
    required String originContent,
    required String result,
    required String targetLanguage,
    required int messageId,
  }) {
    translateResult[originContent] = {targetLanguage: result};
    translatingMap[messageId] = TranslateStatus.translated;
  }

  void setError(int messageId) {
    translatingMap[messageId] = TranslateStatus.error;
  }

  String? get(String textMessage, {String? to}) {
    if (translateResult.containsKey(textMessage).not()) {
      return null;
    }
    final textMapResult = translateResult[textMessage]!;
    String targetLanguage = to ?? Get.locale?.languageCode ?? 'en';
    if (textMapResult.containsKey(targetLanguage).not()) {
      return null;
    }
    return textMapResult[targetLanguage];
  }
}
