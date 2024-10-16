import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class Askinator extends StatefulWidget {
  const Askinator({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  State<StatefulWidget> createState() => AskinatorState();
}

class AskinatorState extends State<Askinator> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: const RiveAnimation.asset(
        'assets/bat.riv',
        animations: ['idle'],
      ),
    );
  }
}
