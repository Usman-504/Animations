import 'package:flutter/material.dart';
import 'dart:math' as math;

class Example6 extends StatefulWidget {
  const Example6({super.key});

  @override
  State<Example6> createState() => _Example6State();
}
Color getRandomColor() =>
    Color(0xFF000000 + math.Random().nextInt(0x00FFFFFF));
class _Example6State extends State<Example6> {

  var _color = getRandomColor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TweenAnimationBuilder(
          tween: ColorTween(
            begin: getRandomColor(),
            end: _color,
          ),
          onEnd: (){
            setState(() {
              _color = getRandomColor();
            });
      },
          duration: const Duration(seconds: 1),
          builder: (context, Color? color, child) {
            return ColorFiltered(
              colorFilter: ColorFilter.mode(color!, BlendMode.srcATop),
              child: Container(
                height: MediaQuery.of(context).size.width,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle, color: Colors.red),
              ),
            );
          },
        ),
      ),
    );
  }
}
