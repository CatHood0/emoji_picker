# Flutter Emoji Picker

**Flutter Emoji picker** makes more easy select emojis from any platform using different types of picker.

![Emoji bottom sheet picker option preview](https://github.com/CatHood0/resources/blob/Main/emoji_picker/bottomsheet_preview.png)
![Emoji dialog picker option preview](https://github.com/CatHood0/resources/blob/Main/emoji_picker/dialog_preview.png)

## Usage

### Import the Package
```dart
import 'package:flutter_emoji_picker/flutter_emoji_picker.dart';
```

### Wrap your `MaterialApp` with our `EmojiProvider`

```dart
EmojiProvider(
  child: MaterialApp(
    title: 'Flutter Demo',
    home: Scaffold(
      body: ...yourcode 
    ),
  ),
);
```

### Example

We have three options to select/show emojis picker 

#### Dialog option

```dart
EmojiButton(
     emojiPickerViewConfiguration: EmojiPickerViewConfiguration(
     viewType: ViewType.dialog,
        onEmojiSelected: (String emoji) {
            print('Emoji selected: $emoji');
        },
     ),
  child: const Text('Click Me'),
),
```

#### Bottomsheet option

```dart
EmojiButton(
     emojiPickerViewConfiguration: EmojiPickerViewConfiguration(
     viewType: ViewType.bottomsheet,
        onEmojiSelected: (String emoji) {
            print('Emoji selected: $emoji');
        },
     ),
  child: const Text('Click Me'),
),
```

#### Screen option

This option gives a full screen for just select the emojis 

```dart
IconButton(
  onPressed: () {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (ctx) {
                return EmojiListView(
                    currentHoveredEmoji: <your_custom_value_notifier_for_notify_on_hover_an_emoji>, // optional and just is used if the platform is non mobile
                    contentPadding: const EdgeInsets.only(left: 20, right: 40),
                        appBar: SliverAppBar(
                          leading: IconButton(
                            icon: const Icon(CupertinoIcons.arrow_left),
                            onPressed: () {
                              Navigator.pop(ctx);
                            },
                          ),
                        ),
                    configuration: EmojiListViewConfiguration(onEmojiSelected: (String emoji) {
                        print('Emoji selected: $emoji');
                    }),
                    searchBarConfiguration: EmojiPickerSearchFieldConfiguration(showField: false),
                );
            },
        ),
    );
  },
  icon: const Text('😀'),
)
```

## Community Support

If you have any suggestions or issues, feel free to open an [issue](https://github.com/CatHood0/emoji_picker/issues).

If you would like to contribute, feel free to create a [PR](https://github.com/CatHood0/emoji_picker/pulls).
