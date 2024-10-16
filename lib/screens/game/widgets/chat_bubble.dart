import 'package:askinator/misc/color_theme.dart';
import 'package:askinator/misc/lottie_decoder.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ChatBubble extends StatefulWidget {
  const ChatBubble({super.key});

  @override
  State<StatefulWidget> createState() => ChatBubbleState();

}

class ChatBubbleState extends State<ChatBubble> with TickerProviderStateMixin {

  late final _chatBubbleAnimationController = AnimationController(vsync: this);
  bool _isLoadingAnswer = false;

  @override
  void dispose() {
    _chatBubbleAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ChatBubblePainter(
        fillColor: ColorTheme.theme.background,
        strokeColor: ColorTheme.theme.primary,
      ),
      child: Container(
        padding: const EdgeInsets.only(left: 36.0, right: 36, bottom: 24, top: 24 + ChatBubblePainter.triangleHeight),
        height: 100,
        width: 200,
        child: _isLoadingAnswer
            ? Lottie.asset(
          'assets/loading.lottie',
          decoder: customDecoder,
          onLoaded: (composition) {
            _chatBubbleAnimationController.duration = composition.duration;
          },
        )
            : Center(
              child: Text(
                        'Yes !',
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Colors.white),
                      ),
            ),
      ),
    );
  }

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
  static const triangleHeight = 15.0;
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
      ..moveTo(triangleBeginningX, triangleHeight)
      ..lineTo(size.width / 2, 0)
      ..lineTo(triangleEndX, triangleHeight);

    canvas.drawRRect(rect, _fillPaint);
    canvas.drawPath(trianglePath, _fillPaint);

    if (_strokePaint != null) {
      canvas.drawRRect(rect, _strokePaint);

      canvas.drawPath(
        Path()
          ..moveTo(triangleBeginningX, triangleHeight)
          ..lineTo(triangleEndX, triangleHeight),
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
