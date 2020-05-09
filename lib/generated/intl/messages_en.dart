// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function>{
        "close": MessageLookupByLibrary.simpleMessage("Close"),
        "discard": MessageLookupByLibrary.simpleMessage("Discard"),
        "error_reload": MessageLookupByLibrary.simpleMessage("Reload"),
        "error_unsaved": MessageLookupByLibrary.simpleMessage("The form contains some unsaved changes.\r\nDo you want to save all entered data?"),
        "page_settings": MessageLookupByLibrary.simpleMessage("Project Settings"),
        "project_default_locale": MessageLookupByLibrary.simpleMessage("Default Locale"),
        "project_key": MessageLookupByLibrary.simpleMessage("Key"),
        "project_name": MessageLookupByLibrary.simpleMessage("Project Name"),
        "projects_card_locale": MessageLookupByLibrary.simpleMessage("Locale"),
        "projects_card_locales": MessageLookupByLibrary.simpleMessage("Supported Locales"),
        "projects_card_name": MessageLookupByLibrary.simpleMessage("Name"),
        "save": MessageLookupByLibrary.simpleMessage("Save"),
        "save_data": MessageLookupByLibrary.simpleMessage("Save changes")
      };
}
