# Emoji Picker

Emoji dialog picker makes it easy to select emojis from any platform.

## Installation

Add Emoji Picker to your pubspec.yaml

```yaml
dependencies:
  flutter_emoji_picker: ^1.0.0
```

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

We have two options to select/show emojis picker 

#### Dialog option

```dart
EmojiButton(
  emojiPickerViewConfiguration: EmojiPickerViewConfiguration(onEmojiSelected: (String emoji) {
    print('Emoji selected: $emoji');
  }),
  child: const Text('Click Me'),
),
```

#### List view option

This option gives to you a `CustomScrollView` with the emojis 

```dart
EmojiListView(
  configuration: EmojiPickerViewConfiguration(onEmojiSelected: (String emoji) {
    print('Emoji selected: $emoji');
  }),
  searchBarConfiguration: EmojiPickerSearchFieldConfiguration(showField: false),
),
```

## Community Support

If you have any suggestions or issues, feel free to open an [issue](https://github.com/CatHood0/emoji_picker/issues).

If you would like to contribute, feel free to create a [PR](https://github.com/CatHood0/emoji_picker/pulls).
