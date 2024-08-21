import 'dart:io';

import 'package:flutter_emoji_picker/flutter_emoji_picker.dart';
import 'package:flutter_emoji_picker/src/domain/entities/emoji_type.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/emoji_bloc.dart';
import '../bloc/emoji_events.dart';
import '../bloc/emoji_states.dart';
import 'emoji_icon_selector.dart';
import 'emoji_search_field.dart';

class EmojiListView extends StatefulWidget {
  final EmojiPickerViewConfiguration configuration;
  final EmojiPickerSearchFieldConfiguration searchBarConfiguration;
  const EmojiListView({
    super.key,
    required this.configuration,
    required this.searchBarConfiguration,
  });

  @override
  State<EmojiListView> createState() => _EmojiListViewState();
}

class _EmojiListViewState extends State<EmojiListView> {
  final ValueNotifier<EmojiType> _currentSelection =
      ValueNotifier(EmojiType.unknown);
  final ValueNotifier<String?> _currentHoverEmoji = ValueNotifier('');
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  @override
  void initState() {
    super.initState();
    context
        .read<EmojiPickerBloc>()
        .add(const GetEmojiEvent(EmojiType.activity));
  }

  @override
  void dispose() {
    _currentSelection.dispose();
    _currentHoverEmoji.dispose();
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        if (widget.searchBarConfiguration.showField)
          SliverToBoxAdapter(
            child: EmojiSearchField(
              hintText: widget.searchBarConfiguration.hintText,
              controller: _controller,
              focusNode: _focusNode,
              color: widget.configuration.searchBarColor,
              searchIconColor: widget.searchBarConfiguration.searchIconColor,
              shapeBorder: widget.configuration.searchShapeBorder,
              textStyle: widget.searchBarConfiguration.textStyle,
              hintStyle: widget.searchBarConfiguration.hintStyle,
              onSubmitted: (filter) => context.read<EmojiPickerBloc>().add(
                    FilterEmojiEvent(
                      filter,
                    ),
                  ),
            ),
          ),
        SliverPadding(
          padding: const EdgeInsets.only(top: 10),
          sliver: SliverToBoxAdapter(
            child: SizedBox(
              height: 32,
              child: Center(
                child: ValueListenableBuilder(
                    valueListenable: _currentSelection,
                    builder: (context, value, child) {
                      return ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          EmojiIconSelector(
                            isSelected: value == EmojiType.activity,
                            icon: const Icon(Icons.sports_basketball),
                            activeColor: widget.configuration.activeColor,
                            inactiveColor: widget.configuration.inactiveColor,
                            onTap: () {
                              _currentSelection.value = EmojiType.activity;
                              context
                                  .read<EmojiPickerBloc>()
                                  .add(const GetEmojiEvent(EmojiType.activity));
                            },
                          ),
                          EmojiIconSelector(
                            isSelected: value == EmojiType.animalsAndNature,
                            icon: const Icon(Icons.park),
                            activeColor: widget.configuration.activeColor,
                            inactiveColor: widget.configuration.inactiveColor,
                            onTap: () {
                              _currentSelection.value =
                                  EmojiType.animalsAndNature;
                              context.read<EmojiPickerBloc>().add(
                                  const GetEmojiEvent(
                                      EmojiType.animalsAndNature));
                            },
                          ),
                          EmojiIconSelector(
                            isSelected: value == EmojiType.flags,
                            icon: const Icon(Icons.flag),
                            activeColor: widget.configuration.activeColor,
                            inactiveColor: widget.configuration.inactiveColor,
                            onTap: () {
                              _currentSelection.value = EmojiType.flags;
                              context
                                  .read<EmojiPickerBloc>()
                                  .add(const GetEmojiEvent(EmojiType.flags));
                            },
                          ),
                          EmojiIconSelector(
                            isSelected: value == EmojiType.foodAndDrink,
                            icon: const Icon(Icons.fastfood),
                            activeColor: widget.configuration.activeColor,
                            inactiveColor: widget.configuration.inactiveColor,
                            onTap: () {
                              _currentSelection.value = EmojiType.foodAndDrink;
                              context.read<EmojiPickerBloc>().add(
                                  const GetEmojiEvent(EmojiType.foodAndDrink));
                            },
                          ),
                          EmojiIconSelector(
                            isSelected: value == EmojiType.objects,
                            icon: const Icon(EvaIcons.cube),
                            activeColor: widget.configuration.activeColor,
                            inactiveColor: widget.configuration.inactiveColor,
                            onTap: () {
                              _currentSelection.value = EmojiType.objects;
                              context
                                  .read<EmojiPickerBloc>()
                                  .add(const GetEmojiEvent(EmojiType.objects));
                            },
                          ),
                          EmojiIconSelector(
                            isSelected: value == EmojiType.people,
                            icon: const Icon(Icons.emoji_emotions),
                            activeColor: widget.configuration.activeColor,
                            inactiveColor: widget.configuration.inactiveColor,
                            onTap: () {
                              _currentSelection.value = EmojiType.people;
                              context
                                  .read<EmojiPickerBloc>()
                                  .add(const GetEmojiEvent(EmojiType.people));
                            },
                          ),
                          EmojiIconSelector(
                            isSelected: value == EmojiType.symbols,
                            icon: const Icon(EvaIcons.info),
                            activeColor: widget.configuration.activeColor,
                            inactiveColor: widget.configuration.inactiveColor,
                            onTap: () {
                              _currentSelection.value = EmojiType.symbols;
                              context
                                  .read<EmojiPickerBloc>()
                                  .add(const GetEmojiEvent(EmojiType.symbols));
                            },
                          ),
                          EmojiIconSelector(
                            isSelected: value == EmojiType.travelsAndPlaces,
                            icon: const Icon(Icons.landscape),
                            activeColor: widget.configuration.activeColor,
                            inactiveColor: widget.configuration.inactiveColor,
                            onTap: () {
                              _currentSelection.value =
                                  EmojiType.travelsAndPlaces;
                              context.read<EmojiPickerBloc>().add(
                                  const GetEmojiEvent(
                                      EmojiType.travelsAndPlaces));
                            },
                          ),
                        ],
                      );
                    }),
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
              child: Text('Searching was failed by ${pickerState.message}'),
            );
          }

          if (pickerState is EmojiPickerLoaded &&
              (pickerState.emojis.emojis.isEmpty)) {
            return const SliverFillRemaining(
              child: Center(child: Text('No Results Found')),
            );
          }

          final state = pickerState as EmojiPickerLoaded;
          return SliverPadding(
            padding: const EdgeInsets.only(top: 12),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent:
                    Platform.isIOS || Platform.isAndroid ? 48 : 43,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final emoji = state.emojis.emojis.elementAt(index);
                  return Padding(
                    padding: const EdgeInsets.all(3),
                    child: MouseRegion(
                      cursor: WidgetStateMouseCursor.clickable,
                      onHover: (s) {
                        _currentHoverEmoji.value = emoji.emoji;
                      },
                      onExit: (s) {
                        _currentHoverEmoji.value = null;
                      },
                      child: GestureDetector(
                        onTap: () {
                          widget.configuration.onEmojiSelected(emoji.emoji);
                          if (widget.configuration.shouldPopOnSelect) {
                            Navigator.pop(context);
                          }
                        },
                        child: ValueListenableBuilder(
                            valueListenable: _currentHoverEmoji,
                            builder: (context, value, child) {
                              return Container(
                                decoration: BoxDecoration(
                                  color:
                                      value == emoji.emoji ? Colors.grey : null,
                                  borderRadius: BorderRadius.circular(
                                    4.5,
                                  ),
                                ),
                                alignment: Alignment.center,
                                child: Text(emoji.emoji),
                              );
                            }),
                      ),
                    ),
                  );
                },
                childCount: state.emojis.emojis.length,
              ),
            ),
          );
        }),
      ],
    );
  }
}
