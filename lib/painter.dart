import 'package:flutter/material.dart';

// https://drive.google.com/file/d/1hPj3u4eZINMO9i9sEGNIS-jeA4LzD0na/view?usp=drive_link
// class BorderPainter extends CustomPainter {
//   final double controller;
//   final Color borderColor;

//   BorderPainter(this.controller, {required this.borderColor});

//   @override
//   void paint(Canvas canvas, Size size) {
//     double _sh = size.height;
//     double _sw = size.width;
//     double _line = 150;
//     double _c1 = controller * 2;
//     double _c2 = controller >= 0.5 ? (controller - 0.5) * 2 : 0;

//     Paint paint = Paint()
//       ..color = borderColor
//       ..strokeWidth = 4
//       ..style = PaintingStyle.stroke;

//     Path _top = Path()
//       ..moveTo(_sw * _c1 > _sw ? _sw : _sw * _c1, 0)
//       ..lineTo(_sw * _c1 + _line >= _sw ? _sw : _sw * _c1 + _line, 0);

//     Path _left = Path()
//       ..moveTo(0, _sh * _c1 > _sh ? _sh : _sh * _c1)
//       ..lineTo(0, _sh * _c1 + _line >= 0 ? _sh : _sh * _c1 + _line);

//     Path _right = Path()
//       ..moveTo(_sw, _sh * _c2)
//       ..lineTo(
//         _sw,
//         _sh * _c2 + _line > _sh
//             ? _sh
//             : _sw * _c1 + _line >= _sw
//                 ? _sw * _c1 + _line - _sw
//                 : _sh * _c2,
//       );

//     Path _bottom = Path()
//       ..moveTo(_sw * _c2, _sh)
//       ..lineTo(
//         _sw * _c2 + _line > _sw
//             ? _sw
//             : _sh * _c1 + _line >= _sh
//                 ? _sh * _c1 + _line - _sh
//                 : _sw * _c2,
//         _sh,
//       );

//     canvas.drawPath(_top, paint);
//     canvas.drawPath(_left, paint);
//     canvas.drawPath(_right, paint);
//     canvas.drawPath(_bottom, paint);
//   }

//   @override
//   bool shouldRepaint(BorderPainter oldDelegate) => true;

//   @override
//   bool shouldRebuildSemantics(BorderPainter oldDelegate) => false;
// }

// class LinePainter extends CustomPainter {
//   final Color borderColor;
//   final double animationValue; // Value from 0.0 to 1.0

//   LinePainter({required this.borderColor, required this.animationValue});

//   @override
//   void paint(Canvas canvas, Size size) {
//     var paint = Paint()
//       ..color = borderColor
//       ..strokeWidth = 2.0
//       ..style = PaintingStyle.fill;

//     // Draw the vertical line
//     canvas.drawLine(Offset(size.width / 2, 0), Offset(size.width / 2, size.height * animationValue), paint);

//     // Draw the circle at the top
//     canvas.drawCircle(Offset(size.width / 2, 0), 8.0, paint);

//     // Draw the circle at the bottom only if animation is complete
//     print("=========${animationValue <= 0.8}");
//     if (animationValue >= 0.88) {
//       canvas.drawCircle(Offset(size.width / 2, size.height), 8, paint);
//     }
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return true;
//   }
// }

// New

class LinePainter extends CustomPainter {
  final Color borderColor;
  final double animationValue;

  LinePainter({required this.borderColor, required this.animationValue});

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = borderColor
      ..strokeWidth = 2.0
      ..style = PaintingStyle.fill;

    canvas.drawLine(Offset(size.width / 2, 0),
        Offset(size.width / 2, size.height * animationValue), paint);
    canvas.drawCircle(Offset(size.width / 2, 0), 8.0, paint);
    if (animationValue >= 0.88) {
      canvas.drawCircle(Offset(size.width / 2, size.height), 8, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class BoxPainter extends CustomPainter {
  final double animation;
  final Color borderColor;

  BoxPainter({required this.animation, required this.borderColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    paint.color = borderColor;
    var leftSidePath = Path();
    leftSidePath.lineTo((size.width * animation), 0);
    leftSidePath.lineTo((size.width * animation), size.height);
    leftSidePath.lineTo(0, size.height);
    leftSidePath.lineTo(0, 0);
    leftSidePath.lineTo(0, size.height);
    canvas.drawPath(leftSidePath, paint);

    // paint.color = Colors.black;
    // var rightSidePath = Path();
    // rightSidePath.moveTo(size.width / 2, 0);
    // rightSidePath.lineTo(size.width, 0);
    // rightSidePath.lineTo(size.width, size.height);
    // rightSidePath.lineTo(size.width / 2, size.height);
    // canvas.drawPath(rightSidePath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}