import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:template/core/di_container.dart';
import 'package:template/core/helper/izi_validate.dart';
import 'package:template/core/services/multi_language_service/language/st_en_us.dart';
import 'package:template/core/services/multi_language_service/language/st_es_es.dart';
import 'package:template/core/services/multi_language_service/language/st_fr_fr.dart';
import 'package:template/core/services/multi_language_service/language/st_hi_in.dart';
import 'package:template/core/services/multi_language_service/language/st_pt_pt.dart';
import 'package:template/core/services/multi_language_service/language/st_ru_ru.dart';
import 'package:template/core/services/multi_language_service/language/st_vi_vn.dart';
import 'package:template/core/shared_pref/shared_preference_helper.dart';

class LocalizationService extends Translations {
// Get locale.
  static final locale = _getLocaleFromLanguage();

// Locale default.
  static const fallbackLocale = Locale('vi', 'VN');

  static final langCodes = [
    'en',
    'vi',
    'zh',
    'es',
    'hi',
    'fr',
    'ru',
    'pt',
    'de',
    'ja',
    'tr',
    'ko',
    'it',
    'th',
  ];

  // Locale have support.
  static final locales = [
    const Locale('en', 'US'),
    const Locale('vi', 'VN'),
    const Locale('zh', 'CN'),
    const Locale('es', 'ES'),
    const Locale('hi', 'IN'),
    const Locale('fr', 'FR'),
    const Locale('ru', 'RU'),
    const Locale('pt', 'PT'),
    const Locale('de', 'DE'),
    const Locale('ja', 'JN'),
    const Locale('tr', 'TR'),
    const Locale('ko', 'KR'),
    const Locale('it', 'IT'),
    const Locale('th', 'TH'),
  ];

// Language data to change.
  static final langs = LinkedHashMap.from({
    'en': 'English',
    'vi': 'Tiếng Việt',
    'zh': 'Trung quốc',
    'es': 'Tây Ban Nha',
    'hi': 'Ấn Độ',
    'fr': 'Pháp',
    'ru': 'Nga',
    'pt': 'Bồ Đào Nhà',
    'de': 'Đức',
    'ja': 'Nhật Bản',
    'tr': 'Thổ Nhĩ Kỳ',
    'ko': 'Hàn Quốc',
    'it': 'Italy',
    'th': 'Thái Lan',
  });

  // Multi Language data to change.
  final homeMultiLangs = LinkedHashMap.from({
    'en': 'English'.tr,
    'vi': 'Vietnamese',
    'es': 'Espanol'.tr,
    'pt': 'Portuguese'.tr,
    'hi': 'Hindi'.tr,
    'fr': 'Francais'.tr,
    'ru': 'Russian'.tr,
  });

  ///
  /// On change language.
  ///
  static void changeLocale(String langCode) {
    //
    // Save locale.
    sl<SharedPreferenceHelper>().setLocale(langCode);
    final locale = _getLocaleFromLanguage(langCode: langCode);
    Get.updateLocale(locale);
  }

  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': en,
        'vi_VN': vi,
        'es_ES': es,
        'hi_IN': hi,
        'fr_FR': fr,
        'pt_PT': pt,
        'ru_RU': ru,
      };

  static Locale _getLocaleFromLanguage({String? langCode}) {
    late String lang;
    if (IZIValidate.nullOrEmpty(langCode) && !IZIValidate.nullOrEmpty(sl<SharedPreferenceHelper>().getLocale)) {
      lang = sl<SharedPreferenceHelper>().getLocale.toString();
    } else if (!IZIValidate.nullOrEmpty(langCode)) {
      lang = langCode.toString();
    } else {
      if (Get.deviceLocale!.languageCode != 'vi') {
        lang = Get.deviceLocale!.languageCode;
      } else {
        lang = 'en';
      }

      // Save locale.
      sl<SharedPreferenceHelper>().setLocale(lang);
    }
    for (int i = 0; i < langCodes.length; i++) {
      if (lang == langCodes[i]) return locales[i];
    }

    DefaultCupertinoLocalizations.load(locale);
    return Get.locale!;
  }
}
