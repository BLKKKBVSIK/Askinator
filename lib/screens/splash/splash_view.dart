import 'package:askinator/di/service_locator.dart';
import 'package:askinator/screens/splash/splash_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked/stacked.dart';

import '../../misc/lottie_decoder.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      viewModelBuilder: () => sl<SplashViewModel>()..init(),
      builder: (context, viewModel, child) => Scaffold(
        body: Center(
          child: Lottie.asset(
            'assets/pumpkin.lottie',
            decoder: customDecoder,
            width: 128,
          ),
        ),
      ),
    );
  }
}
