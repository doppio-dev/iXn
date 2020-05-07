import 'package:doppio_dev_ixn/generated/l10n.dart';
import 'package:flutter/widgets.dart';

class TranslateService {
  static final _translateServiceSingleton = TranslateService._internal();

  S locale;

  factory TranslateService() {
    return _translateServiceSingleton;
  }
  TranslateService._internal();

  void update(BuildContext context) {
    locale = S.of(context);
  }

  /// {@template flutter.localizations.material.languages}
  static Map<String, String> localesCountry = {
    'af': 'Afrikaans',
    'am': 'Amharic',
    'ar': 'Arabic',
    'as': 'Assamese',
    'az': 'Azerbaijani',
    'be': 'Belarusian',
    'bg': 'Bulgarian',
    'bn': 'Bengali Bangla',
    'bs': 'Bosnian',
    'ca': 'Catalan Valencian',
    'cs': 'Czech',
    'da': 'Danish',
    'de': 'German (plus one country variation)',
    'el': 'Modern Greek',
    'en': 'English (plus 8 country variations)',
    'es': 'Spanish Castilian (plus 20 country variations)',
    'et': 'Estonian',
    'eu': 'Basque',
    'fa': 'Persian',
    'fi': 'Finnish',
    'fil': 'Filipino Pilipino',
    'fr': 'French (plus one country variation)',
    'gl': 'Galician',
    'gsw': 'Swiss German Alemannic Alsatian',
    'gu': 'Gujarati',
    'he': 'Hebrew',
    'hi': 'Hindi',
    'hr': 'Croatian',
    'hu': 'Hungarian',
    'hy': 'Armenian',
    'id': 'Indonesian',
    'is': 'Icelandic',
    'it': 'Italian',
    'ja': 'Japanese',
    'ka': 'Georgian',
    'kk': 'Kazakh',
    'km': 'Khmer Central Khmer',
    'kn': 'Kannada',
    'ko': 'Korean',
    'ky': 'Kirghiz Kyrgyz',
    'lo': 'Lao',
    'lt': 'Lithuanian',
    'lv': 'Latvian',
    'mk': 'Macedonian',
    'ml': 'Malayalam',
    'mn': 'Mongolian',
    'mr': 'Marathi',
    'ms': 'Malay',
    'my': 'Burmese',
    'nb': 'Norwegian Bokmål, which, in this library, is a synonym of `no`',
    'ne': 'Nepali',
    'nl': 'Dutch Flemish',
    'no': 'Norwegian',
    'or': 'Oriya',
    'pa': 'Panjabi Punjabi',
    'pl': 'Polish',
    'ps': 'Pushto Pashto',
    'pt': 'Portuguese (plus one country variation)',
    'ro': 'Romanian Moldavian Moldovan',
    'ru': 'Russian',
    'si': 'Sinhala Sinhalese',
    'sk': 'Slovak',
    'sl': 'Slovenian',
    'sq': 'Albanian',
    'sr': 'Serbian (plus 2 scripts)',
    'sv': 'Swedish',
    'sw': 'Swahili',
    'ta': 'Tamil',
    'te': 'Telugu',
    'th': 'Thai',
    'tl': 'Tagalog',
    'tr': 'Turkish',
    'uk': 'Ukrainian',
    'ur': 'Urdu',
    'uz': 'Uzbek',
    'vi': 'Vietnamese',
    'zh': 'Chinese (plus 2 country variations and 2 scripts)',
    'zu': 'Zulu',
  };

  /// {@endtemplate}
}
