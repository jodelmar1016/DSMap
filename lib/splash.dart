import 'package:flutter/material.dart';
import 'package:dsmap/router.dart';
import 'package:dsmap/screens/home.dart';
import 'package:dsmap/authentication/login.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(
      Duration(milliseconds: 1500),
      () {
        Navigator.pushReplacement(context, MyPageRouter(page: Login()));
      },
    );
  }

  // Route _createRoute() {
  //   return PageRouteBuilder(
  //     pageBuilder: (context, animation, secondaryAnimation) => Wrapper(),
  //     transitionDuration: Duration(milliseconds: 1000),
  //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
  //       const begin = Offset(0.1, 1.0);
  //       const end = Offset.zero;
  //       const curve = Curves.ease;

  //       var tween =
  //           Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

  //       return SlideTransition(
  //         position: animation.drive(tween),
  //         child: child,
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/logo.png',
              fit: BoxFit.fill,
              width: 300,
              color: Colors.green[700],
            ),
            // const Text(
            //   'DSMap',
            //   style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            // ),
          ],
        ),
      ),
    );
  }
}
