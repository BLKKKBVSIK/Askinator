import 'dart:ui';

import 'package:askinator/di/service_locator.dart';
import 'package:askinator/screens/game/game_viewmodel.dart';
import 'package:askinator/screens/game/widgets/animated_moon.dart';
import 'package:askinator/screens/game/widgets/askinator.dart';
import 'package:askinator/screens/game/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';

import '../../misc/color_theme.dart';
import '../../misc/lottie_decoder.dart';

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<StatefulWidget> createState() => GameViewState();
}

class GameViewState extends State<GameView> with TickerProviderStateMixin {
  late final _animationController = AnimationController(
    vsync: this,
    value: 0,
    duration: const Duration(milliseconds: 400),
  );

  late final Animation<double> _animation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.fastOutSlowIn,
  );

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GameViewModel>.reactive(
        viewModelBuilder: () => sl<GameViewModel>(),
        builder: (context, viewModel, child) {
          return Stack(
            children: [
              const Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: AnimatedMoon(),
              ),
              Container(
                decoration: BoxDecoration(
                  backgroundBlendMode: BlendMode.saturation,
                  image: const DecorationImage(
                    image: AssetImage('assets/background.jpg'),
                    opacity: 0.4,
                    alignment: Alignment(0.25, 0),
                    fit: BoxFit.fitHeight,
                  ),
                  gradient: RadialGradient(
                    colors: [
                      ColorTheme.theme.primary,
                      ColorTheme.theme.background,
                    ],
                    stops: const [0, 0.6],
                    center: const Alignment(0, -0.75),
                    radius: 2,
                    tileMode: TileMode.clamp,
                  ),
                ),
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    backgroundColor: Colors.transparent,
                    foregroundColor: Colors.white,
                    title: Text(
                      'Askinator',
                      style: GoogleFonts.shadowsIntoLight().copyWith(
                        color: ColorTheme.theme.onBackground.withOpacity(0.8),
                        fontSize: 36,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  body: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      const SizedBox(height: double.infinity),

                      const Positioned(
                        top: 500,
                        right: 0,
                        left: 0,
                        child: Center(child: ChatBubble()),
                      ),

                      // Texts
                      Positioned(
                        top: 50,
                        left: 0,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                          child: Text(
                            'What am I thinking of ?',
                            style: GoogleFonts.shadowsIntoLight().copyWith(
                              color: ColorTheme.theme.onBackground,
                              fontSize: 42,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),

                      Positioned(
                        top: -140,
                        left: -22,
                        right: 0,
                        bottom: 0,
                        child: Askinator(
                          onTap: () async {
                            // await _chatBubbleAnimationController.forward();
                            // _chatBubbleAnimationController.reset();
                          },
                        ),
                      ),

                      // Prompt + expanding chat
                      ClipRect(
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
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 36),
                                SizeTransition(
                                  sizeFactor: _animation,
                                  child: SizedBox(
                                    height: MediaQuery.sizeOf(context).height * 0.6,
                                    child: Chat(
                                      messages: viewModel.getMessages(),
                                      onSendPressed: (_) {},
                                      user: const types.User(id: 'self'),
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
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}
