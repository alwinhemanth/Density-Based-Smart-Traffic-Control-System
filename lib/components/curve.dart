import 'package:flutter/material.dart';




import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Color kDarkGreenColor = const Color(0xFF184A2C);
Color kGinColor = const Color(0xFFE5F0EA);
Color kSpiritedGreen = const Color(0xFFC1DFCB);
Color kFoamColor = const Color(0xFFEBFDF2);
Color kGreyColor = Colors.grey.shade600;

TextStyle kBillTextStyle = GoogleFonts.poppins(
  color: kDarkGreenColor,
  fontSize: 15.0,
);

class ImageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0, size.height * 0.30);

    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.36,
      size.width * 0.70,
      size.height * 0.30,
    );
    path.lineTo(size.width, size.height * 0.25);

    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = kSpiritedGreen;
    paint.style = PaintingStyle.fill;

    var path = Path();

    path.moveTo(0, size.height * 0.70);

    path.quadraticBezierTo(
      size.width * 0.40,
      size.height * 0.80,
      size.width * 0.75,
      size.height * 0.60,
    );
    path.quadraticBezierTo(
      size.width * 0.95,
      size.height * 0.48,
      size.width,
      size.height * 0.32,
    );

    path.lineTo(size.width, 20);
    path.quadraticBezierTo(size.width, 0, size.width - 20, 0);
    path.lineTo(20, 0);
    path.quadraticBezierTo(0, 0, 0, 20);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CurvePainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(CurvePainter oldDelegate) => false;
}

