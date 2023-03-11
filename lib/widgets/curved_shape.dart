import 'package:connectify/theme/app_colors.dart';
import 'package:flutter/material.dart';

const curveHeight = 160.0;
const anotherHeight = curveHeight + 120;

class CurvedShape extends StatelessWidget {
  const CurvedShape({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: curveHeight,
      child: CustomPaint(
        painter: _MyPainter(
          backgroundColor: AppColors.secondary,
        ),
      ),
    );
  }
}

class _MyPainter extends CustomPainter {
  final Color backgroundColor;
  _MyPainter({required this.backgroundColor});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.fill
      ..isAntiAlias = true
      ..color = backgroundColor;

    Offset circleCenter = Offset(size.width / 2, size.height + anotherHeight);

    Offset topLeft = const Offset(0, 0);
    Offset bottomLeft = Offset(0, size.height * 1.5);
    Offset topRight = Offset(size.width, 0);
    Offset bottomRight = Offset(size.width, size.height * 1.4);

    Offset rightCurveControlPoint =
        Offset(circleCenter.dx * 1.1, size.height + anotherHeight);

    Path path = Path()
      ..moveTo(topLeft.dx,
          topLeft.dy) // this move isn't required since the start point is (0,0)
      ..lineTo(bottomLeft.dx, bottomLeft.dy)
      ..quadraticBezierTo(rightCurveControlPoint.dx, rightCurveControlPoint.dy,
          bottomRight.dx, bottomRight.dy)
      ..lineTo(topRight.dx, topRight.dy)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
