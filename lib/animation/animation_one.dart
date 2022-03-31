// import 'dart:async';
// import 'package:flutter/material.dart';

// //https://stackoverflow.com/questions/52993217/how-can-i-make-a-show-up-text-animation-in-flutter
// class ShowUp extends StatefulWidget {
//   final Widget child;
//   final int delay;

//   const ShowUp({Key? key, required this.child, required this.delay})
//       : super(key: key);

//   @override
//   _ShowUpState createState() => _ShowUpState();
// }

// class _ShowUpState extends State<ShowUp> with TickerProviderStateMixin {
//   late AnimationController _animController;
//   late Animation<Offset> _animOffset;

//   @override
//   void initState() {
//     super.initState();

//     _animController = AnimationController(
//         vsync: this, duration: const Duration(milliseconds: 500));
//     final curve =
//         CurvedAnimation(curve: Curves.decelerate, parent: _animController);
//     _animOffset =
//         Tween<Offset>(begin: const Offset(0.0, 0.35), end: Offset.zero)
//             .animate(curve);

//     if (widget.delay == null) {
//       _animController.forward();
//     } else {
//       Timer(Duration(milliseconds: widget.delay), () {
//         _animController.forward();
//       });
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _animController.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return FadeTransition(
//       child: SlideTransition(
//         position: _animOffset,
//         child: widget.child,
//       ),
//       opacity: _animController,
//     );
//   }
// }
