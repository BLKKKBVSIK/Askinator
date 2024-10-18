import 'package:askinator/di/service_locator.dart';
import 'package:askinator/misc/responsive_layout_builder.dart';
import 'package:askinator/screens/game/game_view_small.dart';
import 'package:askinator/screens/game/game_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:rive/rive.dart' hide RadialGradient;
import 'package:stacked/stacked.dart';

import 'game_view_large.dart';

class GameView extends StatelessWidget {
  const GameView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<GameViewModel>.reactive(
      viewModelBuilder: () => sl<GameViewModel>()..initGame(),
      builder: (context, viewModel, child) => ResponsiveLayoutBuilder(
        smallScreenBuilder: (context) => GameViewSmall(viewModel: viewModel),
        largeScreenBuilder: (context) => GameViewLarge(viewModel: viewModel),
      ),
    );
  }

  static void onRiveInit(Artboard artboard, GameViewModel viewModel) {
    final controller = StateMachineController.fromArtboard(artboard, 'State Machine 1');
    artboard.addController(controller!);

    viewModel.onRiveLoaded(controller);
  }
}
