import 'package:flutter_emoji_picker/src/domain/repository/emoji_repository.dart';
import 'package:flutter_emoji_picker/src/ui/bloc/emoji_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// This widget provider to it's children
/// the bloc using by the packages
class EmojiProvider extends StatefulWidget {
  final Widget child;
  const EmojiProvider({
    super.key,
    required this.child,
  });

  @override
  State<EmojiProvider> createState() => _EmojiProviderState();
}

class _EmojiProviderState extends State<EmojiProvider> {
  @override
  void dispose() {
    if (mounted) {
      context.read<EmojiPickerBloc>().close();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        return EmojiPickerBloc(
          EmojiRepository(),
        );
      },
      lazy: true,
      child: widget.child,
    );
  }
}
