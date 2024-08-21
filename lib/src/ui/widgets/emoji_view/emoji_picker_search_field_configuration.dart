import 'package:flutter/material.dart';

class EmojiPickerSearchFieldConfiguration {
  EmojiPickerSearchFieldConfiguration(
    this.shapeBorder, {
    this.hintText = 'Select an emoji item',
    this.color,
    this.searchIconColor,
    this.textStyle,
    this.hintStyle,
    this.showField = true,
  });

  /// Decides if the search bar should be showed
  final bool showField;

  /// The hint text to display in the search bar.
  final String hintText;

  /// The background color of the search bar.
  final Color? color;

  /// The color of the search icon
  final Color? searchIconColor;

  /// The shape of the search bar.
  final ShapeBorder? shapeBorder;

  /// The text style of the search bar.
  final TextStyle? textStyle;

  /// The text style of the hint text.
  final TextStyle? hintStyle;
}
