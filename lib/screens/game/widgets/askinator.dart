import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class Askinator extends StatefulWidget {
  const Askinator({super.key});

  @override
  State<StatefulWidget> createState() => AskinatorState();
}

class AskinatorState extends State<Askinator> {
  @override
  Widget build(BuildContext context) {

    return SizedBox(
      width: 300,
      height: MediaQuery.sizeOf(context).height * 0.5,
      child: const RiveAnimation.asset(
        'assets/bat.riv',
        animations: ['idle'],
        fit: BoxFit.cover,
      ),
    );
  }
}
