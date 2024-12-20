import 'package:askinator/misc/color_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesh_gradient/mesh_gradient.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({super.key, required this.onPressed, this.label = 'Start a game !', this.fontSize = 30});

  final VoidCallback onPressed;
  final String label;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
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
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(side: const BorderSide(color: Colors.white, width: 1.5)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8),
            child: Text(
              label,
              style: GoogleFonts.shadowsIntoLight().copyWith(
                color: Colors.white,
                fontSize: fontSize,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
