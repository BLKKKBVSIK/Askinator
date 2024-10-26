import 'package:askinator/di/service_locator.dart';
import 'package:askinator/screens/splash/splash_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';

import '../../misc/lottie_decoder.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<StatefulWidget> createState() => SplashViewState();
}

class SplashViewState extends State<SplashView> {
  double _circleSize = 0;
  bool _showPumpkinLoader = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _circleSize = MediaQuery.sizeOf(context).longestSide * 1.7;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.nonReactive(
      viewModelBuilder: () => sl<SplashViewModel>()..init(),
      disposeViewModel: false,
      builder: (context, viewModel, child) => ColoredBox(
        color: Colors.white,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              right: -MediaQuery.sizeOf(context).longestSide,
              left: -MediaQuery.sizeOf(context).longestSide,
              top: -MediaQuery.sizeOf(context).longestSide * 0.5,
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 2000),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff9d62d0),
                  ),
                  curve: Curves.easeOutQuart,
                  height: _circleSize,
                  width: _circleSize,
                  onEnd: () {
                    viewModel.onAnimationCompleted(() {
                      setState(() {
                        _showPumpkinLoader = false;
                      });
                    });
                  },
                ),
              ),
            ),
            Scaffold(
              backgroundColor: Colors.transparent,
              body: _showPumpkinLoader
                  ? Center(
                      child: Lottie.asset(
                        'assets/pumpkin.lottie',
                        decoder: customDecoder,
                        width: 128,
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
