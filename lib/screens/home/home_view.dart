import 'dart:async';
import 'dart:math';

import 'package:askinator/di/service_locator.dart';
import 'package:askinator/misc/color_theme.dart';
import 'package:askinator/misc/responsive_layout_builder.dart';
import 'package:askinator/screens/home/home_viewmodel.dart';
import 'package:askinator/screens/shared/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart' hide RadialGradient;
import 'package:stacked/stacked.dart';

import '../splash/splash_viewmodel.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<StatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  static const _animationDuration = Duration(seconds: 3);

  late final AnimationController _yAnimationController = AnimationController(
    duration: _animationDuration,
    vsync: this,
    value: 0.5, //MediaQuery.sizeOf(context).height * 0.5 - (_batDimension / 2),
  );

  late final Animation<double> _yAnimation = Tween(
    begin: -_batDimension,
    end: MediaQuery.sizeOf(context).height,
  ).animate(
    CurvedAnimation(
      parent: _yAnimationController,
      curve: Curves.easeInOut,
    ),
  )..addListener(() {
      setState(() {});
    });

  late final AnimationController _xAnimationController = AnimationController(
    duration: _animationDuration,
    vsync: this,
    value: 0.5, // MediaQuery.sizeOf(context).height * 0.5 - (_batDimension / 2),
  );

  late final Animation<double> _xAnimation =
      Tween(begin: -_batDimension, end: MediaQuery.sizeOf(context).width).animate(CurvedAnimation(
    parent: _xAnimationController,
    curve: Curves.easeInOut,
  ))
        ..addListener(() {
          setState(() {});
        });


  bool goToLeft = false;

  static const double _batDimension = 300;

  void _animatePosition() {
    print('launching animation');

    _xAnimationController.value = goToLeft ? -_batDimension : MediaQuery.sizeOf(context).width;
    _xAnimationController.animateTo(goToLeft ? MediaQuery.sizeOf(context).width : -_batDimension);

    _yAnimationController.value =
        MediaQuery.sizeOf(context).height - ((MediaQuery.sizeOf(context).height / 2) * Random().nextDouble());
    _yAnimationController.animateTo(-_batDimension + ((MediaQuery.sizeOf(context).height / 2) * Random().nextDouble()));

    goToLeft = !goToLeft;
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 1000), () {
      _xAnimationController.animateTo(goToLeft ? MediaQuery.sizeOf(context).width : -_batDimension);
      _yAnimationController.animateTo(-_batDimension + ((MediaQuery.sizeOf(context).height / 2) * Random().nextDouble()));

      Timer.periodic(_animationDuration + const Duration(milliseconds: 500), (_) => _animatePosition());
    });
  }

  @override
  Widget build(BuildContext context) {
    // print('(${_xAnimation.value}, ${_yAnimation.value}');

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
              body: SafeArea(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Askinator',
                          style: GoogleFonts.shadowsIntoLight().copyWith(
                            color: Colors.white,
                            fontSize: 56,
                            fontWeight: FontWeight.w500,
                            shadows: [
                              BoxShadow(
                                color: ColorTheme.theme.background,
                                blurRadius: 60,
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
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
                                blurRadius: 40.0,
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
                      TextButton(
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
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: _xAnimation.value,
            top: _yAnimation.value,
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
