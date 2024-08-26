import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji_picker/flutter_emoji_picker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const EmojiProvider(
      child: MaterialApp(
        title: 'Flutter Demo',
        themeMode: ThemeMode.dark,
        home: MyHomePage(title: 'Emoji picker'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ValueNotifier<String?> _currentHoverNotifier = ValueNotifier('');
  @override
  void dispose() {
    _currentHoverNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: EmojiButton(
                    emojiPickerViewConfiguration: EmojiPickerViewConfiguration(
                      viewType: ViewType.bottomsheet,
                      onEmojiSelected: (emoji) {},
                    ),
                    child: const Icon(
                      CupertinoIcons.arrow_down,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  alignment: Alignment.center,
                  child: EmojiButton(
                    emojiPickerViewConfiguration: EmojiPickerViewConfiguration(
                      viewType: ViewType.dialog,
                      onEmojiSelected: (emoji) {},
                    ),
                    child: const Icon(
                      Icons.emoji_flags,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
