import 'package:flutter/material.dart';
import 'dart:math';

class Example8 extends StatelessWidget {
  const Example8({super.key});

  @override
  Widget build(BuildContext context) {
    return MyDrawer(
        drawer: Material(
          child: Container(
            color: Colors.blue,
            child: ListView.builder(
              padding: const EdgeInsets.only(left: 100, top: 100),
              itemCount: 20,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Item $index'),
                );
              },
            ),
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: const Text('3D Drawer'),
            backgroundColor: Colors.blue,
          ),
          body: const Center(
            child: Text('3D Drawer'),
          ),
        ));
  }
}

class MyDrawer extends StatefulWidget {
  final Widget drawer;
  final Widget child;
  const MyDrawer({
    super.key,
    required this.drawer,
    required this.child,
  });

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> with TickerProviderStateMixin {
  late AnimationController _xControllerForChild;
  late AnimationController _xControllerForDrawer;

  late Animation<double> _yAnimationForChild;
  late Animation<double> _yAnimationForDrawer;

  @override
  void initState() {
    super.initState();
    _xControllerForChild = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _xControllerForDrawer = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _yAnimationForChild = Tween<double>(
      begin: 0,
      end: -pi / 2,
    ).animate(_xControllerForChild);
    _yAnimationForDrawer = Tween<double>(
      begin: pi / 2.7,
      end: 0,
    ).animate(_xControllerForDrawer);
  }

  @override
  void dispose() {
    _xControllerForChild.dispose();
    _xControllerForDrawer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final maxDrag = screenWidth * 0.8;
    return GestureDetector(
      onHorizontalDragUpdate: (details){
        final delta = details.delta.dx / maxDrag;
        _xControllerForChild.value += delta;
        _xControllerForDrawer.value += delta;
      },
      onHorizontalDragEnd: (details){
        if (_xControllerForChild.value < 0.5) {
          _xControllerForChild.reverse();
          _xControllerForDrawer.reverse();
        } else {
          _xControllerForChild.forward();
          _xControllerForDrawer.forward();
        }
      },
      child: AnimatedBuilder(
        animation: Listenable.merge([
          _xControllerForChild,
          _xControllerForDrawer,
        ]),
        builder: (context, child) {
          return  Stack(
          children: [
            Container(
              color: const Color(0xFF1a1b26),
            ),
          Transform(
          alignment: Alignment.centerLeft,
          transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..translate(_xControllerForChild.value * maxDrag)
          ..rotateY(_yAnimationForChild.value),
          child: widget.child),
          Transform(
          alignment: Alignment.centerRight,
          transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..translate(-screenWidth +_xControllerForDrawer.value * maxDrag)
          ..rotateY(_yAnimationForDrawer.value),
          child: widget.drawer),
          ],
          );
        },

      ),
    );
  }
}
