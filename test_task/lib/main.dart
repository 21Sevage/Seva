import 'dart:math';

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Name Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Test Task'),
        ),
        body: const SafeArea(
          child: MyHomePage(),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState
    extends State<MyHomePage>
    with SingleTickerProviderStateMixin {

  int _r = 255;
  int _g = 0;
  int _b = 0;
  Color _color = const Color.fromRGBO(126, 207, 209, 1.0);

  late AnimationController _animationController;
  late final Animation<double> _animation;
  final int _degree = 360;

  bool _bo = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        vsync: this,
        value: 0.0,
        lowerBound: 0.0,
        upperBound: 1.0,
        duration: const Duration(seconds: 1)
    );
    _animation = Tween<double>(
        begin: 0.0,
        end: 1.0
    ).animate(
        CurvedAnimation(
            parent: _animationController,
            curve: Curves.linear
        )
    )..addListener(() {
      setState((){});
    });

  }

  @override
  void dispose() {
    super.dispose();

    _animationController.dispose();

  }

  void _f1() {
    setState(() {

      //Random generator of random value RGBO
      _r = Random().nextInt(256); // random 0 ... 255
      _g = Random().nextInt(256); // random 0 ... 255
      _b = Random().nextInt(256); // random 0 ... 255

      //16777216 color, counts like: 256 * 256 * 256 = 16777216
      _color = Color.fromRGBO(_r, _g, _b, 1.0);

      _bo = !_bo;

      if(_bo) {
        _animationController.forward();
      } else {
        _animationController.reverse(from: 1.0);
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () { _f1(); },
        child: Container(
          color: _color,
          alignment: Alignment.center,

          child: Transform(
            alignment: FractionalOffset.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.002)
              ..rotateX( ((_degree * pi) / 180) * (_animation.value) ),
            child: const Center(
              child: Text(
                'Hey there!',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 36.0
                ),
              ),
            ),
          ),

        )
    );
  }

}