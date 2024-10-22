import 'package:flutter/material.dart';

class ResponsiveLayoutBuilder extends StatelessWidget {
  const ResponsiveLayoutBuilder({
    super.key,
    required this.smallScreenBuilder,
    this.largeScreenBuilder,
  });

  final Widget Function(BuildContext) smallScreenBuilder;
  final Widget Function(BuildContext)? largeScreenBuilder;

  static double thresholdWidth = 700;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.sizeOf(context).width;

    if (deviceWidth > thresholdWidth && largeScreenBuilder != null) {
      return largeScreenBuilder!(context);
    }

    return smallScreenBuilder(context);
  }
}
