import 'dart:ui';

import 'package:askinator/di/service_locator.dart';
import 'package:askinator/misc/color_theme.dart';
import 'package:askinator/screens/leaderboard/leaderboard_viewmodel.dart';
import 'package:askinator/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stacked/stacked.dart';

class LeaderboardView extends StatelessWidget {
  const LeaderboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LeaderboardViewModel>.reactive(
      viewModelBuilder: () => sl<LeaderboardViewModel>(),
      onViewModelReady: (viewModel) async => await viewModel.initialise(),
      builder: (context, viewModel, child) => Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.jpg'),
            opacity: 0.4,
            alignment: Alignment(0.25, 0),
            fit: BoxFit.fitHeight,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: [
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
                  SizedBox(
                    height: MediaQuery.sizeOf(context).height * 0.2,
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
                                  'assets/candy-rotated.png',
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
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: viewModel.leaderboardEntries.length,
                    itemBuilder: (context, index) {
                      final entry = viewModel.leaderboardEntries.elementAtOrNull(index);

                      bool isSelf = index == 3;

                      if (entry == null) return const SizedBox();

                      return Container(
                        decoration: BoxDecoration(
                          color: isSelf ? ColorTheme.theme.primary.withOpacity(0.9) : Colors.transparent,
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
                                0 => Image.asset('assets/medal-first.png', height: 36),
                                1 => Image.asset('assets/medal-second.png', height: 36),
                                2 => Image.asset('assets/medal-third.png', height: 36),
                                _ => const SizedBox(),
                              },
                              const SizedBox(width: 24),
                              Text(
                                '200',
                                style: GoogleFonts.shadowsIntoLight().copyWith(
                                  color: ColorTheme.theme.secondary.withOpacity(0.8),
                                  fontSize: 36,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Image.asset(
                                width: 36,
                                'assets/candy-rotated.png',
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
