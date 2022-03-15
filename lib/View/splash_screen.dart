import 'dart:async';

import 'package:covid_19/View/world_state.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: Duration(seconds: 3)
  )..repeat();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 5),
        () => Navigator.push(context, MaterialPageRoute(
          builder: (context) => WorldStateScreen()
        ))
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  
  final colorList = <Color> [
    Color(0xff4285F4),
    Color(0xff1aa260),
    Color(0xff4285F4),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children:   [
            AnimatedBuilder(
                animation: _controller,
                child: Container(
                  height: 200.0,
                  width: 200.0,
                  child: Center(
                    child: Image(
                      image: AssetImage('images/virus.png'),
                    ),
                  ),
                ),
                builder: (context,Widget? child){
                  return Transform.rotate(
                      angle: _controller.value * 2.0 * math.pi,
                  child: child,
                  );
                }
                ),
            SizedBox(height: MediaQuery.of(context).size.height * .08),
            Align(
              alignment: Alignment.center,
              child: Text('Covid-19\nTracker App',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,

                ),

              ),
            )

          ],
        ),
      ),
    );
  }
}
