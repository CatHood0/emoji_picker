import 'package:flutter_emoji_picker/src/data/sources/common_emojis.dart';
import '../entities/entities.dart';

final Map<String, List<Emoji>> _defaultEmojis = Map.unmodifiable(commonEmojis);

class EmojiRepository {
  Future<EmojisManager> getEmojis() async {
    return EmojisManager(
      emojis: _defaultEmojis,
    );
  }

  Future<Map<String, List<Emoji>>> findEmoji(String filter) async {
    if (filter.isEmpty) {
      return _defaultEmojis;
    }
    final filteredEmojis = <String, List<Emoji>>{};
    filteredEmojis.addAll(
      _defaultEmojis.map(
        (key, value) {
          return MapEntry(
            key,
            value
                .where(
                  (emoji) => emoji.keywords.contains(
                    filter.toLowerCase(),
                  ),
                )
                .toList(),
          );
        },
      ),
    );
    return filteredEmojis;
  }
}
