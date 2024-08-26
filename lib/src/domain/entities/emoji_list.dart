import 'package:flutter/foundation.dart';
import 'package:flutter_emoji_picker/src/domain/entities/entities.dart';
import 'emoji.dart';

class EmojisManager {
  final Map<String, List<Emoji>> emojis;
  EmojisManager({
    required this.emojis,
  });

  EmojisManager copyWith({
    Map<String, List<Emoji>>? emojis,
  }) {
    return EmojisManager(
      emojis: emojis ?? this.emojis,
    );
  }

  factory EmojisManager.empty() {
    return EmojisManager(emojis: {});
  }

  @override
  String toString() => 'EmojisManager(emojis: $emojis)';

  @override
  bool operator ==(covariant EmojisManager other) {
    if (identical(this, other)) return true;

    return mapEquals(other.emojis, emojis);
  }

  @override
  int get hashCode => emojis.hashCode;
}
