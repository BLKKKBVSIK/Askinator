import 'package:askinator/di/service_locator.dart';
import 'package:askinator/misc/color_theme.dart';
import 'package:askinator/misc/responsive_layout_builder.dart';
import 'package:askinator/screens/home/home_viewmodel.dart';
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
                ClipRRect(
                  borderRadius: BorderRadius.circular(36),
                  child: AnimatedMeshGradient(
                    colors: [
                      ColorTheme.theme.primary,
                      ColorTheme.theme.background,
                      ColorTheme.theme.primary,
                      ColorTheme.theme.primary,
                    ],
                    options: AnimatedMeshGradientOptions(frequency: 2, speed: 2),
                    child: OutlinedButton(
                      onPressed: viewModel.navigateToGameView,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
                        child: Text(
                          'Start a game !',
                          style: GoogleFonts.shadowsIntoLight().copyWith(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
