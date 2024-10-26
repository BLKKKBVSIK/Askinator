import 'package:askinator/di/service_locator.dart';
import 'package:askinator/misc/responsive_layout_builder.dart';
import 'package:askinator/screens/splash/splash_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class SoundButton extends StatelessWidget {
  const SoundButton({super.key});

  @override
  Widget build(BuildContext context) => ViewModelBuilder.reactive(
        viewModelBuilder: () => sl<SplashViewModel>(),
        disposeViewModel: false,
        builder: (context, viewModel, child) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox.square(
            dimension: MediaQuery.sizeOf(context).width > ResponsiveLayoutBuilder.thresholdWidth ? 64 : 48,
            child: Stack(
              children: [
                Image.asset(
                  viewModel.isPlayingMusic ? 'assets/sound-on.png' : 'assets/sound-off.png',
                  cacheHeight: 64,
                  cacheWidth: 64,
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(128),
                    radius: 100,
                    onTap: sl<SplashViewModel>().toggleMusic,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
