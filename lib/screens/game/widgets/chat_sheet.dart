import 'package:askinator/misc/lottie_decoder.dart';
import 'package:askinator/misc/responsive_layout_builder.dart';
import 'package:askinator/screens/game/game_viewmodel.dart';
import 'package:askinator/screens/game/widgets/chat_sheet_large.dart';
import 'package:askinator/screens/game/widgets/chat_sheet_small.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:lottie/lottie.dart';

class ChatSheet extends StatelessWidget {
  const ChatSheet({super.key, required this.gameViewModel});

  final GameViewModel gameViewModel;

  // Response loading from askinator
  static Widget customMessageBuilder(types.CustomMessage message, {required int messageWidth}) {
    const theme = DefaultChatTheme();

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: theme.messageInsetsHorizontal,
        vertical: theme.messageInsetsVertical,
      ),
      child: Lottie.asset(
        width: 56,
        'assets/loading.lottie',
        decoder: customDecoder,
      ),
    );
  }

  @override
  Widget build(BuildContext context) => ResponsiveLayoutBuilder(
        smallScreenBuilder: (context) => ChatSheetSmall(gameViewModel: gameViewModel),
        largeScreenBuilder: (context) => ChatSheetLarge(gameViewModel: gameViewModel),
      );
}
