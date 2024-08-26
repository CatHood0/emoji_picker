import 'dart:io';

import 'package:flutter_emoji_picker/flutter_emoji_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sliver_tools/sliver_tools.dart';

import '../bloc/emoji_bloc.dart';
import '../bloc/emoji_events.dart';
import '../bloc/emoji_states.dart';
import 'emoji_search_field.dart';

Widget? _defaultListCache;

class EmojiListView extends StatefulWidget {
  final EmojiListViewConfiguration configuration;
  final EmojiPickerSearchFieldConfiguration searchBarConfiguration;
  final ValueNotifier<String?>? currentHoveredEmoji;
  final SliverAppBar? appBar;
  final EdgeInsets? contentPadding;
  final double? searchBarWidth;
  final double? searchBarHeight;
  const EmojiListView({
    super.key,
    required this.configuration,
    this.appBar,
    this.contentPadding,
    this.searchBarWidth,
    this.searchBarHeight,
    required this.searchBarConfiguration,
    this.currentHoveredEmoji,
  });

  @override
  State<EmojiListView> createState() => _EmojiListViewState();
}

class _EmojiListViewState extends State<EmojiListView> {
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
    return Scaffold(
      body: SizedBox(
        child: Padding(
          padding: widget.contentPadding ?? const EdgeInsets.all(0),
          child: CustomScrollView(
            slivers: [
              if (widget.appBar != null) widget.appBar!,
              if (widget.searchBarConfiguration.showField)
                SliverToBoxAdapter(
                  child: SizedBox(
                    width: widget.searchBarWidth,
                    height: widget.searchBarHeight,
                    child: EmojiSearchField(
                      hintText: widget.searchBarConfiguration.hintText,
                      controller: _controller,
                      focusNode: _focusNode,
                      color: widget.configuration.searchBarColor,
                      searchIconColor:
                          widget.searchBarConfiguration.searchIconColor,
                      shapeBorder: widget.configuration.searchShapeBorder,
                      textStyle: widget.searchBarConfiguration.textStyle,
                      hintStyle: widget.searchBarConfiguration.hintStyle,
                      onSubmitted: (filter) =>
                          context.read<EmojiPickerBloc>().add(
                                FilterEmojiEvent(
                                  filter,
                                ),
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
                      child: Text(
                          'Searching was failed by ${pickerState.message}'),
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
                          onHover: Platform.isIOS || Platform.isAndroid
                              ? null
                              : (s) {
                                  widget.currentHoveredEmoji?.value =
                                      emoji.emoji;
                                },
                          onExit: Platform.isIOS || Platform.isAndroid
                              ? null
                              : (s) {
                                  widget.currentHoveredEmoji?.value = null;
                                },
                          child: GestureDetector(
                            onTap: () {
                              widget.configuration.onEmojiSelected(emoji.emoji);
                              if (widget.configuration.shouldPopOnSelect) {
                                Navigator.pop(context);
                              }
                            },
                            child: widget.currentHoveredEmoji == null
                                ? Container(
                                    alignment: Alignment.center,
                                    child: Text(emoji.emoji),
                                  )
                                : ValueListenableBuilder(
                                    valueListenable:
                                        widget.currentHoveredEmoji!,
                                    builder: (context, value, child) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          color: value == emoji.emoji
                                              ? Colors.grey
                                              : null,
                                          borderRadius:
                                              BorderRadius.circular(4.5),
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
