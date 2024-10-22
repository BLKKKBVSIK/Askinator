import 'package:askinator/di/service_locator.dart';
import 'package:askinator/misc/color_theme.dart';
import 'package:askinator/misc/responsive_layout_builder.dart';
import 'package:askinator/screens/home/home_viewmodel.dart';
import 'package:askinator/screens/shared/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesh_gradient/mesh_gradient.dart';
import 'package:stacked/stacked.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => sl<HomeViewModel>(),
      builder: (context, viewModel, child) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: const AssetImage('assets/home-background.jpg'),
              fit: MediaQuery.sizeOf(context).width > ResponsiveLayoutBuilder.thresholdWidth
                  ? BoxFit.cover
                  : BoxFit.fitHeight,
              alignment: const Alignment(.07, 0)),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 280),
                GradientButton(onPressed: viewModel.navigateToGameView),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
