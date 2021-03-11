// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values

class S {
  S();

  static S current;

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false) ? locale.languageCode : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      S.current = S();

      return S.current;
    });
  }

  static S of(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Name`
  String get projects_card_name {
    return Intl.message(
      'Name',
      name: 'projects_card_name',
      desc: '',
      args: [],
    );
  }

  /// `Locale`
  String get projects_card_locale {
    return Intl.message(
      'Locale',
      name: 'projects_card_locale',
      desc: '',
      args: [],
    );
  }

  /// `Locale`
  String get project_locale {
    return Intl.message(
      'Locale',
      name: 'project_locale',
      desc: '',
      args: [],
    );
  }

  /// `Supported Locales`
  String get projects_card_locales {
    return Intl.message(
      'Supported Locales',
      name: 'projects_card_locales',
      desc: '',
      args: [],
    );
  }

  /// `Project Name`
  String get project_name {
    return Intl.message(
      'Project Name',
      name: 'project_name',
      desc: '',
      args: [],
    );
  }

  /// `Key`
  String get project_key {
    return Intl.message(
      'Key',
      name: 'project_key',
      desc: '',
      args: [],
    );
  }

  /// `Default Locale`
  String get project_default_locale {
    return Intl.message(
      'Default Locale',
      name: 'project_default_locale',
      desc: '',
      args: [],
    );
  }

  /// `Reload`
  String get error_reload {
    return Intl.message(
      'Reload',
      name: 'error_reload',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get save {
    return Intl.message(
      'Save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get close {
    return Intl.message(
      'Close',
      name: 'close',
      desc: '',
      args: [],
    );
  }

  /// `Save changes`
  String get save_data {
    return Intl.message(
      'Save changes',
      name: 'save_data',
      desc: '',
      args: [],
    );
  }

  /// `Discard`
  String get discard {
    return Intl.message(
      'Discard',
      name: 'discard',
      desc: '',
      args: [],
    );
  }

  /// `The form contains some unsaved changes.\nDo you want to save all entered data?`
  String get error_unsaved {
    return Intl.message(
      'The form contains some unsaved changes.\nDo you want to save all entered data?',
      name: 'error_unsaved',
      desc: '',
      args: [],
    );
  }

  /// `Project Settings`
  String get page_settings {
    return Intl.message(
      'Project Settings',
      name: 'page_settings',
      desc: '',
      args: [],
    );
  }

  /// `dublicate locale`
  String get error_locale_dublicate {
    return Intl.message(
      'dublicate locale',
      name: 'error_locale_dublicate',
      desc: '',
      args: [],
    );
  }

  /// `Locale {locale} from file {path} doesnt supported. Use name of file like 'intl_ko_KR.arb' or 'ko-KR.json' where 'ko' - target locale`
  String error_locale_notsupport(Object locale, Object path) {
    return Intl.message(
      'Locale $locale from file $path doesnt supported. Use name of file like \'intl_ko_KR.arb\' or \'ko-KR.json\' where \'ko\' - target locale',
      name: 'error_locale_notsupport',
      desc: '',
      args: [locale, path],
    );
  }

  /// `No name`
  String get project_name_no {
    return Intl.message(
      'No name',
      name: 'project_name_no',
      desc: '',
      args: [],
    );
  }

  /// `Project: {name}`
  String project_name_title(Object name) {
    return Intl.message(
      'Project: $name',
      name: 'project_name_title',
      desc: '',
      args: [name],
    );
  }

  /// `Add`
  String get project_add {
    return Intl.message(
      'Add',
      name: 'project_add',
      desc: '',
      args: [],
    );
  }

  /// `Export`
  String get project_export {
    return Intl.message(
      'Export',
      name: 'project_export',
      desc: '',
      args: [],
    );
  }

  /// `Import`
  String get project_import {
    return Intl.message(
      'Import',
      name: 'project_import',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get project_save {
    return Intl.message(
      'Save',
      name: 'project_save',
      desc: '',
      args: [],
    );
  }

  /// `Error`
  String get error_error {
    return Intl.message(
      'Error',
      name: 'error_error',
      desc: '',
      args: [],
    );
  }

  /// `Please, add new key for control Localizations of your app`
  String get project_empty {
    return Intl.message(
      'Please, add new key for control Localizations of your app',
      name: 'project_empty',
      desc: '',
      args: [],
    );
  }

  /// `Export settings`
  String get project_setting_export {
    return Intl.message(
      'Export settings',
      name: 'project_setting_export',
      desc: '',
      args: [],
    );
  }

  /// `Please add export setting`
  String get project_setting_export_empty {
    return Intl.message(
      'Please add export setting',
      name: 'project_setting_export_empty',
      desc: '',
      args: [],
    );
  }

  /// `Prefix`
  String get project_setting_prefix {
    return Intl.message(
      'Prefix',
      name: 'project_setting_prefix',
      desc: '',
      args: [],
    );
  }

  /// `Postfix`
  String get project_setting_postfix {
    return Intl.message(
      'Postfix',
      name: 'project_setting_postfix',
      desc: '',
      args: [],
    );
  }

  /// `Divider locale and country code`
  String get project_setting_divider {
    return Intl.message(
      'Divider locale and country code',
      name: 'project_setting_divider',
      desc: '',
      args: [],
    );
  }

  /// `File exteshion`
  String get project_setting_ext {
    return Intl.message(
      'File exteshion',
      name: 'project_setting_ext',
      desc: '',
      args: [],
    );
  }

  /// `Filter for supported locales`
  String get project_setting_filter {
    return Intl.message(
      'Filter for supported locales',
      name: 'project_setting_filter',
      desc: '',
      args: [],
    );
  }

  /// `Projects`
  String get projects_title {
    return Intl.message(
      'Projects',
      name: 'projects_title',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get projects_add {
    return Intl.message(
      'Add',
      name: 'projects_add',
      desc: '',
      args: [],
    );
  }

  /// `Show remove button`
  String get projects_show_remove {
    return Intl.message(
      'Show remove button',
      name: 'projects_show_remove',
      desc: '',
      args: [],
    );
  }

  /// `Import`
  String get projects_import {
    return Intl.message(
      'Import',
      name: 'projects_import',
      desc: '',
      args: [],
    );
  }

  /// `Please, add new project for control Localizations of your apps`
  String get projects_emprty {
    return Intl.message(
      'Please, add new project for control Localizations of your apps',
      name: 'projects_emprty',
      desc: '',
      args: [],
    );
  }

  /// `Remove`
  String get projects_remove {
    return Intl.message(
      'Remove',
      name: 'projects_remove',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get notif_ok {
    return Intl.message(
      'Ok',
      name: 'notif_ok',
      desc: '',
      args: [],
    );
  }

  /// `Text copied to buffer`
  String get notif_clipboard {
    return Intl.message(
      'Text copied to buffer',
      name: 'notif_clipboard',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get notif_update {
    return Intl.message(
      'Update',
      name: 'notif_update',
      desc: '',
      args: [],
    );
  }

  /// `Please, update to last version of the app`
  String get notif_need_update {
    return Intl.message(
      'Please, update to last version of the app',
      name: 'notif_need_update',
      desc: '',
      args: [],
    );
  }

  /// `Approve after import or change`
  String get edit_lang_approve {
    return Intl.message(
      'Approve after import or change',
      name: 'edit_lang_approve',
      desc: '',
      args: [],
    );
  }

  /// `Value of default locale was changed`
  String get edit_lang_changed {
    return Intl.message(
      'Value of default locale was changed',
      name: 'edit_lang_changed',
      desc: '',
      args: [],
    );
  }

  /// `copy`
  String get edit_lang_copy {
    return Intl.message(
      'copy',
      name: 'edit_lang_copy',
      desc: '',
      args: [],
    );
  }

  /// `paste`
  String get edit_lang_paste {
    return Intl.message(
      'paste',
      name: 'edit_lang_paste',
      desc: '',
      args: [],
    );
  }

  /// `value required`
  String get value_required {
    return Intl.message(
      'value required',
      name: 'value_required',
      desc: '',
      args: [],
    );
  }

  /// `429  for {text}`
  String translate_429(Object text) {
    return Intl.message(
      '429  for $text',
      name: 'translate_429',
      desc: '',
      args: [text],
    );
  }

  /// `Add formats in setting of project`
  String get error_formats {
    return Intl.message(
      'Add formats in setting of project',
      name: 'error_formats',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
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
      for (var supportedLocale in supportedLocales) {
        if (supportedLocale.languageCode == locale.languageCode) {
          return true;
        }
      }
    }
    return false;
  }
}
