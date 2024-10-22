import 'package:askinator/di/service_locator.dart';
import 'package:askinator/screens/splash/splash_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:askinator/screens/game/widgets/animated_moon.dart';
import 'package:askinator/screens/game/widgets/chat_bubble.dart';
import 'package:askinator/screens/game/widgets/chat_sheet.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart' hide RadialGradient;

import '../../misc/color_theme.dart';
import 'game_view.dart';
import 'game_viewmodel.dart';

class GameViewSmall extends StatelessWidget {
  const GameViewSmall({super.key, required this.viewModel});

  final GameViewModel viewModel;

  @override
  Widget build(BuildContext context) => ColoredBox(
    color: ColorTheme.theme.backgroundOverlay,
    child: Stack(
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
                  stops: const [0, 0.7],
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

                    Positioned(
                      top: 30,
                      left: 0,
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4),
                        child: Text(
                          // Warning : duplicate with GameViewLarge
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

                    Positioned(
                      top: -140,
                      left: -22,
                      right: 0,
                      bottom: 0,
                      child: RiveAnimation.direct(
                        sl<SplashViewModel>().batFile,
                        onInit: (artboard) => GameView.onRiveInit(artboard, viewModel),
                      ),
                    ),

                    Positioned(
                      top: 500,
                      right: 0,
                      left: 0,
                      child: Center(child: ChatBubble(gameViewModel: viewModel)),
                    ),

                    // Prompt + expanding chat
                    ChatSheet(gameViewModel: viewModel),
                  ],
                ),
              ),
            ),
          ],
        ),
  );
}
