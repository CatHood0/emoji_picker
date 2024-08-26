import 'package:flutter_emoji_picker/src/data/sources/activity.dart';
import 'package:flutter_emoji_picker/src/data/sources/animals_and_nature.dart';
import 'package:flutter_emoji_picker/src/data/sources/flags.dart';
import 'package:flutter_emoji_picker/src/data/sources/food_and_drink.dart';
import 'package:flutter_emoji_picker/src/data/sources/objects.dart';
import 'package:flutter_emoji_picker/src/data/sources/people.dart';
import 'package:flutter_emoji_picker/src/data/sources/symbols.dart';
import 'package:flutter_emoji_picker/src/data/sources/travel_and_places.dart';

import '../../domain/entities/entities.dart';

final Map<String, List<Emoji>> commonEmojis = <String, List<Emoji>>{
  'People': [
    ...peopleEmojis,
  ],
  'Nature': [
    ...animalsAndNatureEmojis,
  ],
  'Food': [
    ...foodAndDrinkEmojis,
  ],
  'Activity': [
    ...activityEmojis,
  ],
  'Places': [
    ...travelAndPlacesEmojis,
  ],
  'Objects': [
    ...objectEmojis,
  ],
  'Symbols': [
    ...symbolsEmojis,
  ],
  'Flags': [
    ...flagsEmojis,
  ]
};
