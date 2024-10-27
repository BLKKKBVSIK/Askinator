import 'package:askinator/misc/lottie_decoder.dart';
import 'package:askinator/misc/responsive_layout_builder.dart';
import 'package:askinator/screens/game/game_viewmodel.dart';
import 'package:askinator/screens/game/widgets/chat_sheet_large.dart';
import 'package:askinator/screens/game/widgets/chat_sheet_small.dart';
import 'package:askinator/screens/shared/gradient_button.dart';
import 'package:defer_pointer/defer_pointer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:lottie/lottie.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

class ChatSheet extends StackedHookView<GameViewModel> {
  const ChatSheet({super.key});

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
        'assets/anims/loading.lottie',
        decoder: customDecoder,
      ),
    );
  }

  @override
  Widget builder(BuildContext context, GameViewModel viewModel) => DeferredPointerHandler(
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            ResponsiveLayoutBuilder(
              smallScreenBuilder: (context) => ChatSheetSmall(gameViewModel: viewModel),
              largeScreenBuilder: (context) => ChatSheetLarge(gameViewModel: viewModel),
            ),
            if (viewModel.gameSuccess)
              Positioned.fill(
                top: -55,
                right: 15,
                child: Align(
                  alignment: Alignment.topRight,
                  child: DeferPointer(
                    child: GradientButton(
                      fontSize: 22,
                      onPressed: () async {
                        await viewModel.postScore();
                      },
                      label: "Post your score",
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
}
