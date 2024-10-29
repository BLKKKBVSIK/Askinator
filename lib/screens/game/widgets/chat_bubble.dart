import 'package:askinator/misc/color_theme.dart';
import 'package:askinator/misc/lottie_decoder.dart';
import 'package:askinator/screens/game/game_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key, required this.gameViewModel});

  final GameViewModel gameViewModel;

  @override
  Widget build(BuildContext context) {
    if (!gameViewModel.busy(GameViewModel.lastMessageKey)) {
      if (gameViewModel.lastMessage.isEmpty) return const SizedBox();

      final tenPercentWidth = MediaQuery.sizeOf(context).width * 0.1;

      return Padding(
        padding: EdgeInsets.symmetric(horizontal: tenPercentWidth),
        child: _buildBubble(
          child: Text(
            gameViewModel.lastMessage,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
          ),
        ),
      );
    }

    return _buildBubble(
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

  Widget _buildBubble({required Widget child}) => CustomPaint(
        painter: ChatBubblePainter(
          fillColor: ColorTheme.theme.background,
          strokeColor: ColorTheme.theme.primary,
        ),
        child: Container(
          padding: const EdgeInsets.only(
            left: 36.0,
            right: 36,
            bottom: 24,
            top: 24 + ChatBubblePainter.triangleHeight,
          ),
          child: child,
        ),
      );
}

class ChatBubblePainter extends CustomPainter {
  final Color fillColor;
  final Color? strokeColor;

  ChatBubblePainter({
    required this.fillColor,
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
  static const triangleHeight = -15.0;
  static const _triangleWideness = 15.0;

  late final _fillPaint = Paint()
    ..color = fillColor
    ..style = PaintingStyle.fill;

  late final Paint? _strokePaint;

  @override
  void paint(Canvas canvas, Size size) {
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
      ..moveTo(triangleBeginningX, size.height)
      ..lineTo(size.width / 2, size.height - triangleHeight)
      ..lineTo(triangleEndX, size.height);

    canvas.drawRRect(rect, _fillPaint);
    canvas.drawPath(trianglePath, _fillPaint);

    if (_strokePaint != null) {
      canvas.drawRRect(rect, _strokePaint);

      canvas.drawPath(
        Path()
          ..moveTo(triangleBeginningX, size.height)
          ..lineTo(triangleEndX, size.height),
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
