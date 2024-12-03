import 'package:animations/example2.dart';
import 'package:animations/example1.dart';
import 'package:animations/example3.dart';
import 'package:animations/example4.dart';
import 'package:animations/example5.dart';
import 'package:animations/example6.dart';
import 'package:animations/example7.dart';
import 'package:animations/example8.dart';
import 'package:animations/example9.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Animations',
          ),
          centerTitle: true,
          backgroundColor: Colors.blue,
        ),
        body: const SingleChildScrollView(
          child:  Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomContainer(
                  screen: Example1(),
                  color: Colors.blueAccent,
                  text: 'Square',
                ),
                SizedBox(height: 20),
                CustomContainer(
                  screen: Example2(),
                  color: Colors.greenAccent,
                  text: 'Circle',
                ),
                SizedBox(height: 20),
                CustomContainer(
                  screen: Example3(),
                  color: Colors.teal,
                  text: '3D Box',
                ),
                SizedBox(height: 20),
                CustomContainer(
                  screen: Example4(),
                  color: Colors.amber,
                  text: 'Hero Animation',
                ),
                SizedBox(height: 20),
                CustomContainer(
                  screen: Example5(),
                  color: Colors.cyanAccent,
                  text: 'Implicit Animation',
                ),
                SizedBox(height: 20),
                CustomContainer(
                  screen: Example6(),
                  color: Colors.deepPurpleAccent,
                  text: 'Tween Animation',
                ),
                SizedBox(height: 20),
                CustomContainer(
                  screen: Example7(),
                  color: Colors.deepOrange,
                  text: 'Custom Polygon',
                ),
                SizedBox(height: 20),
                CustomContainer(
                  screen: Example8(),
                  color: Colors.pink,
                  text: '3D Drawer',
                ),
                SizedBox(height: 20),
                CustomContainer(
                  screen: Example9(),
                  color: Colors.cyan,
                  text: 'Animated Icon',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  final Widget screen;
  final Color color;
  final String text;
  const CustomContainer({
    super.key,
    required this.screen,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => screen),
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(color: Colors.white, fontSize: 18),
          ),
        ),
      ),
    );
  }
}
