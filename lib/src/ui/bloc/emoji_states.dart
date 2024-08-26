import 'package:flutter_emoji_picker/src/domain/entities/emoji_list.dart';
import 'package:equatable/equatable.dart';

abstract class EmojiPickerState extends Equatable {
  const EmojiPickerState();

  @override
  List<Object?> get props => [];
}

class EmojiPickerInitial extends EmojiPickerState {
  const EmojiPickerInitial();
}

class EmojiPickerLoading extends EmojiPickerState {
  const EmojiPickerLoading();
}

class EmojiPickerLoaded extends EmojiPickerState {
  final bool hasFilteredData;
  final EmojisManager manager;

  const EmojiPickerLoaded({
    required this.manager,
    this.hasFilteredData = false,
  });

  @override
  List<Object?> get props => [manager, hasFilteredData];
}

class EmojiPickerSearching extends EmojiPickerState {
  final EmojisManager filteredEmojis;

  const EmojiPickerSearching({
    required this.filteredEmojis,
  });

  @override
  List<Object?> get props => [filteredEmojis];
}

class EmojiPickerError extends EmojiPickerState {
  final String message;

  const EmojiPickerError(this.message);

  @override
  List<Object?> get props => [message];
}
