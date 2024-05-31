import 'package:flutter_google_translate/src/db/database.dart';

class DbTranslateUtil {
  DbTranslateUtil();

  factory DbTranslateUtil.instance() => DbTranslateUtil();

  static final TranslateDbInstance db = TranslateDbInstance();

  Future<int> insertData({
    required String originContent,
    required String resultContent,
    required String targetLanguage,
  }) async {
    return db.into(db.translateItems).insert(
          TranslateItemsCompanion.insert(
            originContent: originContent,
            resultContent: resultContent,
            targetLanguage: targetLanguage,
          ),
        );
  }

  Future<TranslateItem?> getData(String originContent, String targetLanguage) {
    return (db.select(db.translateItems)
          ..where((t) => t.originContent.equals(originContent))
          ..where((t) => t.targetLanguage.equals(targetLanguage)))
        .getSingleOrNull();
  }
}
