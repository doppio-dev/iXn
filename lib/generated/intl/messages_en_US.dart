// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en_US locale. All the
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
  String get localeName => 'en_US';

  static m0(locale, path) =>
      "Locale ${locale} from file ${path} doesnt supported. Use name of file like \'intl_ko_KR.arb\' or \'ko-KR.json\' where \'ko\' - target locale";

  static m1(name) => "Project: ${name}";

  static m2(text) => "429  for ${text}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function>{
        "close": MessageLookupByLibrary.simpleMessage("Close"),
        "discard": MessageLookupByLibrary.simpleMessage("Discard"),
        "edit_lang_approve": MessageLookupByLibrary.simpleMessage("Approve after import or change"),
        "edit_lang_changed": MessageLookupByLibrary.simpleMessage("Value of default locale was changed"),
        "error_error": MessageLookupByLibrary.simpleMessage("Error"),
        "error_formats": MessageLookupByLibrary.simpleMessage("Add formats in setting of project"),
        "error_locale_dublicate": MessageLookupByLibrary.simpleMessage("dublicate locale"),
        "error_locale_notsupport": m0,
        "error_reload": MessageLookupByLibrary.simpleMessage("Reload"),
        "error_unsaved": MessageLookupByLibrary.simpleMessage("The form contains some unsaved changes.\r\nDo you want to save all entered data?"),
        "notif_need_update": MessageLookupByLibrary.simpleMessage("Please, update to last version fo the app"),
        "notif_ok": MessageLookupByLibrary.simpleMessage("Ok"),
        "notif_update": MessageLookupByLibrary.simpleMessage("Update"),
        "page_settings": MessageLookupByLibrary.simpleMessage("Project Settings"),
        "project_add": MessageLookupByLibrary.simpleMessage("Add"),
        "project_default_locale": MessageLookupByLibrary.simpleMessage("Default Locale"),
        "project_empty": MessageLookupByLibrary.simpleMessage("Please, add new key for control Localizations of your app"),
        "project_export": MessageLookupByLibrary.simpleMessage("Export"),
        "project_import": MessageLookupByLibrary.simpleMessage("Import"),
        "project_key": MessageLookupByLibrary.simpleMessage("Key"),
        "project_locale": MessageLookupByLibrary.simpleMessage("Locale"),
        "project_name": MessageLookupByLibrary.simpleMessage("Project Name"),
        "project_name_no": MessageLookupByLibrary.simpleMessage("No name"),
        "project_name_title": m1,
        "project_save": MessageLookupByLibrary.simpleMessage("Save"),
        "project_setting_divider": MessageLookupByLibrary.simpleMessage("Divider locale and country code"),
        "project_setting_export": MessageLookupByLibrary.simpleMessage("Export settings"),
        "project_setting_export_empty": MessageLookupByLibrary.simpleMessage("Please add export setting"),
        "project_setting_ext": MessageLookupByLibrary.simpleMessage("File exteshion"),
        "project_setting_filter": MessageLookupByLibrary.simpleMessage("Filter for supported locales"),
        "project_setting_postfix": MessageLookupByLibrary.simpleMessage("Postfix"),
        "project_setting_prefix": MessageLookupByLibrary.simpleMessage("Prefix"),
        "projects_add": MessageLookupByLibrary.simpleMessage("Add"),
        "projects_card_locale": MessageLookupByLibrary.simpleMessage("Locale"),
        "projects_card_locales": MessageLookupByLibrary.simpleMessage("Supported Locales"),
        "projects_card_name": MessageLookupByLibrary.simpleMessage("Name"),
        "projects_emprty": MessageLookupByLibrary.simpleMessage("Please, add new project for control Localizations of your apps"),
        "projects_import": MessageLookupByLibrary.simpleMessage("Import"),
        "projects_remove": MessageLookupByLibrary.simpleMessage("Remove"),
        "projects_show_remove": MessageLookupByLibrary.simpleMessage("Show remove button"),
        "projects_title": MessageLookupByLibrary.simpleMessage("Projects"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "save_data": MessageLookupByLibrary.simpleMessage("Save changes"),
        "translate_429": m2,
        "value_required": MessageLookupByLibrary.simpleMessage("value required")
      };
}
