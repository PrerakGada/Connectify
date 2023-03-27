import 'package:flutter/material.dart';
import 'dart:math' as math;

class CircularProgressIndicatorWithPercentage extends StatefulWidget {
  final double percent;
  final double radius;

  CircularProgressIndicatorWithPercentage(
      {this.percent = 0.0, this.radius = 50.0});

  @override
  _CircularProgressIndicatorWithPercentageState createState() =>
      _CircularProgressIndicatorWithPercentageState();
}

class _CircularProgressIndicatorWithPercentageState
    extends State<CircularProgressIndicatorWithPercentage>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1200));
    _controller?.addListener(() {
      setState(() {});
    });
    _controller?.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      foregroundPainter: CircularProgressPainter(
        percent: widget.percent,
        strokeWidth: 3.0,
        color: Colors.grey[300],
        valueColor: ColorTween(begin: Colors.grey[300], end: Colors.black)
            .animate(
                CurvedAnimation(parent: _controller!, curve: Curves.linear)),
      ),
      child: Container(
        width: widget.radius * 2,
        height: widget.radius * 2,
        child: Center(
          child: Text(
            "${widget.percent.toInt()}%",
            style: TextStyle(
              fontSize: widget.radius / 2,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}

class CircularProgressPainter extends CustomPainter {
  double? percent;
  double? strokeWidth;
  Color? color;
  Animation<Color?> valueColor;

  CircularProgressPainter(
      {this.percent, this.strokeWidth, this.color, required this.valueColor});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color!
      ..strokeWidth = strokeWidth!
      ..style = PaintingStyle.stroke;

    double centerX = size.width / 2;
    double centerY = size.height / 2;
    double radius = math.min(centerX, centerY) - (strokeWidth! / 2);

    canvas.drawCircle(Offset(centerX, centerY), radius, paint);

    Paint progressPaint = Paint()
      ..shader = valueColor.value != null
          ? SweepGradient(
              colors: [Colors.transparent, valueColor.value!],
              stops: [0.0, 1.0],
              startAngle: math.pi * -0.5,
              endAngle: math.pi * 1.5,
              transform: GradientRotation(math.pi * -0.5),
            ).createShader(
              Rect.fromCircle(center: Offset(centerX, centerY), radius: radius))
          : null
      ..strokeWidth = strokeWidth!
      ..style = PaintingStyle.stroke;

    canvas.drawArc(
        Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
        math.pi * -0.5,
        math.pi * 2 * (percent! / 100),
        false,
        progressPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
