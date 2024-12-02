import 'package:flutter/material.dart';

class Example5 extends StatefulWidget {
  const Example5({super.key});

  @override
  State<Example5> createState() => _Example5State();
}

class _Example5State extends State<Example5> {
  var _zoomIn = false;
  var _text = 'Zoom In';
  var _width = 100.0;
  var _curve = Curves.bounceOut;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text('Implicit Animation'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              curve: _curve,
              width: _width,
                duration: const Duration(milliseconds: 370),
            child:  Image.asset('assets/images/Carousel2.jpg'),
            ),
            TextButton(onPressed: (){
              _zoomIn = !_zoomIn;
              _text = _zoomIn ? 'Zoom Out' : 'Zoom In';
              _width = _zoomIn ? MediaQuery.of(context).size.width : 100.0;

              setState(() {
                _curve = _zoomIn ? Curves.bounceInOut : Curves.bounceOut;
              });
            }, child: Text(_text)),


          ],
        ),
      ),
    );
  }
}
