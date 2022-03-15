import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prmt_business/screens/splash/prmt.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (time) {
      print('Time -- ${_timer.tick}');
      print(_timer.tick);
      if (_timer.tick == 2) {
        Navigator.of(context, rootNavigator: true).push(
          CupertinoPageRoute<bool>(
            //fullscreenDialog: true,
            builder: (BuildContext context) => const Prmt(),
          ),
        );

        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    print('Dispose is called');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Navigator.of(context, rootNavigator: true).push(
        //       CupertinoPageRoute<bool>(
        //         //fullscreenDialog: true,
        //         builder: (BuildContext context) => const Prmt(),
        //       ),
        //     );
        //   },
        // ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff4243E6),
                Color(0xff1A1091),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            color: Colors.purple,
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'PROMOTE',
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 68.0,
                    fontWeight: FontWeight.w700,
                    letterSpacing: -8.0,
                  ),
                ),
                Text(
                  'YOUR BUSINESS',
                  style: GoogleFonts.openSans(
                    color: Colors.white,
                    fontSize: 28.0,
                    letterSpacing: 5.7,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
