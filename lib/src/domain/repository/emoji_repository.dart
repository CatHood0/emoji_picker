import 'package:emoji_dialog_picker/src/data/sources/activity.dart';
import 'package:emoji_dialog_picker/src/data/sources/animals_and_nature.dart';
import 'package:emoji_dialog_picker/src/data/sources/common_emojis.dart';
import 'package:emoji_dialog_picker/src/data/sources/flags.dart';
import 'package:emoji_dialog_picker/src/data/sources/food_and_drink.dart';
import 'package:emoji_dialog_picker/src/data/sources/objects.dart';
import 'package:emoji_dialog_picker/src/data/sources/people.dart';
import 'package:emoji_dialog_picker/src/data/sources/symbols.dart';
import 'package:emoji_dialog_picker/src/data/sources/travel_and_places.dart';
import '../entities/entities.dart';

class EmojiRepository {
  EmojiType lastTypeEmoji = EmojiType.unknown;

  Future<EmojisManager> getEmojis(EmojiType emojiType) async {
    lastTypeEmoji = emojiType;
    final values = _mapEmojiTypeToEmojiFile(emojiType);
    return EmojisManager(
      emojis: values,
    );
  }

  Future<List<Emoji>> findEmoji(String filter) async {
    if (filter.isEmpty) {
      return _mapEmojiTypeToEmojiFile(lastTypeEmoji);
    }

    return commonEmojis
        .where((emoji) => emoji.keywords.contains(filter.toLowerCase()))
        .toList();
  }

  List<Emoji> _mapEmojiTypeToEmojiFile(EmojiType emojiType) {
    if (emojiType == EmojiType.activity) {
      return activityEmojis;
    } else if (emojiType == EmojiType.animalsAndNature) {
      return animalsAndNatureEmojis;
    } else if (emojiType == EmojiType.flags) {
      return flagsEmojis;
    } else if (emojiType == EmojiType.foodAndDrink) {
      return foodAndDrinkEmojis;
    } else if (emojiType == EmojiType.objects) {
      return objectEmojis;
    } else if (emojiType == EmojiType.people) {
      return peopleEmojis;
    } else if (emojiType == EmojiType.symbols) {
      return symbolsEmojis;
    } else if (emojiType == EmojiType.travelsAndPlaces) {
      return travelAndPlacesEmojis;
    } else {
      return commonEmojis;
    }
  }
}
