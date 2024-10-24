import 'package:askinator/screens/game/widgets/chat_bubble.dart';
import 'package:flutter/material.dart';
import 'package:askinator/screens/game/widgets/animated_moon.dart';
import 'package:askinator/screens/game/widgets/chat_sheet.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart' hide RadialGradient, LinearGradient, Image;
import 'package:stacked_hooks/stacked_hooks.dart';

import '../../misc/color_theme.dart';
import 'game_view.dart';
import 'game_viewmodel.dart';

class GameViewLarge extends StackedHookView<GameViewModel> {
  const GameViewLarge({super.key});

  @override
  Widget builder(BuildContext context, GameViewModel viewModel) {
    final double screenHeight = MediaQuery.sizeOf(context).height;

    return Stack(
      children: [
        const Positioned(
          top: 0,
          left: 0,
          bottom: 0,
          right: 0,
          child: Row(
            children: [
              // To center it on the left panel
              Expanded(child: Center(child: AnimatedMoon(isSmall: false))),
              Spacer(),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            backgroundBlendMode: BlendMode.saturation,
            image: const DecorationImage(
              image: AssetImage('assets/background.jpg'),
              opacity: 0.4,
              fit: BoxFit.cover,
            ),
            gradient: LinearGradient(
              colors: [
                ColorTheme.theme.primary,
                ColorTheme.theme.background,
              ],
              stops: const [0, 0.4],
              tileMode: TileMode.clamp,
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            backgroundBlendMode: BlendMode.saturation,
            image: const DecorationImage(
              image: AssetImage('assets/background.jpg'),
              opacity: 0.4,
              fit: BoxFit.cover,
            ),
            gradient: LinearGradient(
              colors: [
                ColorTheme.theme.primary,
                ColorTheme.theme.background,
              ],
              stops: const [0, 0.4],
              tileMode: TileMode.clamp,
              begin: Alignment.topLeft,
              end: Alignment.bottomLeft,
            ),
          ),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 128,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 56.0),
                            child: Text(
                              // Warning : duplicate with GameViewSmall
                              viewModel.gameSuccess ? 'Well done ! You pierced my mind !' : 'What am I thinking of ?',
                              style: GoogleFonts.shadowsIntoLight().copyWith(
                                color: ColorTheme.theme.onBackground,
                                fontSize: 42,
                                fontWeight: FontWeight.w600,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Stack(
                          children: [
                            RiveAnimation.asset(
                              'assets/bat.riv',
                              onInit: (artboard) => GameView.onRiveInit(artboard, viewModel),
                              alignment: const Alignment(-0.2, -.8),
                              fit: BoxFit.contain,
                            ),
                            Positioned(
                              bottom: 0,
                              left: 0,
                              right: 0,
                              child: Center(
                                child: ChatBubble(
                                  gameViewModel: viewModel,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 128),
                    ],
                  ),
                ),

                // Prompt + chat
                Expanded(child: ChatSheet(gameViewModel: viewModel)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
