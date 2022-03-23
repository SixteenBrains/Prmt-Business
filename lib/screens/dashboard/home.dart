import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Image.asset(
        'assets/images/bg_blue.png',
        width: double.infinity,
        fit: BoxFit.cover,
        height: 200.0,
      ),
    )

        // Container(
        //   height: 190.0,
        //   width: 450,
        //   decoration: const BoxDecoration(
        //     image: DecorationImage(
        //       fit: BoxFit.cover,
        //       image: AssetImage(
        //         'assets/images/bg_blue.png',
        //       ),
        //     ),
        //   ),
        // ),

        // Stack(
        //   fit: StackFit.expand,
        //   children: [
        //     Container(
        //       //  height: 190.0,
        //       width: double.infinity,
        //       decoration: BoxDecoration(
        //         image: DecorationImage(
        //           image: AssetImage(
        //             'assets/images/bg_blue.png',
        //           ),
        //         ),
        //       ),
        //     ),
        //     // Image.asset(
        //     //   'assets/images/bg_blue.png',
        //     //   fit: BoxFit.cover,
        //     // ),
        //   ],
        // ),
        );
  }
}
