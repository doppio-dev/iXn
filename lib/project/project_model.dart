import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class ProjectModel extends Equatable {
  final String id;
  final String name;
  final List<String> locales;
  final String defaultLocale;
  final List<KeyModel> keys;
  final List<WordModel> words;
  Map<String, WordModel> wordMap;

  ProjectModel({
    @required this.id,
    this.name,
    this.keys,
    this.locales,
    this.defaultLocale,
    this.words,
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
        words,
      ];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'keys': keys?.map((x) => x?.toMap())?.toList(),
      'locales': locales,
      'defaultLocale': defaultLocale,
      'words': words?.map((x) => x?.toMap())?.toList(),
    };
  }

  static ProjectModel fromMap(Map<dynamic, dynamic> map) {
    if (map == null) return null;

    return ProjectModel(
      id: map['id']?.toString(),
      name: map['name']?.toString(),
      locales: List<String>.from(map['locales'] as Iterable<dynamic> ?? []),
      defaultLocale: map['defaultLocale']?.toString(),
      keys: List<KeyModel>.from((map['keys'] as List<dynamic> ?? [])?.map((c) => KeyModel.fromMap(c as Map<dynamic, dynamic>))),
      words: List<WordModel>.from((map['words'] as List<dynamic> ?? [])?.map((c) => WordModel.fromMap(c as Map<dynamic, dynamic>))),
    );
  }

  String toJson() => json.encode(toMap());

  static ProjectModel fromJson(String source) => fromMap(json.decode(source) as Map<dynamic, dynamic>);

  ProjectModel copyWith({
    String id,
    String name,
    List<String> locales,
    String defaultLocale,
    List<KeyModel> keys,
    List<WordModel> words,
  }) {
    return ProjectModel(
      id: id ?? this.id,
      name: name ?? this.name,
      locales: locales != null ? [...locales] : [...this.locales ?? []],
      defaultLocale: defaultLocale ?? this.defaultLocale,
      keys: keys ?? this.keys,
      words: words ?? this.words,
    );
  }
}

class KeyModel extends Equatable {
  final String id;
  final String value;

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
  final String locale;
  final String value;
  final bool approved;
  final bool auto;

  //use like this and dont translate
  final bool staticTranslate;
  final List<ImageModel> images;
  final String notes;

  String get keyDiff => '$keyId$locale';

  WordModel({
    @required this.id,
    this.order,
    this.maxLength,
    this.keyId,
    this.locale,
    this.value,
    this.approved,
    this.auto,
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
        approved,
        auto,
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
      'locale': locale,
      'value': value,
      'approved': approved,
      'auto': auto,
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
      locale: map['locale']?.toString(),
      value: map['value']?.toString(),
      approved: map['approved'] as bool,
      auto: map['auto'] as bool,
      staticTranslate: map['staticTranslate'] as bool,
      images: List<ImageModel>.from((map['images'] as List<Map<dynamic, dynamic>>)?.map(ImageModel.fromMap)),
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
    String locale,
    String value,
    bool approved,
    bool auto,
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
      approved: approved ?? this.approved,
      auto: auto ?? this.auto,
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
