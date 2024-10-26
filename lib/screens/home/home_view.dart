import 'dart:async';
import 'dart:math';

import 'package:askinator/di/service_locator.dart';
import 'package:askinator/misc/color_theme.dart';
import 'package:askinator/misc/responsive_layout_builder.dart';
import 'package:askinator/screens/home/home_viewmodel.dart';
import 'package:askinator/screens/shared/gradient_button.dart';
import 'package:askinator/screens/shared/sound_button.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart' hide RadialGradient, Image;
import 'package:stacked/stacked.dart';

import '../splash/splash_viewmodel.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  static const double _batDimension = 300;
  static const _batSpeed = 0.6; // px/ms

  bool goToLeft = false;

  late final AnimationController _animationController = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
    value: 0.5,
  )
    ..addListener(() {
      setState(() {});
    })
    ..addStatusListener((status) async {
      if (AnimationStatus.completed != status) return;

      // Random delay between each bat apparition
      await Future.delayed(Duration(milliseconds: 200 + Random().nextInt(1200)));

      goToLeft = !goToLeft;

      final record = _newRandomAnimation();
      _offsetAnimation = record.$1;
      final distanceTravelled = record.$2;

      _animationController.duration = Duration(milliseconds: (distanceTravelled / _batSpeed).toInt());
      _animationController.forward(from: 0);
    });

  late Animation<Offset> _offsetAnimation = CurvedAnimation(
    parent: _animationController,
    curve: Curves.slowMiddle,
  ).drive(Tween(
    // Initial animation
    begin: Offset(-_batDimension, MediaQuery.sizeOf(context).height),
    end: Offset(MediaQuery.sizeOf(context).width, -_batDimension),
  ));

  (Animation<Offset>, double distance) _newRandomAnimation() {
    final tween = Tween(
      begin: Offset(
        goToLeft ? MediaQuery.sizeOf(context).width : -_batDimension,
        MediaQuery.sizeOf(context).height * (1 - (Random().nextDouble() / 2)),
      ),
      end: Offset(
        goToLeft ? -_batDimension : MediaQuery.sizeOf(context).width,
        -_batDimension + (MediaQuery.sizeOf(context).height * Random().nextDouble() / 2),
      ),
    );

    return (
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.slowMiddle,
      ).drive(tween),
      (tween.end! - tween.begin!).distance
    );
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 500), () {
      _animationController.forward();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => sl<HomeViewModel>(),
      onViewModelReady: (viewModel) {
        if (kIsWeb) return;

        sl<SplashViewModel>().playMusic();
      },
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
              body: SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const Spacer(),
                            Text(
                              'Askinator',
                              style: GoogleFonts.shadowsIntoLight().copyWith(
                                color: Colors.white,
                                fontSize: 56,
                                fontWeight: FontWeight.w500,
                                shadows: [
                                  BoxShadow(
                                    color: ColorTheme.theme.background,
                                    blurRadius: kIsWeb ? 8 : 60,
                                  ),
                                ],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const Expanded(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: SoundButton(),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                        child: Text(
                          'Will you dare challenge me ?',
                          style: GoogleFonts.shadowsIntoLight().copyWith(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            shadows: [
                              BoxShadow(
                                color: ColorTheme.theme.secondaryVariant,
                                blurRadius: kIsWeb ? 8 : 40,
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const Spacer(),
                      GradientButton(onPressed: viewModel.navigateToGameView),
                      const SizedBox(height: 36),
                      ElevatedButton(
                        onPressed: viewModel.navigateToLeaderboardView,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Leaderboard',
                              style: Theme.of(context).textTheme.titleSmall!.copyWith(color: ColorTheme.theme.primary),
                            ),
                            const SizedBox(width: 16),
                            Icon(
                              Icons.leaderboard_outlined,
                              color: ColorTheme.theme.primary,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: MediaQuery.sizeOf(context).height * .07),
                      Padding(
                        padding: kIsWeb ? const EdgeInsets.symmetric(vertical: 36) : EdgeInsets.zero,
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
          ),
          Positioned(
            left: _offsetAnimation.value.dx,
            top: _offsetAnimation.value.dy,
            child: SizedBox.square(
              dimension: _batDimension,
              child: Transform.flip(
                flipX: goToLeft,
                child: RiveAnimation.direct(
                  sl<SplashViewModel>().batFile,
                  fit: BoxFit.contain,
                  // onInit: (artboard) => GameView.onRiveInit(artboard, viewModel),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
