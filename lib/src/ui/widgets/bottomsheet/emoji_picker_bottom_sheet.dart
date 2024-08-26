import 'dart:io';

import 'package:flutter_emoji_picker/src/ui/bloc/emoji_bloc.dart';
import 'package:flutter_emoji_picker/src/ui/bloc/emoji_events.dart';
import 'package:flutter_emoji_picker/src/ui/widgets/emoji_view/emoji_picker_view.dart';
import 'package:flutter/material.dart' hide SearchBar;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../../bloc/emoji_states.dart';
import '../../scroll_glow_remover.dart';
import '../emoji_search_field.dart';

Widget? _defaultListCache;

/// Displays the emoji picker using a dialog.
class EmojiPickerBottomSheetView extends EmojiPickerView {
  final ValueNotifier<String?> currentHoverEmoji;

  /// {@macro emoji_picker_view}
  const EmojiPickerBottomSheetView({
    super.key,
    required super.onEmojiSelected,
    required this.currentHoverEmoji,
    super.height,
    super.width,
    super.decoration,
    super.scrollBehavior,
    super.hintText = 'Search for an emoji',
    super.backgroundColor,
    super.searchBarColor,
    super.searchIconColor,
    super.searchShapeBorder,
    super.shouldPopOnSelect,
    super.textStyle,
    super.hintStyle,
    super.activeColor,
    super.inactiveColor,
  });

  @override
  State<EmojiPickerBottomSheetView> createState() =>
      _EmojiPickerBottomSheetViewtate();
}

class _EmojiPickerBottomSheetViewtate
    extends State<EmojiPickerBottomSheetView> {
  bool isFirst = true;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    context.read<EmojiPickerBloc>().add(const GetEmojiEvent());
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return Container(
      height: widget.height ?? size.height * 0.65,
      width: widget.width ?? size.width * 0.80,
      decoration: widget.decoration ??
          BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 15,
        ),
        child: CustomScrollView(
          scrollBehavior: widget.scrollBehavior ?? const ScrollGlowRemover(),
          slivers: [
            SliverToBoxAdapter(
              child: EmojiSearchField(
                hintText: widget.hintText,
                controller: _controller,
                focusNode: _focusNode,
                color: widget.searchBarColor,
                searchIconColor: widget.searchIconColor,
                shapeBorder: widget.searchShapeBorder,
                textStyle: widget.textStyle,
                hintStyle: widget.hintStyle,
                onSubmitted: (filter) => context.read<EmojiPickerBloc>().add(
                      FilterEmojiEvent(
                        filter,
                      ),
                    ),
              ),
            ),
            BlocBuilder<EmojiPickerBloc, EmojiPickerState>(
              builder: (context, pickerState) {
                if (pickerState is EmojiPickerInitial) {
                  return const SliverToBoxAdapter();
                }

                if (pickerState is EmojiPickerLoading) {
                  return const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }

                if (pickerState is EmojiPickerError) {
                  return Center(
                    child:
                        Text('Searching was failed by ${pickerState.message}'),
                  );
                }

                if (pickerState is EmojiPickerLoaded &&
                    (pickerState.manager.emojis.isEmpty)) {
                  return const SliverFillRemaining(
                    child: Center(child: Text('No Results Found')),
                  );
                }

                final state = pickerState as EmojiPickerLoaded;
                if (_defaultListCache != null && !state.hasFilteredData) {
                  return _defaultListCache!;
                } else if (isFirst) {
                  isFirst = false;
                  _defaultListCache = _buildView(state);
                  return _defaultListCache!;
                }
                return _buildView(state);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildView(EmojiPickerLoaded state) {
    return MultiSliver(
      children: [
        for (int index = 0; index < state.manager.emojis.keys.length; index++)
          MultiSliver(
            children: [
              SliverPadding(
                padding: const EdgeInsets.only(
                    left: 8.0, top: 12.0), // Añade un poco de padding
                sliver: SliverToBoxAdapter(
                  child: Text(
                    state.manager.emojis.entries
                        .elementAt(index)
                        .key, // Muestra la clave como título
                    style: const TextStyle(
                      fontSize: 18.0, // Tamaño del texto del título
                      fontWeight:
                          FontWeight.bold, // Negrita para destacar el título
                    ),
                  ),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(top: 12),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent:
                        Platform.isIOS || Platform.isAndroid ? 48 : 43,
                  ),
                  delegate: SliverChildBuilderDelegate(
                    childCount: state.manager.emojis.entries
                        .elementAt(index)
                        .value
                        .length,
                    (context, indexEmoji) {
                      final emoji = state.manager.emojis.entries
                          .elementAt(index)
                          .value
                          .elementAt(indexEmoji);
                      return Padding(
                        padding: const EdgeInsets.all(3),
                        child: MouseRegion(
                          cursor: WidgetStateMouseCursor.clickable,
                          onHover: (s) {
                            widget.currentHoverEmoji.value = emoji.emoji;
                          },
                          onExit: (s) {
                            widget.currentHoverEmoji.value = null;
                          },
                          child: GestureDetector(
                            onTap: () {
                              widget.onEmojiSelected(emoji.emoji);
                              if (widget.shouldPopOnSelect) {
                                Navigator.pop(context);
                              }
                            },
                            child: ValueListenableBuilder(
                              valueListenable: widget.currentHoverEmoji,
                              builder: (context, value, child) {
                                return Container(
                                  decoration: BoxDecoration(
                                    color: value == emoji.emoji
                                        ? Colors.grey
                                        : null,
                                    borderRadius: BorderRadius.circular(4.5),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(emoji.emoji),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
      ],
    );
  }
}
