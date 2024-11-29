import 'package:flutter/material.dart';
import 'dart:math' show pi;

enum CircleSide { left, right }

extension ToPath on CircleSide {
  Path toPath(Size size) {
    final path = Path();

    late Offset offset;
    late bool clockWise;

    switch (this) {
      case CircleSide.left:
        path.moveTo(size.width, 0);
        offset = Offset(size.width, size.height);
        clockWise = false;
      case CircleSide.right:
        offset = Offset(0, size.height);
        clockWise = true;
    }
    path.arcToPoint(offset,
        radius: Radius.elliptical(size.width / 2, size.height / 2),
        clockwise: clockWise);

    path.close();
    return path;
  }
}

class HalfCircleClipper extends CustomClipper<Path> {
  final CircleSide side;
  const HalfCircleClipper({required this.side});
  @override
  Path getClip(Size size) => side.toPath(size);

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}

extension on VoidCallback{
  Future<void> delayed(Duration duration) => Future.delayed(duration, this);
}

class Example2 extends StatefulWidget {
  const Example2({super.key});

  @override
  State<Example2> createState() => _Example2State();
}

class _Example2State extends State<Example2>
    with TickerProviderStateMixin {
  late AnimationController _counterClockWiseRotationController;
  late Animation<double> _counterClockWiseRotationAnimation;
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;

  @override
  void initState() {
    super.initState();
    _counterClockWiseRotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    _counterClockWiseRotationAnimation = Tween<double>(begin: 0, end: -(pi / 2.0))
        .animate(CurvedAnimation(
            parent: _counterClockWiseRotationController,
            curve: Curves.bounceOut));

    _flipAnimation = Tween<double>(begin: 0, end: pi)
        .animate(CurvedAnimation(
        parent: _flipController,
        curve: Curves.bounceOut));

    //status listeners
    _counterClockWiseRotationController.addStatusListener((status){
      if(status== AnimationStatus.completed){
        _flipAnimation = Tween<double>(
            begin: _flipAnimation.value,
            end: _flipAnimation.value + pi)
            .animate(CurvedAnimation(
            parent: _flipController,
            curve: Curves.bounceOut));

        // reset the flip controller and start the animation

        _flipController
          ..reset()
          ..forward();
      }
    });

    _flipController.addStatusListener(
          (status) {
        if (status == AnimationStatus.completed) {
          _counterClockWiseRotationAnimation = Tween<double>(
            begin: _counterClockWiseRotationAnimation.value,
            end: _counterClockWiseRotationAnimation.value + -(pi / 2.0),
          ).animate(
            CurvedAnimation(
              parent: _counterClockWiseRotationController,
              curve: Curves.bounceOut,
            ),
          );
          _counterClockWiseRotationController
            ..reset()
            ..forward();
        }
      },
    );

  }

  @override
  void dispose() {
    _counterClockWiseRotationController.dispose();
    _flipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      _counterClockWiseRotationController
        ..reset()
        ..forward.delayed(const Duration(seconds: 1));

    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
          animation: _counterClockWiseRotationController,
          builder: (context, child) {
            return Transform(
              transform: Matrix4.identity()
                ..rotateZ(_counterClockWiseRotationAnimation.value),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedBuilder(
                    animation: _flipController,
                    builder: (context, child) {
                      return Transform(
                        alignment: Alignment.centerRight,
                        transform: Matrix4.identity()..rotateY(_flipAnimation.value),
                        child: ClipPath(
                          clipper: const HalfCircleClipper(side: CircleSide.left),
                          child: Container(
                            height: 180,
                            width: 180,
                            color: const Color(0XFF0057b7),
                          ),
                        ),
                      );
                    },
                  ),
                  AnimatedBuilder(
                    animation: _flipController,
                    builder: (context, child) {
                      return Transform(
                        alignment: Alignment.centerLeft,
                        transform: Matrix4.identity()..rotateY(_flipAnimation.value),
                        child: ClipPath(
                        clipper: const HalfCircleClipper(side: CircleSide.right),
                        child: Container(
                        height: 180,
                        width: 180,
                        color: const Color(0xffffd700),
                        ),
                        ),
                      );
                    },

                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}



