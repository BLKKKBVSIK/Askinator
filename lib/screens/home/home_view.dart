import 'package:askinator/di/service_locator.dart';
import 'package:askinator/screens/home/home_viewmodel.dart';
import 'package:askinator/screens/splash/splash_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => sl<HomeViewModel>(),
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
