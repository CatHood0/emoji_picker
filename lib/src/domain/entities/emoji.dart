import 'package:flutter/foundation.dart';

class Emoji {
  final List<String> keywords;
  final String emoji;
  final String category;
  final bool fitzpatrickScale;
  Emoji({
    required this.keywords,
    required this.emoji,
    required this.category,
    required this.fitzpatrickScale,
  });

  factory Emoji.fromJson(Map<String, dynamic> json) {
    return Emoji(
      keywords:
          (json['keywords'] as List<dynamic>).map((e) => e as String).toList(),
      emoji: json['char'] as String,
      fitzpatrickScale: json['fitzpatrick_scale'] as bool,
      category: json['category'] as String,
    );
  }
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'keywords': keywords,
      'char': emoji,
      'fitzpatrick_scale': fitzpatrickScale,
      'category': category,
    };
  }

  Emoji copyWith({
    List<String>? keywords,
    String? emoji,
    String? category,
    bool? fitzpatrickScale,
  }) {
    return Emoji(
      keywords: keywords ?? this.keywords,
      emoji: emoji ?? this.emoji,
      category: category ?? this.category,
      fitzpatrickScale: fitzpatrickScale ?? this.fitzpatrickScale,
    );
  }

  @override
  bool operator ==(covariant Emoji other) {
    if (identical(this, other)) return true;

    return listEquals(other.keywords, keywords) &&
        other.emoji == emoji &&
        other.category == category &&
        other.fitzpatrickScale == fitzpatrickScale;
  }

  @override
  int get hashCode {
    return keywords.hashCode ^
        emoji.hashCode ^
        category.hashCode ^
        fitzpatrickScale.hashCode;
  }
}
