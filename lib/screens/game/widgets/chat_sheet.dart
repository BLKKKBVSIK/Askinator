import 'dart:ui';

import 'package:askinator/misc/color_theme.dart';
import 'package:askinator/misc/lottie_decoder.dart';
import 'package:askinator/misc/responsive_layout_builder.dart';
import 'package:askinator/screens/game/game_viewmodel.dart';
import 'package:askinator/screens/game/widgets/chat_sheet_large.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:mesh_gradient/mesh_gradient.dart';

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

class ChatSheetSmall extends StatefulWidget {
  const ChatSheetSmall({super.key, required this.gameViewModel});

  final GameViewModel gameViewModel;

  @override
  State<StatefulWidget> createState() => ChatSheetSmallState();
}

class ChatSheetSmallState extends State<ChatSheetSmall> with TickerProviderStateMixin {
  late final _animationController = AnimationController(
    vsync: this,
    value: 0,
    duration: const Duration(milliseconds: 400),
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.fastOutSlowIn,
  )..addStatusListener((status) {
      if ({AnimationStatus.completed, AnimationStatus.dismissed}.contains(status)) setState(() {});
    });

  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _textEditingFocus = FocusNode();

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
                  icon: Icon(_animation.value == 1 ? Icons.arrow_downward : Icons.arrow_upward),
                  color: ColorTheme.theme.onBackground,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
                  child: widget.gameViewModel.gameSuccess
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(36),
                          child: AnimatedMeshGradient(
                            colors: [
                              ColorTheme.theme.primary,
                              ColorTheme.theme.secondaryVariant,
                              ColorTheme.theme.secondary,
                              ColorTheme.theme.primaryVariant,
                            ],
                            options: AnimatedMeshGradientOptions(frequency: 2, speed: 2),
                            child: OutlinedButton(
                              onPressed: widget.gameViewModel.initGame,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                                child: Text(
                                  'Play again',
                                  style: GoogleFonts.shadowsIntoLight().copyWith(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
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
                      customMessageBuilder: ChatSheet.customMessageBuilder,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
