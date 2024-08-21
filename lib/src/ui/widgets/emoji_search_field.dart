import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// {@template search_bar}
/// A search bar that can be used to search for an emoji.
/// {@endtemplate}
class EmojiSearchField extends HookWidget {
  /// {@macro search_bar}
  const EmojiSearchField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.focusNode,
    this.onSubmitted,
    this.onChanged,
    this.color,
    this.textStyle,
    this.hintStyle,
    this.searchIconColor,
    this.shapeBorder,
  });

  final TextEditingController controller;
  final FocusNode focusNode;

  /// {@template hint_text}
  /// The hint text to display in the search bar.
  /// {@endtemplate}
  final String hintText;

  /// Triggers when the text in the search bar changes.
  final Function(String?)? onChanged;
  final Function(String)? onSubmitted;

  /// {@template search_bar_color}
  /// The background color of the search bar.
  /// {@endtemplate}
  final Color? color;

  /// {@template search_bar_icon_color}
  /// The color of the search icon
  /// {@endtemplate}
  final Color? searchIconColor;

  /// {@template search_bar_shape_border}
  /// The shape of the search bar.
  /// {@endtemplate}
  final ShapeBorder? shapeBorder;

  /// {@template search_bar_text_style}
  /// The text style of the search bar.
  /// {@endtemplate}
  final TextStyle? textStyle;

  /// {@template search_bar_hint_style}
  /// The text style of the hint text.
  /// {@endtemplate}
  final TextStyle? hintStyle;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      margin: EdgeInsets.all(10),
      shape: shapeBorder ?? const StadiumBorder(),
      child: Platform.isIOS || Platform.isMacOS
          ? CupertinoTextField(
              style: textStyle,
              controller: controller,
              focusNode: focusNode,
              textInputAction: TextInputAction.search,
              prefix: Padding(
                padding: const EdgeInsets.only(
                  left: 18,
                  right: 12,
                ),
                child: IconButton(
                  icon: const Icon(CupertinoIcons.search),
                  color: searchIconColor ?? Colors.grey,
                  onPressed: () {
                    onSubmitted?.call(controller.text.trim());
                  },
                ),
              ),
              placeholder: hintText,
              placeholderStyle: hintStyle,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
            )
          : Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: TextFormField(
                style: textStyle,
                focusNode: focusNode,
                controller: controller,
                textInputAction: TextInputAction.search,
                decoration: InputDecoration(
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(
                      left: 18,
                      right: 12,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.search),
                      color: searchIconColor ?? Colors.grey,
                      onPressed: () {
                        onSubmitted?.call(controller.text.trim());
                      },
                    ),
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    minWidth: 12,
                    minHeight: 12,
                  ),
                  hintText: hintText,
                  hintStyle: hintStyle,
                  counterText: '',
                ),
                onChanged: onChanged,
                onFieldSubmitted: onSubmitted,
              ),
            ),
    );
  }
}
