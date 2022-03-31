// import 'dart:async';

// import 'package:flutter/material.dart';

// class SplashScreen2 extends StatefulWidget {
//   const SplashScreen2({Key? key}) : super(key: key);

//   @override
//   State<SplashScreen2> createState() => _SplashScreen2State();
// }

// class _SplashScreen2State extends State<SplashScreen2> {
//   late Timer _timer;
//   @override
//   void initState() {
//     super.initState();
//     _timer = Timer.periodic(const Duration(seconds: 1), (time) {
//       print('Time -- ${_timer.tick}');
//       print(_timer.tick);

//       if (_timer.tick == 2) {
//         setState(() {
//           animated = true;
//         });

//         //   _timer.cancel();
//       } else if (_timer.tick == 2) {
//         _timer.cancel();
//         // final routeName = SharedPrefs().isFirstTime
//         //     ? OnBoardingScreen.routeName
//         //     : AuthWrapper.routeName;

//         // Navigator.of(context).pushNamed(routeName);

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

//   @override
//   Widget build(BuildContext context) {
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
//           backgroundColor: Colors.transparent,
//           body: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   // 'PROMOTE',
//                   animated ? 'PRMT' : 'PROMOTE',
//                   style: const TextStyle(
//                     color: Colors.white,
//                     fontSize: 60.0,
//                     fontWeight: FontWeight.w600,
//                     letterSpacing: -7.0,
//                   ),
//                 ),
//                 Text(
//                   'YOUR BUSSINESS',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 28.0,
//                     letterSpacing: animated ? -0.0 : 8.0,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
