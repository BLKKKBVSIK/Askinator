import 'dart:ui';

import 'package:askinator/misc/color_theme.dart';
import 'package:askinator/misc/responsive_layout_builder.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CreditsView extends StatelessWidget {
  const CreditsView({super.key});

  TextStyle _textStyle(BuildContext context) =>
      Theme.of(context).textTheme.titleSmall!.copyWith(color: ColorTheme.theme.background);

  @override
  Widget build(BuildContext context) => ColoredBox(
        color: ColorTheme.theme.backgroundOverlay,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('assets/background.jpg'),
              opacity: 0.7,
              alignment: const Alignment(0.25, 0),
              fit: MediaQuery.sizeOf(context).width > ResponsiveLayoutBuilder.thresholdWidth
                  ? BoxFit.cover
                  : BoxFit.fitHeight,
            ),
            color: ColorTheme.theme.background.withOpacity(0.4),
          ),
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              foregroundColor: Colors.white,
              title: Text(
                'Credits',
                style: GoogleFonts.shadowsIntoLight().copyWith(
                  color: ColorTheme.theme.onBackground.withOpacity(0.8),
                  fontSize: 36,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            backgroundColor: Colors.transparent,
            body: Center(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(36),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(36),
                      ),
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Project made by \n Enzo Conty and Tanguy Pouriel \n for Appwrite Hacktobersfest 2024.',
                            style: Theme.of(context).textTheme.titleLarge!.copyWith(color: ColorTheme.theme.background),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 56),
                          Text(
                            'Images from Freepik',
                            style: _textStyle(context),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Pumpkin animation from LottieFiles',
                            style: _textStyle(context),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            'Dracula character from Rive Community files',
                            style: _textStyle(context),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
