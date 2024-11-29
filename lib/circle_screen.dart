import 'package:flutter/material.dart';
enum CircleSide {left, right}
extension ToPath on CircleSide {
  Path toPath(Size size){
    final path = Path();

    late Offset offset;
    late bool clockWise;

    switch (this) {

      case CircleSide.left:
        path.moveTo(size.width, 0);
        offset = Offset(0, size.height);
        clockWise = false;
      case CircleSide.right:
        offset = Offset(0, size.height);
        clockWise = true;
    }
    path.arcToPoint(offset,
        radius: Radius.elliptical(size.width/2, size.height/2),
    clockwise: clockWise);

    path.close();
    return path;
  }
}

class HalfCircleClipper extends CustomClipper<Path>{
  final CircleSide side;
  const HalfCircleClipper({required this.side});
  @override
  Path getClip(Size size) => side.toPath(size);

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;

}

class CircleScreen extends StatelessWidget {
  const CircleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Container(
            height: 150,
            width: 150,
            color: const Color(0XFF0057b7),
          ),
          Container(
            height: 150,
            width: 150,
            color: const Color(0xfffffd70),
          ),
        ],
      ),
    );
  }
}
