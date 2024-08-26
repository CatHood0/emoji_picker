import 'package:equatable/equatable.dart';

abstract class EmojiPickerEvent extends Equatable {
  const EmojiPickerEvent();

  @override
  List<Object?> get props => [];
}

class GetEmojiEvent extends EmojiPickerEvent {
  const GetEmojiEvent();

  @override
  List<Object?> get props => [];
}

class FilterEmojiEvent extends EmojiPickerEvent {
  final String filter;

  const FilterEmojiEvent(this.filter);

  @override
  List<Object?> get props => [filter];
}
