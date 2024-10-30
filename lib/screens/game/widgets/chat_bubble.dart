import 'package:askinator/misc/color_theme.dart';
import 'package:askinator/misc/lottie_decoder.dart';
import 'package:askinator/screens/game/game_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

class ChatBubble extends StackedHookView<GameViewModel> {
  const ChatBubble({super.key, required this.isPointingUp});

  final bool isPointingUp;

  @override
  Widget builder(BuildContext context, GameViewModel viewModel) {
    if (!viewModel.busy(GameViewModel.lastMessageKey)) {
      if (viewModel.lastMessage.isEmpty) return const SizedBox();

      final tenPercentWidth = MediaQuery.sizeOf(context).width * 0.1;

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: tenPercentWidth),
        child: _buildBubble(
          isPointingUp: isPointingUp,
          child: Text(
            viewModel.lastMessage,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
          ),
        ),
      );
    }

    return _buildBubble(
      isPointingUp: isPointingUp,
      child: SizedBox(
        height: 50,
        width: 100,
        child: Lottie.asset(
          'assets/anims/loading.lottie',
          decoder: customDecoder,
        ),
      ),
    );
  }

  Widget _buildBubble({required Widget child, required bool isPointingUp}) => CustomPaint(
        painter: ChatBubblePainter(
          isPointingUp: isPointingUp,
          fillColor: ColorTheme.theme.background,
          strokeColor: ColorTheme.theme.primary,
        ),
        child: Container(
          padding: EdgeInsets.only(
            left: 36.0,
            right: 36,
            bottom: 24,
            top: isPointingUp ? 24 + 15 : 24 - 15,
          ),
          child: child,
        ),
      );
}

class ChatBubblePainter extends CustomPainter {
  final Color fillColor;
  final Color? strokeColor;
  final bool isPointingUp;

  ChatBubblePainter({
    required this.fillColor,
    required this.isPointingUp,
    this.strokeColor,
  }) {
    if (strokeColor == null) {
      _strokePaint = null;
      return;
    }

    _strokePaint = Paint()
      ..color = strokeColor!
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
  }

  static const _radius = 30.0;
  static double triangleHeight = -15.0;
  static const _triangleWideness = 15.0;

  late final _fillPaint = Paint()
    ..color = fillColor
    ..style = PaintingStyle.fill;

  late final Paint? _strokePaint;

  @override
  void paint(Canvas canvas, Size size) {
    triangleHeight = isPointingUp ? 15.0 : -15.0;

    final rect = RRect.fromLTRBAndCorners(
      0,
      triangleHeight,
      size.width,
      size.height,
      bottomRight: const Radius.circular(_radius),
      bottomLeft: const Radius.circular(_radius),
      topRight: const Radius.circular(_radius),
      topLeft: const Radius.circular(_radius),
    );

    final triangleBeginningX = size.width / 2 - _triangleWideness;
    final triangleEndX = size.width / 2 + _triangleWideness;

    final trianglePath = Path()
      ..moveTo(triangleBeginningX, isPointingUp ? triangleHeight : size.height)
      ..lineTo(size.width / 2, isPointingUp ? 0 : size.height - triangleHeight)
      ..lineTo(triangleEndX, isPointingUp ? triangleHeight : size.height);

    canvas.drawRRect(rect, _fillPaint);
    canvas.drawPath(trianglePath, _fillPaint);

    if (_strokePaint != null) {
      canvas.drawRRect(rect, _strokePaint);

      canvas.drawPath(
        Path()
          ..moveTo(triangleBeginningX, isPointingUp ? triangleHeight : size.height)
          ..lineTo(triangleEndX, isPointingUp ? triangleHeight : size.height),
        Paint()
          ..strokeWidth = 3
          ..color = fillColor
          ..style = PaintingStyle.stroke,
      );

      canvas.drawPath(trianglePath, _strokePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
