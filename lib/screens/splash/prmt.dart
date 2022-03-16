// import 'dart:async';

// import 'package:animated_text_kit/animated_text_kit.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import '/screens/onboarding/onboarding_screen.dart';

// class Prmt extends StatefulWidget {
//   const Prmt({Key? key}) : super(key: key);

//   @override
//   State<Prmt> createState() => _PrmtState();
// }

// class _PrmtState extends State<Prmt> {
//   late Timer _timer;
//   @override
//   void initState() {
//     super.initState();
//     _timer = Timer.periodic(const Duration(seconds: 1), (time) {
//       print('Time -- ${_timer.tick}');
//       print(_timer.tick);
//       if (_timer.tick == 5) {
//         Navigator.of(context, rootNavigator: true).push(
//           CupertinoPageRoute<bool>(
//             //fullscreenDialog: true,
//             builder: (BuildContext context) => const OnBoardingScreen(),
//           ),
//         );

//         _timer.cancel();
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _timer.cancel();
//     print('Dispose is called');
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         return false;
//       },
//       child: Scaffold(
//         body: Container(
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//               colors: [
//                 Color(0xff4243E6),
//                 Color(0xff1A1091),
//               ],
//               begin: Alignment.topLeft,
//               end: Alignment.bottomRight,
//             ),
//             color: Colors.purple,
//           ),
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 AnimatedTextKit(
//                   animatedTexts: [
//                     ScaleAnimatedText(
//                       'PRMT',
//                       textStyle: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 68.0,
//                         fontWeight: FontWeight.w700,
//                         letterSpacing: -8.0,
//                       ),
//                       duration: const Duration(seconds: 10),
//                       scalingFactor: 0.2,
//                     ),
//                   ],
//                   totalRepeatCount: 0,
//                   isRepeatingAnimation: false,
//                   repeatForever: false,
//                 ),
//                 AnimatedTextKit(
//                   animatedTexts: [
//                     ScaleAnimatedText(
//                       'YOUR BUSINESS',
//                       textStyle: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 28.0,
//                         letterSpacing: 1.0,
//                       ),
//                       duration: const Duration(seconds: 10),
//                       scalingFactor: 0.2,
//                     ),
//                   ],
//                   totalRepeatCount: 0,
//                   repeatForever: false,
//                   isRepeatingAnimation: false,
//                 ),
//                 // Text(
//                 //   'PRMT',
//                 //   style: GoogleFonts.openSans(
//                 //     color: Colors.white,
//                 //     fontSize: 68.0,
//                 //     fontWeight: FontWeight.w700,
//                 //     letterSpacing: -8.0,
//                 //   ),
//                 // ),
//                 // Text(
//                 //   'YOUR BUSINESS',
//                 //   style: GoogleFonts.openSans(
//                 //     color: Colors.white,
//                 //     fontSize: 28.0,
//                 //     letterSpacing: 1.0,
//                 //   ),
//                 // )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
