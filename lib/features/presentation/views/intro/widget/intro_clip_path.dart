import 'package:flutter/cupertino.dart';

class IntroCurveClipper extends CustomClipper<Path> {
  final double height;

  IntroCurveClipper({this.height = 50});

  @override
  Path getClip(Size size) {
    Offset controlPoint = Offset(size.width / 2, size.height + height);
    Offset endPoint = Offset(size.width, size.height - height);

    Path path = Path()
      ..lineTo(0, size.height - height)
      ..quadraticBezierTo(controlPoint.dx, controlPoint.dy, endPoint.dx, endPoint.dy)
      ..lineTo(size.width, 0)
      ..close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}