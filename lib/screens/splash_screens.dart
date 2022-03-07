// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:grey_wall/tab_view.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     Timer(Duration(seconds: 3), () {
//       Navigator.of(context).pushReplacement(
//           MaterialPageRoute(builder: (context) => TabContainerBottom()));
//     });
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final width = MediaQuery.of(context).size.width;
//     final height = MediaQuery.of(context).size.height;
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child:Image.asset('assets/images/splash_screen.png',
//           fit: BoxFit.fill,
//           width: width,
//           height: height,
//           ),
//       ),
//     );
//   }

// }

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:grey_wall/screens/home_screen.dart';
import 'package:grey_wall/tab_view.dart';
import 'package:page_transition/page_transition.dart';

class Splsh extends StatelessWidget {
  const Splsh({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: "assets/images/splash_screen.png",
      nextScreen: TabContainerBottom(),
      duration: 2500,
      splashIconSize: double.infinity,
      backgroundColor:Color(0xff212121) ,
      // splashTransition: SplashTransition.rotationTransition,
      pageTransitionType: PageTransitionType.fade,
    );
  }
}
