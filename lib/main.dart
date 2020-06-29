import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController animationController;

  void mylistener(status) {
    if (status == AnimationStatus.completed) {
      animation.removeStatusListener(mylistener);
      animationController.reset();
      animation = Tween(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(parent: animationController, curve: Curves.bounceIn))
        ..addStatusListener((status) {
          mylistener(status);
        });
      animationController.forward();
    }
  }

  @override
  void initState() {
    super.initState();

    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 10));
    //animation = Tween<double>(begin: 30.0,end:100.0).animate(animationController);
    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
        parent: animationController, curve: Curves.fastLinearToSlowEaseIn))
      ..addStatusListener(mylistener);
    animationController.forward(); //.. is a cascade notation
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) => Transform(
          transform:
              Matrix4.translationValues(animation.value * width, 0.0, 0.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.height * 0.1,
                  color: Colors.amber,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.height * 0.1,
                  color: Colors.red,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.height * 0.1,
                  color: Colors.green,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.height * 0.1,
                  color: Colors.black,
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  width: MediaQuery.of(context).size.height * 0.1,
                  color: Colors.pink,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
