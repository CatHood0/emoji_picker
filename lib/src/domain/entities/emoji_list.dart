import 'package:emoji_picker/src/domain/entities/entities.dart';
import 'package:flutter/foundation.dart';
import 'emoji.dart';

class EmojisManager {
  final List<Emoji> emojis;
  EmojisManager({
    required this.emojis,
  });

  EmojisManager copyWith({
    List<Emoji>? emojis,
  }) {
    return EmojisManager(
      emojis: emojis ?? this.emojis,
    );
  }

  factory EmojisManager.empty() {
    return EmojisManager(emojis: []);
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'emojis': emojis.map((x) => x.toJson()).toList(),
    };
  }

  factory EmojisManager.fromJson(Map<String, dynamic> map) {
    return EmojisManager(
      emojis: List<Emoji>.from(
        (map['emojis']).map<Emoji>(
          (x) => Emoji.fromJson(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  @override
  String toString() => 'EmojisManager(emojis: $emojis)';

  @override
  bool operator ==(covariant EmojisManager other) {
    if (identical(this, other)) return true;

    return listEquals(other.emojis, emojis);
  }

  @override
  int get hashCode => emojis.hashCode;
}
