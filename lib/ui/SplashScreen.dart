import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:petfind/theme/theme.dart' as Theme;
import 'package:petfind/ui/LoginScreen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 1700),
      vsync: this,
    );

    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController)
      ..addListener(() {
        setState(() {});
      });

    _animationController.forward();

    Future.delayed(Duration(seconds: 3)).then((a) {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    Theme.Settings.orientation;
    Theme.Settings.statusBar;

    return Scaffold(
      appBar: null,
      backgroundColor: Theme.ColorsTheme.primaryColor,
      body: SafeArea(
        minimum: EdgeInsets.only(top: 80),
          child: Container(
              decoration: BoxDecoration(gradient: Theme.ColorsTheme.gradient),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ScaleTransition(
                    scale: _animation,
                    child: Image.asset(
                      "assets/images/logo.png",
                      fit: BoxFit.fill,
                      width: 220,
                      height: 60,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: ScaleTransition(
                      scale: _animation,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          SpinKitThreeBounce(
                            color: Colors.white,
                            size: 45,
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ))),
    );
  }
}
