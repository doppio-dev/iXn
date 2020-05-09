// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

class S {
  S();

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final String name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      return S();
    });
  }

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  String get projects_card_name {
    return Intl.message(
      'Name',
      name: 'projects_card_name',
      desc: '',
      args: [],
    );
  }

  String get projects_card_locale {
    return Intl.message(
      'Locale',
      name: 'projects_card_locale',
      desc: '',
      args: [],
    );
  }

  String get projects_card_locales {
    return Intl.message(
      'Locales',
      name: 'projects_card_locales',
      desc: '',
      args: [],
    );
  }

  String get project_name {
    return Intl.message(
      'Name',
      name: 'project_name',
      desc: '',
      args: [],
    );
  }

  String get project_key {
    return Intl.message(
      'Key',
      name: 'project_key',
      desc: '',
      args: [],
    );
  }

  String get project_default_locale {
    return Intl.message(
      'Default Locale',
      name: 'project_default_locale',
      desc: '',
      args: [],
    );
  }

  String get project_your_locale {
    return Intl.message(
      'Your Locale',
      name: 'project_your_locale',
      desc: '',
      args: [],
    );
  }

  String get error_reload {
    return Intl.message(
      'Reload',
      name: 'error_reload',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru', countryCode: 'RU'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    if (locale != null) {
      for (Locale supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}
