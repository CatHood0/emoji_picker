import 'package:emoji_picker/src/data/sources/activity.dart';
import 'package:emoji_picker/src/data/sources/animals_and_nature.dart';
import 'package:emoji_picker/src/data/sources/flags.dart';
import 'package:emoji_picker/src/data/sources/food_and_drink.dart';
import 'package:emoji_picker/src/data/sources/objects.dart';
import 'package:emoji_picker/src/data/sources/people.dart';
import 'package:emoji_picker/src/data/sources/symbols.dart';
import 'package:emoji_picker/src/data/sources/travel_and_places.dart';

final commonEmojis = [
  ...activityEmojis,
  ...animalsAndNatureEmojis,
  ...flagsEmojis,
  ...foodAndDrinkEmojis,
  ...objectEmojis,
  ...peopleEmojis,
  ...symbolsEmojis,
  ...travelAndPlacesEmojis
];
