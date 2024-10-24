import 'dart:ui';

import 'package:askinator/misc/color_theme.dart';
import 'package:askinator/screens/game/game_viewmodel.dart';
import 'package:askinator/screens/shared/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatSheetLarge extends StatefulWidget {
  const ChatSheetLarge({super.key, required this.gameViewModel});

  final GameViewModel gameViewModel;

  @override
  State<StatefulWidget> createState() => ChatSheetLargeState();
}

class ChatSheetLargeState extends State<ChatSheetLarge> with TickerProviderStateMixin {
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _textEditingFocus = FocusNode();

  @override
  void dispose() {
    _textEditingController.dispose();
    _textEditingFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Material(
        elevation: 1,
        color: Colors.transparent,
        shadowColor: ColorTheme.theme.primary.withOpacity(0.4),
        child: Container(
          decoration: BoxDecoration(
            border: Border(left: BorderSide(color: ColorTheme.theme.background, width: 2)),
            color: ColorTheme.theme.background.withOpacity(0.4),
          ),
          child: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Chat(
                      messages: widget.gameViewModel.messages,
                      onSendPressed: (_) {},
                      user: const types.User(id: 'player'),
                      customBottomWidget: const SizedBox(),
                      theme: DefaultChatTheme(
                        backgroundColor: Colors.transparent,
                        primaryColor: ColorTheme.theme.primary,
                        secondaryColor: ColorTheme.theme.secondary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                    child: widget.gameViewModel.gameSuccess
                        ? GradientButton(onPressed: widget.gameViewModel.initGame)
                        : Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(32)),
                              boxShadow: [
                                BoxShadow(
                                  color: ColorTheme.theme.primary,
                                  blurRadius: 36,
                                  blurStyle: BlurStyle.outer,
                                ),
                                BoxShadow(
                                  color: ColorTheme.theme.secondary.withOpacity(0.7),
                                  blurRadius: 4,
                                  blurStyle: BlurStyle.outer,
                                ),
                              ],
                            ),
                            child: TextField(
                              focusNode: _textEditingFocus,
                              decoration: InputDecoration(
                                floatingLabelBehavior: FloatingLabelBehavior.never,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(Radius.circular(32)),
                                  borderSide: BorderSide(
                                    color: ColorTheme.theme.secondary.withOpacity(0.7),
                                    width: 1.5,
                                    strokeAlign: BorderSide.strokeAlignOutside,
                                  ),
                                ),
                                contentPadding: const EdgeInsets.all(20),
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(Radius.circular(32)),
                                  borderSide: BorderSide(color: ColorTheme.theme.primaryVariant),
                                ),
                                hintText: 'Is it a man ?',
                                hintStyle:
                                    Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.grey.shade700),
                                label: const Text('Ask a question to Askinator'),
                              ),
                              style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
                              controller: _textEditingController,
                              onSubmitted: (text) {
                                _textEditingController.clear();
                                _textEditingFocus.requestFocus();
                                widget.gameViewModel.askQuestion(text);
                              },
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
