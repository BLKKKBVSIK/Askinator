
import 'dart:ui';

import 'package:askinator/misc/color_theme.dart';
import 'package:askinator/screens/game/game_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;

class ChatSheet extends StatefulWidget {
  const ChatSheet({super.key, required this.gameViewModel});

  final GameViewModel gameViewModel;

  @override
  State<StatefulWidget> createState() => ChatSheetState();
}

class ChatSheetState extends State<ChatSheet> with TickerProviderStateMixin {

  late final _animationController = AnimationController(
    vsync: this,
    value: 0,
    duration: const Duration(milliseconds: 400),
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.fastOutSlowIn,
  );

  late final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _animationController.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ClipRect(
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
      child: Material(
        elevation: 2,
        color: ColorTheme.theme.background.withOpacity(0.7),
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(36),
          topLeft: Radius.circular(36),
        ),
        shadowColor: ColorTheme.theme.primary,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              onPressed: () {
                if (_animationController.isAnimating) return;

                if (_animation.value == 1) {
                  _animationController.reverse();
                  return;
                }

                _animationController.forward();
              },
              icon: const Icon(Icons.arrow_upward),
              color: ColorTheme.theme.onBackground,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
              child: Container(
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
                    label: const Text('Ask a question to Askinator'),
                  ),
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Colors.white),
                  controller: _textEditingController,
                  onSubmitted: (text) {
                    _textEditingController.clear();
                    widget.gameViewModel.askQuestion(text);
                  },
                ),
              ),
            ),
            const SizedBox(height: 36),
            SizeTransition(
              sizeFactor: _animation,
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.6,
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
            ),
          ],
        ),
      ),
    ),
  );

}