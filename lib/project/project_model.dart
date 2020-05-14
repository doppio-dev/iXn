import 'dart:convert';

import 'package:archive/archive.dart';
import 'package:equatable/equatable.dart';
import 'package:file_manager/file_manager.dart' as manager;
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

import 'package:doppio_dev_ixn/core/index.dart';
import 'package:doppio_dev_ixn/service/index.dart';

class LocaleModel extends Equatable {
  final String countryName;
  final String locale;
  final String countryCode;
  String get key => '$locale-$countryCode';
  LocaleModel({
    this.countryName,
    this.locale,
    this.countryCode,
  });

  @override
  List<Object> get props => [
        countryName,
        locale,
        countryCode,
      ];

  Map<String, dynamic> toMap() {
    return {
      'countryName': countryName,
      'locale': locale,
      'countryCode': countryCode,
    };
  }

  static LocaleModel fromMap(Map<dynamic, dynamic> map) {
    if (map == null) return null;

    return LocaleModel(
      countryName: map['countryName']?.toString(),
      locale: map['locale']?.toString(),
      countryCode: map['countryCode']?.toString(),
    );
  }

  String toJson() => json.encode(toMap());

  static LocaleModel fromJson(String source) => fromMap(json.decode(source) as Map<dynamic, dynamic>);

  static LocaleModel from(MapEntry<String, String> localeCode) {
    final split = localeCode.value.split('-');
    return LocaleModel(countryName: localeCode.key, locale: split[0], countryCode: split[1]);
  }

  @override
  String toString() => '$countryName: $locale-$countryCode';
}

class ExportFormatModel extends Equatable {
  String prefix;
  String postfix;
  String divider;
  String fileExtension;
  ExportFormatModel({
    this.prefix,
    this.postfix,
    this.divider,
    this.fileExtension,
  });

  Map<String, dynamic> toMap() {
    return {
      'prefix': prefix,
      'postfix': postfix,
      'divider': divider,
      'fileExtension': fileExtension,
    };
  }

  static ExportFormatModel fromMap(Map<dynamic, dynamic> map) {
    if (map == null) return null;

    return ExportFormatModel(
      prefix: map['prefix']?.toString(),
      postfix: map['postfix']?.toString(),
      divider: map['divider']?.toString(),
      fileExtension: map['fileExtension']?.toString(),
    );
  }

  String toJson() => json.encode(toMap());

  static ExportFormatModel fromJson(String source) => fromMap(json.decode(source) as Map<dynamic, dynamic>);

  @override
  List<Object> get props => [
        prefix,
        postfix,
        divider,
        fileExtension,
      ];
}

class ProjectModel extends Equatable {
  final String id;
  String name;
  List<LocaleModel> locales;
  LocaleModel defaultLocale;
  LocaleModel selectedEditLocale;
  final List<KeyModel> keys;
  List<WordModel> words;
  List<ExportFormatModel> formats;
  Map<String, WordModel> wordMap;

  ProjectModel({
    @required this.id,
    this.name,
    this.keys,
    this.locales,
    this.defaultLocale,
    this.selectedEditLocale,
    this.words,
    this.formats,
  }) {
    wordMap = {};
    if (words != null) {
      for (var item in words) {
        wordMap['${item.keyDiff}'] = item;
      }
    }
  }

  @override
  List<Object> get props => [
        id,
        name,
        keys,
        locales,
        defaultLocale,
        selectedEditLocale,
        words,
        formats,
      ];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'keys': keys?.map((x) => x?.toMap())?.toList(),
      'formats': formats?.map((x) => x?.toMap())?.toList(),
      'locales': locales?.map((x) => x?.toMap())?.toList(),
      'selectedEditLocale': selectedEditLocale?.toMap(),
      'defaultLocale': defaultLocale?.toMap(),
      'words': words?.map((x) => x?.toMap())?.toList(),
    };
  }

  static ProjectModel fromMap(Map<dynamic, dynamic> map) {
    if (map == null) return null;

    return ProjectModel(
      id: map['id']?.toString(),
      name: map['name']?.toString(),
      defaultLocale: LocaleModel.fromMap(map['defaultLocale'] as Map<dynamic, dynamic>),
      selectedEditLocale: LocaleModel.fromMap(map['selectedEditLocale'] as Map<dynamic, dynamic>),
      locales: List<LocaleModel>.from((map['locales'] as List<dynamic> ?? [])?.map((c) => LocaleModel.fromMap(c as Map<dynamic, dynamic>))),
      formats:
          List<ExportFormatModel>.from((map['formats'] as List<dynamic> ?? [])?.map((c) => ExportFormatModel.fromMap(c as Map<dynamic, dynamic>))),
      keys: List<KeyModel>.from((map['keys'] as List<dynamic> ?? [])?.map((c) => KeyModel.fromMap(c as Map<dynamic, dynamic>))),
      words: List<WordModel>.from((map['words'] as List<dynamic> ?? [])?.map((c) => WordModel.fromMap(c as Map<dynamic, dynamic>))),
    );
  }

  String toJson() => json.encode(toMap());

  static ProjectModel fromJson(String source) => fromMap(json.decode(source) as Map<dynamic, dynamic>);

  ProjectModel copyWith({
    String id,
    String name,
    List<LocaleModel> locales,
    LocaleModel defaultLocale,
    LocaleModel selectedEditLocale,
    List<KeyModel> keys,
    List<WordModel> words,
    List<ExportFormatModel> formats,
  }) {
    return ProjectModel(
      id: id ?? this.id,
      name: name ?? this.name,
      locales: locales != null
          ? locales.map((e) => LocaleModel.fromMap(e.toMap())).toList()
          : this.locales.map((e) => LocaleModel.fromMap(e.toMap())).toList(),
      defaultLocale: defaultLocale ?? this.defaultLocale,
      selectedEditLocale: selectedEditLocale ?? this.selectedEditLocale,
      keys: keys ?? this.keys.map((e) => KeyModel.fromMap(e.toMap())).toList(),
      words: words ?? this.words.map((e) => WordModel.fromMap(e.toMap())).toList(),
      formats: formats ?? this.formats.map((e) => ExportFormatModel.fromMap(e.toMap())).toList(),
    );
  }

  ProjectModel copySettings({
    @required String name,
    @required List<LocaleModel> locales,
    @required LocaleModel defaultLocale,
    @required List<ExportFormatModel> formats,
  }) {
    return ProjectModel(
      id: id,
      name: name ?? this.name,
      locales: locales != null
          ? locales.map((e) => LocaleModel.fromMap(e.toMap())).toList()
          : this.locales.map((e) => LocaleModel.fromMap(e.toMap())).toList(),
      defaultLocale: defaultLocale ?? this.defaultLocale,
      keys: keys,
      words: words,
      selectedEditLocale: selectedEditLocale,
      formats: formats ?? this.formats.map((e) => ExportFormatModel.fromMap(e.toMap())).toList(),
    );
  }

  void import(LocaleModel locale, Map<String, String> filesData) {
    defaultLocale ??= locale;
    if (!locales.contains(locale)) {
      locales.add(locale);
    }
    for (var item in filesData.keys) {
      var key = keys.firstWhere((element) => element.value == item, orElse: () => null);
      if (key == null) {
        key = KeyModel(id: Uuid().v4(), value: item);
        keys.add(key);
      }
      final newKeyDiff = '${key.id}${locale.key}';
      if (wordMap.containsKey(newKeyDiff)) {
        // TODO: version for approve changed
        wordMap[newKeyDiff].value = filesData[item];
      } else {
        final newWord = WordModel(id: Uuid().v4(), keyId: key.id, locale: locale, value: filesData[item]);
        wordMap[newKeyDiff] = newWord;
        words.add(newWord);
      }
    }
  }

  Future export() async {
    try {
      if (formats == null || formats.isEmpty) {
        throw Exception(TranslateService().locale.error_formats);
      }
      var index = 0;
      for (var format in formats) {
        var encoder = ZipEncoder();
        final archive = Archive();
        for (var locale in locales) {
          final mapWord = <String, String>{};
          final result = <String, String>{};
          words.where((c) => c.locale == locale).map((e) => mapWord[e.keyId] = e.value).toList();
          for (var item in keys) {
            // TODO: check - maybe will give bug
            result['"${item.value}"'] = '"${mapWord[item.id].replaceAll('\r', '\\r').replaceAll('\n', '\\n')}"';
          }
          final bytes = Utf8Codec().encode(result.toString());
          final fileName =
              '${format.prefix ?? ''}${locale.locale}${format.divider ?? ''}${locale.countryCode}${format.postfix ?? ''}.${format.fileExtension}';
          final archiveFile = ArchiveFile(fileName, bytes.length, bytes);
          archive.addFile(archiveFile);
        }
        final bytes = Utf8Codec().encode(toJson());
        final archiveFile = ArchiveFile('ixn.json', bytes.length, bytes);
        archive.addFile(archiveFile);
        final bytesZip = encoder.encode(archive);
        await manager.saveFile('$name-ixn-$index.zip', binaryData: bytesZip);
        index++;
      }
      // projectScreen.import(filesData);
    } catch (_, stackTrace) {
      log(_?.toString(), name: 'ProjectsPage', error: _, stackTrace: stackTrace);
      NotificationService.showError(_?.toString());
    }
  }

  WordModel getWord(String newkey, KeyModel key, LocaleModel locale) {
    if (wordMap.containsKey(newkey)) {
      return wordMap[newkey];
    }
    final newWord = WordModel(id: Uuid().v4(), keyId: key.id, locale: locale);
    words ??= [];
    words.add(newWord);
    wordMap[newkey] = newWord;
    return newWord;
  }
}

class KeyModel extends Equatable {
  final String id;
  String value;

  KeyModel({
    this.id,
    this.value,
  });

  @override
  List<Object> get props => [
        id,
        value,
      ];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'value': value,
    };
  }

  static KeyModel fromMap(Map<dynamic, dynamic> map) {
    if (map == null) return null;

    return KeyModel(
      id: map['id']?.toString(),
      value: map['value']?.toString(),
    );
  }

  String toJson() => json.encode(toMap());

  static KeyModel fromJson(String source) => fromMap(json.decode(source) as Map<dynamic, dynamic>);

  KeyModel copyWith({
    String id,
    String value,
  }) {
    return KeyModel(
      id: id ?? this.id,
      value: value ?? this.value,
    );
  }
}

class WordModel extends Equatable {
  final String id;
  final int order;
  final int maxLength;
  final String keyId;
  final LocaleModel locale;
  String value;

  /// for compare when differen values current and import. (must be null)
  String valueNewVersion;

  /// value from default for compare
  String origin;

  final bool approved;

  //use like this and dont translate
  final bool staticTranslate;
  final List<ImageModel> images;
  final String notes;

  String get keyDiff => '$keyId${locale.key}';

  WordModel({
    @required this.id,
    this.order,
    this.maxLength,
    this.keyId,
    this.locale,
    this.value,
    this.origin,
    this.valueNewVersion,
    this.approved,
    this.staticTranslate,
    this.images,
    this.notes,
  });

  @override
  List<Object> get props => [
        id,
        order,
        maxLength,
        keyId,
        locale,
        value,
        origin,
        valueNewVersion,
        approved,
        staticTranslate,
        images,
        notes,
      ];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'order': order,
      'maxLength': maxLength,
      'key': keyId,
      'locale': locale.toMap(),
      'value': value,
      'origin': origin,
      'valueNewVersion': valueNewVersion,
      'approved': approved,
      'staticTranslate': staticTranslate,
      'images': images?.map((x) => x?.toMap())?.toList(),
      'notes': notes,
    };
  }

  static WordModel fromMap(Map<dynamic, dynamic> map) {
    if (map == null) return null;

    return WordModel(
      id: map['id']?.toString(),
      order: map['order'] as int,
      maxLength: map['maxLength'] as int,
      keyId: map['key']?.toString(),
      locale: LocaleModel.fromMap(map['locale'] as Map<dynamic, dynamic>),
      value: map['value']?.toString(),
      origin: map['origin']?.toString(),
      valueNewVersion: map['valueNewVersion']?.toString(),
      approved: map['approved'] as bool,
      staticTranslate: map['staticTranslate'] as bool,
      images: List<ImageModel>.from(((map['images'] as List<dynamic> ?? []).cast<Map<dynamic, dynamic>>() ?? [])?.map(ImageModel.fromMap)),
      notes: map['notes']?.toString(),
    );
  }

  String toJson() => json.encode(toMap());

  static WordModel fromJson(String source) => fromMap(json.decode(source) as Map<dynamic, dynamic>);

  WordModel copyWith({
    String id,
    int order,
    int maxLength,
    String keyId,
    LocaleModel locale,
    String value,
    String origin,
    String valueNewVersion,
    bool approved,
    bool staticTranslate,
    List<ImageModel> images,
    String notes,
  }) {
    return WordModel(
      id: id ?? this.id,
      order: order ?? this.order,
      maxLength: maxLength ?? this.maxLength,
      keyId: keyId ?? this.keyId,
      locale: locale ?? this.locale,
      value: value ?? this.value,
      origin: origin ?? this.origin,
      valueNewVersion: valueNewVersion ?? this.valueNewVersion,
      approved: approved ?? this.approved,
      staticTranslate: staticTranslate ?? this.staticTranslate,
      images: images ?? this.images,
      notes: notes ?? this.notes,
    );
  }
}

class ImageModel extends Equatable {
  final String id;
  final String url;
  final String notes;
  ImageModel({
    this.id,
    this.url,
    this.notes,
  });

  @override
  List<Object> get props => [
        id,
        url,
        notes,
      ];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'url': url,
      'notes': notes,
    };
  }

  static ImageModel fromMap(Map<dynamic, dynamic> map) {
    if (map == null) return null;

    return ImageModel(
      id: map['id']?.toString(),
      url: map['url']?.toString(),
      notes: map['notes']?.toString(),
    );
  }

  String toJson() => json.encode(toMap());

  static ImageModel fromJson(String source) => fromMap(json.decode(source) as Map<dynamic, dynamic>);

  ImageModel copyWith({
    String id,
    String url,
    String notes,
  }) {
    return ImageModel(
      id: id ?? this.id,
      url: url ?? this.url,
      notes: notes ?? this.notes,
    );
  }
}
