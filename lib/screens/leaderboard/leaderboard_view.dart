import 'package:askinator/di/service_locator.dart';
import 'package:askinator/screens/leaderboard/leaderboard_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class LeaderboardView extends StatelessWidget {
  const LeaderboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LeaderboardViewModel>.reactive(
      viewModelBuilder: () => sl<LeaderboardViewModel>(),
      onViewModelReady: (viewModel) async => await viewModel.initialise(),
      builder: (context, viewModel, child) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text('Leaderboard'),
                SizedBox(height: 100),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: viewModel.leaderboardEntries.length,
                  itemBuilder: (context, index) {
                    final entry = viewModel.leaderboardEntries.elementAtOrNull(index);

                    if (entry == null) return const SizedBox();

                    return ListTile(
                      title: Text('User ${entry.playerName}'),
                      subtitle: Text('Score: ${entry.score}'),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
