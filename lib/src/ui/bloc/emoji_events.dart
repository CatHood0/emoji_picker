import 'package:equatable/equatable.dart';
import 'package:flutter_emoji_picker/src/domain/entities/emoji_type.dart';

abstract class EmojiPickerEvent extends Equatable {
  const EmojiPickerEvent();

  @override
  List<Object?> get props => [];
}

class GetEmojiEvent extends EmojiPickerEvent {
  final EmojiType emojiType;

  const GetEmojiEvent(this.emojiType);

  @override
  List<Object?> get props => [emojiType];
}

class FilterEmojiEvent extends EmojiPickerEvent {
  final String filter;

  const FilterEmojiEvent(this.filter);

  @override
  List<Object?> get props => [filter];
}
