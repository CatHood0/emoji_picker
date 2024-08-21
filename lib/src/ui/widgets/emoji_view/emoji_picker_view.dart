import 'package:flutter/material.dart';

abstract class EmojiPickerView extends StatefulWidget {
  const EmojiPickerView({
    super.key,
    required this.onEmojiSelected,
    required this.hintText,
    this.scrollBehavior,
    this.height,
    this.width,
    this.decoration,
    this.backgroundColor,
    this.searchBarColor,
    this.searchIconColor,
    this.searchShapeBorder,
    this.textStyle,
    this.hintStyle,
    this.activeColor,
    this.inactiveColor,
    this.shouldPopOnSelect = true,
  });

  /// Describes how the CustomScrollView and ListView should behave.
  final ScrollBehavior? scrollBehavior;

  /// Decides if the picker should be closed on select an item
  final bool shouldPopOnSelect;

  /// Optional height of [EmojiPickerView].
  final double? height;

  /// Optional width of [EmojiPickerView].
  final double? width;

  /// Decoration of [EmojiPickerView].
  final Decoration? decoration;

  /// Background color of [EmojiPickerView].
  final Color? backgroundColor;

  /// Triggers when an emoji is selected.
  final Function(String emoji) onEmojiSelected;

  /// {@macro hint_text}
  final String hintText;

  /// {@macro search_bar_color}
  final Color? searchBarColor;

  /// {@macro search_bar_icon_color}
  final Color? searchIconColor;

  /// {@macro search_bar_shape_border}
  final ShapeBorder? searchShapeBorder;

  /// {@macro search_bar_text_style}
  final TextStyle? textStyle;

  /// {@macro search_bar_hint_style}
  final TextStyle? hintStyle;

  /// {@macro emoji_icon_selector_active_color}
  final Color? activeColor;

  /// {@macro emoji_icon_selector_active_color}
  final Color? inactiveColor;
}
