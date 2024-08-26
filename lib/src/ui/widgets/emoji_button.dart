import 'dart:io';

import 'package:flutter_emoji_picker/src/ui/widgets/bottomsheet/emoji_picker_bottom_sheet.dart';
import 'package:flutter_emoji_picker/src/ui/widgets/dialog/emoji_dialog_picker_view.dart';
import 'package:flutter_emoji_picker/src/ui/widgets/emoji_view/emoji_picker_view_configuration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'emoji_view/emoji_picker_view.dart';

/// A button that can be used to select an emoji.
class EmojiButton extends StatefulWidget {
  const EmojiButton({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(4),
    required this.emojiPickerViewConfiguration,
    this.backgroundColor,
    this.radius,
    this.minWidth = 0,
    this.maxWidth = double.infinity,
    this.shape,
    this.barrierDismissible = true,
  });

  /// The child widget to display in the button.
  final Widget child;

  /// The padding of the button.
  final EdgeInsets padding;

  /// The [EmojiPickerView] to display when the button is tapped.
  final EmojiPickerViewConfiguration emojiPickerViewConfiguration;

  /// The minimum width of the [EmojiPickerView] dialog.
  final double minWidth;

  /// The maximum width of the [EmojiPickerView] dialog.
  final double maxWidth;

  /// The color of the background button
  final Color? backgroundColor;

  /// The border radius of the button
  final double? radius;

  /// The shape of dialog.
  final ShapeBorder? shape;

  /// If true, the dialog can be dismissed by tapping outside of it.
  final bool barrierDismissible;

  @override
  State<EmojiButton> createState() => _EmojiButtonState();
}

class _EmojiButtonState extends State<EmojiButton> {
  final ValueNotifier<String?> _currentHoverEmoji = ValueNotifier('');

  @override
  void dispose() {
    _currentHoverEmoji.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: InkWell(
        radius: widget.radius,
        onTap: () async {
          if (widget.emojiPickerViewConfiguration.viewType ==
              ViewType.bottomsheet) {
            showBottomSheet(
                context: context,
                builder: (ctx) {
                  return EmojiPickerBottomSheetView(
                    onEmojiSelected:
                        widget.emojiPickerViewConfiguration.onEmojiSelected,
                    currentHoverEmoji: _currentHoverEmoji,
                    height: widget.emojiPickerViewConfiguration.height,
                    width: widget.emojiPickerViewConfiguration.width,
                    decoration: widget.emojiPickerViewConfiguration.decoration,
                    scrollBehavior:
                        widget.emojiPickerViewConfiguration.scrollBehavior,
                    hintText: widget.emojiPickerViewConfiguration.hintText,
                    backgroundColor:
                        widget.emojiPickerViewConfiguration.backgroundColor,
                    searchBarColor:
                        widget.emojiPickerViewConfiguration.searchBarColor,
                    searchIconColor:
                        widget.emojiPickerViewConfiguration.searchIconColor,
                    searchShapeBorder:
                        widget.emojiPickerViewConfiguration.searchShapeBorder,
                    textStyle: widget.emojiPickerViewConfiguration.textStyle,
                    hintStyle: widget.emojiPickerViewConfiguration.hintStyle,
                    activeColor:
                        widget.emojiPickerViewConfiguration.activeColor,
                    inactiveColor:
                        widget.emojiPickerViewConfiguration.inactiveColor,
                  );
                });
          }
          if (widget.emojiPickerViewConfiguration.viewType == ViewType.dialog) {
            final child = EmojiPickerDialogView(
              onEmojiSelected:
                  widget.emojiPickerViewConfiguration.onEmojiSelected,
              currentHoverEmoji: _currentHoverEmoji,
              height: widget.emojiPickerViewConfiguration.height,
              width: widget.emojiPickerViewConfiguration.width,
              decoration: widget.emojiPickerViewConfiguration.decoration,
              scrollBehavior:
                  widget.emojiPickerViewConfiguration.scrollBehavior,
              hintText: widget.emojiPickerViewConfiguration.hintText,
              backgroundColor:
                  widget.emojiPickerViewConfiguration.backgroundColor,
              searchBarColor:
                  widget.emojiPickerViewConfiguration.searchBarColor,
              searchIconColor:
                  widget.emojiPickerViewConfiguration.searchIconColor,
              searchShapeBorder:
                  widget.emojiPickerViewConfiguration.searchShapeBorder,
              textStyle: widget.emojiPickerViewConfiguration.textStyle,
              hintStyle: widget.emojiPickerViewConfiguration.hintStyle,
              activeColor: widget.emojiPickerViewConfiguration.activeColor,
              inactiveColor: widget.emojiPickerViewConfiguration.inactiveColor,
            );
            if (Platform.isIOS || Platform.isMacOS || Platform.isLinux) {
              showCupertinoDialog<dynamic>(
                  context: context,
                  barrierDismissible: widget.barrierDismissible,
                  builder: (context) {
                    return Dialog(
                      shape: widget.shape ??
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: widget.minWidth,
                          maxWidth: widget.maxWidth,
                        ),
                        child: child,
                      ),
                    );
                  });
              return;
            }
            showDialog<dynamic>(
              context: context,
              barrierDismissible: widget.barrierDismissible,
              builder: (context) {
                return Dialog(
                  shape: widget.shape ??
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                  child: child,
                );
              },
            );
          }
        },
        customBorder: const CircleBorder(),
        child: Container(
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(widget.radius ?? 0),
          ),
          child: Padding(
            padding: widget.padding,
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
