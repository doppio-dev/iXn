import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class ProjectModel extends Equatable {
  final String id;
  final String name;
  final List<String> locales;
  final String defaultLocale;
  final List<WordModel> words;
  ProjectModel({
    @required this.id,
    this.name,
    this.locales,
    this.defaultLocale,
    this.words,
  });

  @override
  List<Object> get props => [
        id,
        name,
        locales,
        defaultLocale,
        words,
      ];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
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
      words: List<WordModel>.from((map['words'] as List<Map<dynamic, dynamic>> ?? [])?.map(WordModel.fromMap)),
    );
  }

  String toJson() => json.encode(toMap());

  static ProjectModel fromJson(String source) => fromMap(json.decode(source) as Map<dynamic, dynamic>);

  ProjectModel copyWith({
    String id,
    String name,
    List<String> locales,
    String defaultLocale,
    List<WordModel> words,
  }) {
    return ProjectModel(
      id: id ?? this.id,
      name: name ?? this.name,
      locales: locales ?? this.locales,
      defaultLocale: defaultLocale ?? this.defaultLocale,
      words: words ?? this.words,
    );
  }
}

class WordModel extends Equatable {
  final String id;
  final int order;
  final int maxLength;
  final String key;
  final String locale;
  final String value;
  final bool approved;
  final bool auto;

  //use like this and dont translate
  final bool staticTranslate;
  final List<ImageModel> images;
  final String notes;

  String get keyDiff => '$key$locale';

  WordModel({
    this.id,
    this.order,
    this.maxLength,
    this.key,
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
        key,
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
      'key': key,
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
      key: map['key']?.toString(),
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
    String key,
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
      key: key ?? this.key,
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
