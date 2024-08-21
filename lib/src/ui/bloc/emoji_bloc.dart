import 'package:emoji_picker/src/domain/entities/emoji_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:emoji_picker/src/domain/repository/emoji_repository.dart';
import 'emoji_events.dart';
import 'emoji_states.dart';

class EmojiPickerBloc extends Bloc<EmojiPickerEvent, EmojiPickerState> {
  final EmojiRepository emojiRepository;

  EmojiPickerBloc(this.emojiRepository) : super(const EmojiPickerInitial()) {
    on<GetEmojiEvent>(_onGetEmoji);
    on<FilterEmojiEvent>(_onFilterEmoji);
  }

  void dispose() {
    close();
  }

  Future<void> _onGetEmoji(
      GetEmojiEvent event, Emitter<EmojiPickerState> emit) async {
    emit(const EmojiPickerLoading());
    final emojis = await emojiRepository.getEmojis(event.emojiType);
    emit(
      EmojiPickerLoaded(
        emojis: emojis,
      ),
    );
  }

  Future<void> _onFilterEmoji(
      FilterEmojiEvent event, Emitter<EmojiPickerState> emit) async {
    try {
      emit(const EmojiPickerLoading());
      final filteredEmojis = await emojiRepository.findEmoji(event.filter);
      emit(
        EmojiPickerLoaded(
          emojis: EmojisManager(emojis: filteredEmojis),
        ),
      );
    } catch (e) {
      emit(EmojiPickerError('The emoji called ${event.filter} not exist'));
    }
  }
}
