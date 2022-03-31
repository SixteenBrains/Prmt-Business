// import 'package:flutter/material.dart';

// class SplashSceen4 extends StatefulWidget {
//   const SplashSceen4({Key? key}) : super(key: key);

//   @override
//   State<SplashSceen4> createState() => _SplashSceen4State();
// }

// class _SplashSceen4State extends State<SplashSceen4> {
//   bool selected = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SizedBox(
//         width: 200,
//         height: 350,
//         child: Stack(
//           children: <Widget>[
//             AnimatedPositioned(
//               width: selected ? 200.0 : 50.0,
//               height: selected ? 50.0 : 200.0,
//               top: selected ? 50.0 : 150.0,
//               duration: const Duration(seconds: 2),
//               curve: Curves.fastOutSlowIn,
//               child: GestureDetector(
//                 onTap: () {
//                   setState(() {
//                     selected = !selected;
//                   });
//                 },
//                 child: Container(
//                   color: Colors.blue,
//                   child: const Center(child: Text('Tap me')),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
