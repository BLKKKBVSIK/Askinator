import 'dart:math';

import 'package:askinator/di/service_locator.dart';
import 'package:askinator/screens/game/game_viewmodel.dart';
import 'package:askinator/screens/game/widgets/askinator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:google_fonts/google_fonts.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:stacked/stacked.dart';

import '../../misc/color_theme.dart';

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
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  margin: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 4,
                      color: ColorTheme.theme.primary.withOpacity(0.3),
                      strokeAlign: BorderSide.strokeAlignOutside,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: ColorTheme.theme.primary,
                        blurRadius: 16,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  // padding: const EdgeInsets.all(4),
                  clipBehavior: Clip.antiAlias,
                  child: SizedBox.square(
                    dimension: 400,
                    child: AnimatedMeshGradient(
                      colors: [
                        ColorTheme.theme.primary,
                        ColorTheme.theme.secondaryVariant,
                        ColorTheme.theme.secondary,
                        ColorTheme.theme.primaryVariant,
                      ],
                      options: AnimatedMeshGradientOptions(frequency: 2, speed: 2),
                      child: ColoredBox(color: ColorTheme.theme.background.withOpacity(0.1)),
                    ),
                  ),
                ),
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
                  backgroundColor: Colors.transparent, // ColorTheme.theme.background.withOpacity(0.65),
                  body: Stack(
                    alignment: AlignmentDirectional.bottomCenter,
                    children: [
                      const SizedBox(height: double.infinity),
                      Positioned(
                        top: 100,
                        left: 0,
                        right: 0,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                              child: Text(
                                'Askinator',
                                style: GoogleFonts.shadowsIntoLight().copyWith(
                                  color: ColorTheme.theme.onBackground.withOpacity(0.8),
                                  fontSize: 28,
                                  // fontWeight: FontWeight.w600,
                                ),
                                // Theme.of(context)
                                //     .textTheme
                                //     .titleSmall!
                                //     .copyWith(color: ColorTheme.theme.onBackground.withOpacity(0.8)),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
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
                          ],
                        ),
                      ),
                      const Positioned(
                        top: -16,
                        left: -22,
                        right: 0,
                        bottom: 0,
                        child: Askinator(),
                      ),

                      // Prompt + expanding chat
                      Column(
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
                            padding: const EdgeInsets.all(8.0),
                            child: TextField(
                              decoration: InputDecoration(
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(Radius.circular(32)),
                                  borderSide: BorderSide(color: ColorTheme.theme.secondary),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: const BorderRadius.all(Radius.circular(32)),
                                  borderSide: BorderSide(color: ColorTheme.theme.primaryVariant),
                                ),
                                hintText: 'Ask a question',
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
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}
