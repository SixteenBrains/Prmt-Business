// import 'dart:async';

// import 'package:flutter/material.dart';
// import '/config/auth_wrapper.dart';
// import '/config/shared_prefs.dart';
// import '/screens/onboarding/onboarding_screen.dart';

// class SplashScreen3 extends StatefulWidget {
//   const SplashScreen3({Key? key}) : super(key: key);

//   @override
//   State<SplashScreen3> createState() => _SplashScreen3State();
// }

// class _SplashScreen3State extends State<SplashScreen3> {
//   late Timer _timer;
//   @override
//   void initState() {
//     super.initState();
//     _timer = Timer.periodic(const Duration(seconds: 1), (time) {
//       print('Time -- ${_timer.tick}');
//       print(_timer.tick);

//       setState(() {
//         selected = true;
//       });

//       if (_timer.tick == 2) {
//         setState(() {
//           animated = true;
//         });

//         //   _timer.cancel();
//       } else if (_timer.tick == 5) {
//         _timer.cancel();
//         final routeName = SharedPrefs().isFirstTime
//             ? OnBoardingScreen.routeName
//             : AuthWrapper.routeName;

//         Navigator.of(context).pushNamed(routeName);

//         // Navigator.of(context, rootNavigator: true).push(
//         //   CupertinoPageRoute<bool>(
//         //     //fullscreenDialog: true,
//         //     builder: (BuildContext context) => const OnBoardingScreen(),
//         //   ),
//         // );
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     print('Dispose is called');
//     super.dispose();
//   }

//   bool animated = false;
//   bool selected = false;

//   @override
//   Widget build(BuildContext context) {
//     print('Moving --- ${_timer.tick < 5}');
//     return WillPopScope(
//       onWillPop: () async => false,
//       child: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color(0xff4243E6),
//               Color(0xff1A1091),
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//           color: Colors.purple,
//         ),
//         child: Scaffold(
//           // floatingActionButton: FloatingActionButton(onPressed: () {
//           //   setState(() {
//           //     selected = !selected;
//           //   });
//           // }),
//           backgroundColor: Colors.transparent,
//           body: Stack(
//             children: [
//               Center(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(
//                       // 'PROM   TE',
//                       animated ? 'PRMT' : 'PROM   TE',
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 60.0,
//                         fontWeight: FontWeight.w600,
//                         letterSpacing: -7.0,
//                       ),
//                     ),
//                     Text(
//                       'YOUR BUSSINESS',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 28.0,
//                         letterSpacing: animated ? -0.0 : 8.0,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               if (!animated)
//                 AnimatedPositioned(
//                   top: selected ? -50 : 350.0,
//                   //top: animated ? -50 : 350.0,
//                   right: 130.0,
//                   duration: const Duration(milliseconds: 800),
//                   curve: Curves.easeInOutBack,
//                   child: const Text(
//                     'O',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 60.0,
//                       fontWeight: FontWeight.w600,
//                       letterSpacing: -7.0,
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
