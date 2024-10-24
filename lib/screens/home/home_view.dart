import 'package:askinator/di/service_locator.dart';
import 'package:askinator/misc/responsive_layout_builder.dart';
import 'package:askinator/screens/home/home_viewmodel.dart';
import 'package:askinator/screens/shared/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => sl<HomeViewModel>(),
      builder: (context, viewModel, child) => Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/home-background.jpg'),
                fit: MediaQuery.sizeOf(context).width > ResponsiveLayoutBuilder.thresholdWidth
                    ? BoxFit.cover
                    : BoxFit.fitHeight,
                alignment: const Alignment(.07, 0),
              ),
            ),
            child: Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 180),
                    ElevatedButton(
                      onPressed: viewModel.navigateToLeaderboardView,
                      child: const Text('Leaderboard'),
                    ),
                    const SizedBox(height: 128),
                    GradientButton(onPressed: viewModel.navigateToGameView),
                    const SizedBox(height: 128),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(36.0),
                      child: TextButton(
                        onPressed: viewModel.navigateToCreditsView,
                        child: Text(
                          'Credits',
                          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                color: Colors.white,
                                decoration: TextDecoration.underline,
                                decorationColor: Colors.white,
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
    );
  }
}
