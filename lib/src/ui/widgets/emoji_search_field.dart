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

  /// The hint text to display in the search bar.
  final String hintText;

  /// Triggers when the text in the search bar changes.
  final Function(String?)? onChanged;
  final Function(String)? onSubmitted;

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

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
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
              child: Container(
                width: 100,
                child: TextFormField(
                  style: textStyle,
                  focusNode: focusNode,
                  controller: controller,
                  textInputAction: TextInputAction.search,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.black.withOpacity(0.4),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Color.fromARGB(
                          255,
                          40,
                          213,
                          255,
                        ),
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 12,
                      ),
                      child: InkWell(
                        hoverColor: Colors.black.withOpacity(0.2),
                        customBorder: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: const BorderSide(),
                        ),
                        onTap: () {
                          onSubmitted?.call(controller.text.trim());
                        },
                        child: SizedBox(
                          width: 30,
                          height: 30,
                          child: Icon(
                            Icons.search,
                            color: searchIconColor ?? Colors.grey,
                          ),
                        ),
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
            ),
    );
  }
}
