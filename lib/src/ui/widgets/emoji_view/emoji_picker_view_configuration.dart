import 'package:flutter/material.dart';

class EmojiListViewConfiguration {
  /// Describes how the CustomScrollView and ListView should behave.
  final ScrollBehavior? scrollBehavior;

  /// Decides if the picker will be closed on select an item
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

  final String hintText;

  final Color? searchBarColor;

  final Color? searchIconColor;

  final ShapeBorder? searchShapeBorder;

  final TextStyle? textStyle;

  final TextStyle? hintStyle;

  final Color? activeColor;

  final Color? inactiveColor;

  EmojiListViewConfiguration({
    required this.onEmojiSelected,
    this.hintText = 'Select an emoji item',
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
}

class EmojiPickerViewConfiguration {
  final ViewType viewType;

  /// Describes how the CustomScrollView and ListView should behave.
  final ScrollBehavior? scrollBehavior;

  /// Decides if the picker will be closed on select an item
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

  final String hintText;

  final Color? searchBarColor;

  final Color? searchIconColor;

  final ShapeBorder? searchShapeBorder;

  final TextStyle? textStyle;

  final TextStyle? hintStyle;

  final Color? activeColor;

  final Color? inactiveColor;

  EmojiPickerViewConfiguration({
    required this.onEmojiSelected,
    required this.viewType,
    this.hintText = 'Select an emoji item',
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
}

enum ViewType {
  dialog,
  bottomsheet,
}
