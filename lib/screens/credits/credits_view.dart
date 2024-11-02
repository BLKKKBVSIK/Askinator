import 'dart:ui';

import 'package:askinator/misc/color_theme.dart';
import 'package:askinator/misc/responsive_layout_builder.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CreditsView extends StatelessWidget {
  const CreditsView({super.key});

  @override
  Widget build(BuildContext context) => ColoredBox(
        color: ColorTheme.theme.backgroundOverlay,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: const AssetImage('assets/images/background.jpg'),
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
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              style:
                                  Theme.of(context).textTheme.titleLarge!.copyWith(color: ColorTheme.theme.background),
                              children: <TextSpan>[
                                const TextSpan(text: 'Project made by \n'),
                                TextSpan(
                                  text: 'Enzo Conty',
                                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                        color: ColorTheme.theme.secondary,
                                        decoration: TextDecoration.underline,
                                        decorationColor: ColorTheme.theme.secondary,
                                      ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => launchUrlString('https://www.enzoconty.dev/'),
                                ),
                                const TextSpan(text: ' and '),
                                TextSpan(
                                  text: 'Tanguy Pouriel \n',
                                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                        color: ColorTheme.theme.secondary,
                                        decoration: TextDecoration.underline,
                                        decorationColor: ColorTheme.theme.secondary,
                                      ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => launchUrlString('https://www.tanguypouriel.dev/'),
                                ),
                                const TextSpan(text: 'for '),
                                TextSpan(
                                  text: 'Appwrite Hacktobersfest 2024.',
                                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                        color: ColorTheme.theme.secondary,
                                        decoration: TextDecoration.underline,
                                        decorationColor: ColorTheme.theme.secondary,
                                      ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () => launchUrlString('https://appwrite.io/'),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 56),
                          _buildClickableText(
                            'Images by ',
                            'Freepik',
                            context,
                            textUrlDestination: 'https://fr.freepik.com/',
                          ),
                          _buildClickableText(
                            'Pumpkin animation by ',
                            'Fanden Sriwarom',
                            context,
                            textUrlDestination: 'https://lottiefiles.com/free-animation/pumpkin-Mx6sqbUljT',
                          ),
                          _buildClickableText(
                            'Dracula character by ',
                            'drawsgood',
                            context,
                            textUrlDestination: 'https://rive.app/community/files/1299-2499-bat/',
                          ),
                          _buildClickableText(
                            'Font by ',
                            'Kimberly Geswein',
                            context,
                            textUrlDestination: 'https://fonts.google.com/specimen/Shadows+Into+Light',
                          ),
                          _buildClickableText(
                            'Music by ',
                            'FASSounds',
                            context,
                            textUrlDestination:
                                'https://pixabay.com/music/scary-childrens-tunes-funny-halloween-spooky-horror-background-music-242101/',
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

  Widget _buildClickableText(
    String text,
    String clickableText,
    BuildContext context, {
    required String textUrlDestination,
  }) {
    TextStyle defaultStyle = Theme.of(context).textTheme.titleSmall!.copyWith(color: ColorTheme.theme.background);
    TextStyle linkStyle = defaultStyle.copyWith(
      color: ColorTheme.theme.secondary,
      decoration: TextDecoration.underline,
      decorationColor: ColorTheme.theme.secondary,
    );

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: defaultStyle,
        children: <TextSpan>[
          TextSpan(text: text),
          TextSpan(
            text: clickableText,
            style: linkStyle,
            recognizer: TapGestureRecognizer()..onTap = () => launchUrlString(textUrlDestination),
          ),
        ],
      ),
    );
  }
}
