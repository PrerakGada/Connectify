import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double progress;

  ProgressBar({this.progress = 0});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: ProgressBarPainter(progress),
      child: Container(
        height: 10.0,
      ),
    );
  }
}

class ProgressBarPainter extends CustomPainter {
  final double progress;

  ProgressBarPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    Paint trackPaint = Paint()
      ..color = Colors.grey
      ..style = PaintingStyle.fill;

    Paint progressPaint = Paint()
      ..color = Colors.green
      ..style = PaintingStyle.fill;

    Paint markerPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    double width = size.width;
    double height = size.height;

    // Draw track
    canvas.drawRect(Rect.fromLTWH(0, 0, width, height), trackPaint);

    // Draw progress
    double progressWidth = width * progress;
    canvas.drawRect(Rect.fromLTWH(0, 0, progressWidth, height), progressPaint);

    // Draw marker for 70%
    double markerWidth70 = width * 0.7;
    canvas.drawRect(Rect.fromLTWH(markerWidth70, 0, 2, height), markerPaint);

    // Draw label for 70%
    TextSpan span70 = new TextSpan(
      style: new TextStyle(
        color: Colors.white,
        fontSize: 15.0,
      ),
      text: "70%",
    );

    TextPainter tp70 = new TextPainter(
      text: span70,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );

    tp70.layout();

    double textWidth70 = tp70.width;

    Offset textOffset70 = Offset(markerWidth70 - textWidth70 / 2, height + 4.0);

    tp70.paint(canvas, textOffset70);

    // Draw label for 0%
    TextSpan span0 = new TextSpan(
      style: new TextStyle(
        color: Colors.white,
        fontSize: 14.0,
      ),
      text: "0%",
    );

    TextPainter tp0 = new TextPainter(
      text: span0,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );

    tp0.layout();

    double textWidth0 = tp0.width;

    Offset textOffset0 = Offset(0, height + 4.0);

    tp0.paint(canvas, textOffset0);

    // Draw label for 100%
    TextSpan span100 = new TextSpan(
      style: new TextStyle(
        color: Colors.white,
        fontSize: 14.0,
      ),
      text: "100%",
    );

    TextPainter tp100 = new TextPainter(
      text: span100,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
    );

    tp100.layout();

    double textWidth100 = tp100.width;

    Offset textOffset100 = Offset(width - textWidth100, height + 4.0);

    tp100.paint(canvas, textOffset100);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
