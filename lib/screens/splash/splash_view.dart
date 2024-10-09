import 'package:askinator/di/service_locator.dart';
import 'package:askinator/screens/splash/splash_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      viewModelBuilder: () => sl<SplashViewModel>(),
      builder: (context, viewModel, child) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  await viewModel.testMethod();
                },
                child: Container(
                  width: 50,
                  height: 50,
                  color: Colors.red,
                ),
              ),
              const SizedBox(height: 64),
              FilledButton(
                onPressed: viewModel.navigateToGameView,
                child: const Text('Start a game !'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
