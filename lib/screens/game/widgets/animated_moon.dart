
import 'package:flutter/material.dart';
import 'package:mesh_gradient/mesh_gradient.dart';

import '../../../misc/color_theme.dart';

class AnimatedMoon extends StatelessWidget {
  const AnimatedMoon({super.key, this.isSmall = true});

  final bool isSmall;

  @override
  Widget build(BuildContext context) => Container(
    margin: const EdgeInsets.all(30),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(
        width: 4,
        color: ColorTheme.theme.primary.withOpacity(0.3),
        strokeAlign: BorderSide.strokeAlignOutside,
      ),
      boxShadow: [
        BoxShadow(
          color: ColorTheme.theme.primary,
          blurRadius: 16,
          spreadRadius: 4,
        ),
      ],
    ),
    clipBehavior: Clip.antiAlias,
    child: SizedBox.square(
      dimension: isSmall ? 400 : MediaQuery.sizeOf(context).height * 0.6,
      child: AnimatedMeshGradient(
        colors: [
          ColorTheme.theme.primary,
          ColorTheme.theme.secondaryVariant,
          ColorTheme.theme.secondary,
          ColorTheme.theme.primaryVariant,
        ],
        options: AnimatedMeshGradientOptions(frequency: 2, speed: 2),
        child: ColoredBox(color: ColorTheme.theme.background.withOpacity(0.1)),
      ),
    ),
  );

}