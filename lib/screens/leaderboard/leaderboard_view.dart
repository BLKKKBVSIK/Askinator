import 'dart:ui';

import 'package:askinator/di/service_locator.dart';
import 'package:askinator/misc/color_theme.dart';
import 'package:askinator/misc/responsive_layout_builder.dart';
import 'package:askinator/screens/leaderboard/leaderboard_viewmodel.dart';
import 'package:askinator/screens/shared/gradient_button.dart';
import 'package:askinator/services/navigation_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

class LeaderboardView extends StatelessWidget {
  const LeaderboardView({
    super.key,
    this.score,
  });

  final int? score;

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: ColorTheme.theme.backgroundOverlay,
      child: ViewModelBuilder<LeaderboardViewModel>.reactive(
        viewModelBuilder: () => sl<LeaderboardViewModel>(),
        onViewModelReady: (viewModel) async => await viewModel.initialise(),
        builder: (context, viewModel, child) => Container(
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
            backgroundColor: Colors.transparent,
            body: Stack(
              children: [
                SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        kIsWeb ? const SizedBox(height: 24) : const SizedBox(),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: IconButton(
                                onPressed: sl<NavigationService>().goBack,
                                icon: const Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Text(
                              'Leaderboard',
                              style: GoogleFonts.shadowsIntoLight().copyWith(
                                color: Colors.white,
                                fontSize: 36,
                              ),
                            ),
                            const Spacer(),
                            const SizedBox(width: 68),
                          ],
                        ),
                        const SizedBox(height: 50),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
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
                                  children: [
                                    SizedBox(
                                      child: Align(
                                        alignment: const Alignment(0, .5),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: ColorTheme.theme.primary.withOpacity(0.8),
                                                borderRadius: BorderRadius.circular(36),
                                              ),
                                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                                              child: Text(
                                                '4th',
                                                style: GoogleFonts.shadowsIntoLight().copyWith(
                                                  color: Colors.white,
                                                  fontSize: 36,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(width: 4),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: ColorTheme.theme.background.withOpacity(0.7),
                                                borderRadius: BorderRadius.circular(36),
                                              ),
                                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Image.asset(
                                                    width: 45,
                                                    'assets/images/candy-rotated.png',
                                                    semanticLabel: 'score icon',
                                                  ),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    '200',
                                                    style: GoogleFonts.shadowsIntoLight().copyWith(
                                                      color: Colors.white,
                                                      fontSize: 36,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.sizeOf(context).width > ResponsiveLayoutBuilder.thresholdWidth
                                          ? MediaQuery.sizeOf(context).width * 0.7
                                          : MediaQuery.sizeOf(context).width,
                                      decoration: kIsWeb
                                          ? BoxDecoration(
                                              border: Border.all(color: Colors.white, width: 2),
                                              borderRadius: BorderRadius.circular(36),
                                            )
                                          : null,
                                      margin: const EdgeInsets.only(bottom: 24),
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics: const NeverScrollableScrollPhysics(),
                                        itemCount: viewModel.leaderboardEntries.length,
                                        itemBuilder: (context, index) {
                                          final entry = viewModel.leaderboardEntries.elementAtOrNull(index);

                                          bool isSelf = index == 3;

                                          if (entry == null) return const SizedBox();

                                          return Container(
                                            decoration: BoxDecoration(
                                              color: isSelf
                                                  ? ColorTheme.theme.primary.withOpacity(0.9)
                                                  : Colors.transparent,
                                              borderRadius: BorderRadius.circular(30),
                                            ),
                                            margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                                            child: ListTile(
                                              contentPadding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                                              leading: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: CircleAvatar(
                                                  backgroundColor: ColorTheme.theme.secondary,
                                                  child: Text(
                                                    (index + 1).toString(),
                                                    style: GoogleFonts.shadowsIntoLight().copyWith(
                                                      color: Colors.white,
                                                      fontSize: 26,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              title: Text(
                                                entry.playerName,
                                                style: GoogleFonts.shadowsIntoLight().copyWith(
                                                  color: Colors.white,
                                                  fontSize: 30,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                              trailing: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  switch (index) {
                                                    0 => Image.asset(
                                                        'assets/images/medal-first.png',
                                                        height: 36,
                                                        semanticLabel: '1st place medal',
                                                      ),
                                                    1 => Image.asset(
                                                        'assets/images/medal-second.png',
                                                        height: 36,
                                                        semanticLabel: '2nd place medal',
                                                      ),
                                                    2 => Image.asset(
                                                        'assets/images/medal-third.png',
                                                        height: 36,
                                                        semanticLabel: '3rd place medal',
                                                      ),
                                                    _ => const SizedBox(),
                                                  },
                                                  const SizedBox(width: 24),
                                                  Text(
                                                    '${entry.score}',
                                                    style: GoogleFonts.shadowsIntoLight().copyWith(
                                                      color: ColorTheme.theme.secondary.withOpacity(0.8),
                                                      fontSize: 36,
                                                      fontWeight: FontWeight.w600,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 12),
                                                  Image.asset(
                                                    width: 36,
                                                    semanticLabel: 'score icon',
                                                    'assets/images/candy-rotated.png',
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (score != null && !viewModel.hasSendScore)
                  Positioned(
                    child: Container(
                      height: MediaQuery.sizeOf(context).height,
                      color: Colors.black.withOpacity(.7),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 16),
                            Stack(
                              children: [
                                Image.asset(
                                  'assets/images/gravestone.png',
                                  semanticLabel: 'Gravestone',
                                ),
                                Positioned.fill(
                                  top: 180,
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Text(
                                      'Score: $score',
                                      style: TextStyle(
                                        fontFamily: "Graveyard",
                                        fontSize: 32,
                                        color: Colors.grey.shade900,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned.fill(
                                  top: 180,
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        CharacterWheelSelector(controller: viewModel.firstCharacterController),
                                        CharacterWheelSelector(controller: viewModel.secondCharacterController),
                                        CharacterWheelSelector(controller: viewModel.thirdCharacterController),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 25),
                            GradientButton(
                              onPressed: () {
                                viewModel.sendScore(score ?? 9999);
                              },
                              label: "Publish your score",
                            )
                          ],
                        ),
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
}

class CharacterWheelSelector extends StatefulWidget {
  const CharacterWheelSelector({super.key, this.controller});

  final TextEditingController? controller;

  @override
  State<CharacterWheelSelector> createState() => _CharacterWheelSelectorState();
}

class _CharacterWheelSelectorState extends State<CharacterWheelSelector> {
  final characterPossibilities = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'I',
    'J',
    'K',
    'L',
    'M',
    'N',
    'O',
    'P',
    'Q',
    'R',
    'S',
    'T',
    'U',
    'V',
    'W',
    'X',
    'Y',
    'Z',
  ];

  int selectedCharacterIndex = 0;

  @override
  void initState() {
    super.initState();
    widget.controller?.text = characterPossibilities.elementAtOrNull(selectedCharacterIndex) ?? 'A';
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                selectedCharacterIndex = (selectedCharacterIndex + 1) % characterPossibilities.length;
                widget.controller?.text = characterPossibilities.elementAtOrNull(selectedCharacterIndex) ?? 'A';
              });
            },
            child: RotatedBox(
              quarterTurns: 1,
              child: Icon(
                Icons.chevron_left,
                size: 42,
                color: Colors.grey.shade900,
              ),
            ),
          ),
          Text(
            characterPossibilities.elementAtOrNull(selectedCharacterIndex) ?? 'A',
            style: TextStyle(
              fontFamily: "Graveyard",
              fontSize: 60,
              color: Colors.grey.shade900,
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                selectedCharacterIndex = (selectedCharacterIndex - 1) % characterPossibilities.length;
                widget.controller?.text = characterPossibilities.elementAtOrNull(selectedCharacterIndex) ?? 'A';
              });
            },
            child: RotatedBox(
              quarterTurns: 1,
              child: Icon(
                Icons.chevron_right,
                size: 42,
                color: Colors.grey.shade900,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
