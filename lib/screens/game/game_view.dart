import 'package:askinator/di/service_locator.dart';
import 'package:askinator/screens/game/game_viewmodel.dart';
import 'package:askinator/screens/game/widgets/animated_moon.dart';
import 'package:askinator/screens/game/widgets/askinator.dart';
import 'package:askinator/screens/game/widgets/chat_bubble.dart';
import 'package:askinator/screens/game/widgets/chat_sheet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

import '../../misc/color_theme.dart';

class GameView extends StatefulWidget {
  const GameView({super.key});

  @override
  State<StatefulWidget> createState() => GameViewState();
}

class GameViewState extends State<GameView> {
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

                      const Positioned(
                        top: 500,
                        right: 0,
                        left: 0,
                        child: Center(child: ChatBubble()),
                      ),


                      // Prompt + expanding chat
                      ChatSheet(
                        gameViewModel: viewModel,
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
