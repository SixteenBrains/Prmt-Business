import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Prmt extends StatelessWidget {
  const Prmt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
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
                  'PRMT',
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
                    letterSpacing: 1.0,
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
