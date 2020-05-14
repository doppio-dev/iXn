// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ru_RU locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ru_RU';

  static m0(locale, path) =>
      "Язык ${locale} из файла ${path} не поддерживается. Используйте имя файла, как «intl_ko_KR.arb» или «ко-KR.json», где «ко» - целевой язык";

  static m1(name) => "Проект: ${name}";

  static m2(text) => "Ошибка 429 для ${text}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function>{
        "close": MessageLookupByLibrary.simpleMessage("Закрыть"),
        "discard": MessageLookupByLibrary.simpleMessage("Отклонить"),
        "edit_lang_approve": MessageLookupByLibrary.simpleMessage("Подтвердить после импорта или изменений"),
        "edit_lang_changed": MessageLookupByLibrary.simpleMessage("Значение по умолчанию локали было изменено"),
        "error_error": MessageLookupByLibrary.simpleMessage("Ошибка"),
        "error_formats": MessageLookupByLibrary.simpleMessage("Добавить форматы в настройках проекта"),
        "error_locale_dublicate": MessageLookupByLibrary.simpleMessage("Дублирование локали"),
        "error_locale_notsupport": m0,
        "error_reload": MessageLookupByLibrary.simpleMessage("Перегрузить"),
        "error_unsaved": MessageLookupByLibrary.simpleMessage("Форма содержит неесохраненные данные, сохрать данные?"),
        "notif_clipboard": MessageLookupByLibrary.simpleMessage("Текст скопирован в буфер"),
        "notif_need_update": MessageLookupByLibrary.simpleMessage("Пожалуйста, обновление до последней версии приложения"),
        "notif_ok": MessageLookupByLibrary.simpleMessage("Ок"),
        "notif_update": MessageLookupByLibrary.simpleMessage("Обновить"),
        "page_settings": MessageLookupByLibrary.simpleMessage("Настройки проекта"),
        "project_add": MessageLookupByLibrary.simpleMessage("Добавить"),
        "project_default_locale": MessageLookupByLibrary.simpleMessage("Локализация по умолчанию"),
        "project_empty": MessageLookupByLibrary.simpleMessage("Пожалуйста, добавьте новый ключ для управления локализаций вашего приложения"),
        "project_export": MessageLookupByLibrary.simpleMessage("Экспорт"),
        "project_import": MessageLookupByLibrary.simpleMessage("Импорт"),
        "project_key": MessageLookupByLibrary.simpleMessage("Ключ"),
        "project_locale": MessageLookupByLibrary.simpleMessage("Локализация"),
        "project_name": MessageLookupByLibrary.simpleMessage("Название проекта"),
        "project_name_no": MessageLookupByLibrary.simpleMessage("Без имени"),
        "project_name_title": m1,
        "project_save": MessageLookupByLibrary.simpleMessage("Сохранить"),
        "project_setting_divider": MessageLookupByLibrary.simpleMessage("Разделитель между языком и страной"),
        "project_setting_export": MessageLookupByLibrary.simpleMessage("Настройки экспорта"),
        "project_setting_export_empty": MessageLookupByLibrary.simpleMessage("Пожалуйста, добавьте настройки экспорта"),
        "project_setting_ext": MessageLookupByLibrary.simpleMessage("Расширений файла"),
        "project_setting_filter": MessageLookupByLibrary.simpleMessage("Фильтр для поддерживаемых локалей"),
        "project_setting_postfix": MessageLookupByLibrary.simpleMessage("Postfix"),
        "project_setting_prefix": MessageLookupByLibrary.simpleMessage("Prefix"),
        "projects_add": MessageLookupByLibrary.simpleMessage("Добавить"),
        "projects_card_locale": MessageLookupByLibrary.simpleMessage("Локализация"),
        "projects_card_locales": MessageLookupByLibrary.simpleMessage("Локализаций"),
        "projects_card_name": MessageLookupByLibrary.simpleMessage("Название"),
        "projects_emprty": MessageLookupByLibrary.simpleMessage("Пожалуйста, добавьте новый проект для управления локализаций ваших приложений"),
        "projects_import": MessageLookupByLibrary.simpleMessage("Импортировать"),
        "projects_remove": MessageLookupByLibrary.simpleMessage("Удалить"),
        "projects_show_remove": MessageLookupByLibrary.simpleMessage("Показать кнопку удалить"),
        "projects_title": MessageLookupByLibrary.simpleMessage("Проекты"),
        "save": MessageLookupByLibrary.simpleMessage("Сохранить"),
        "save_data": MessageLookupByLibrary.simpleMessage("Сохранить изменения"),
        "translate_429": m2,
        "value_required": MessageLookupByLibrary.simpleMessage("Обязательно к заполнению")
      };
}
