import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prmt_business/widgets/bottom_nav_button.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String _code = '';
  bool _resendCode = false;

  late Timer _timer;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 30), (timer) {
      if (timer.tick == 5) {
        setState(() {
          _resendCode = true;
        });
        _timer.cancel();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('Sms code $_code');
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 25.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 25.0),
            Align(
              alignment: Alignment.topLeft,
              child: GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: const CircleAvatar(
                  backgroundColor: Color(0xffF4F4F9),
                  radius: 25.0,
                  child: Icon(
                    Icons.arrow_back,
                    color: Color(0xff999999),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20.0),
            Text(
              'We have sent you\nan OTP',
              style: GoogleFonts.openSans(
                color: Colors.grey.shade800,
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12.0),
            Text(
              'Enter the 4 digit OTP sent on 7506079111 to proceed',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 20.0),
            PinFieldAutoFill(
              codeLength: 4,
              decoration: UnderlineDecoration(
                textStyle: const TextStyle(fontSize: 20, color: Colors.black),
                colorBuilder: PinListenColorBuilder(
                  Colors.blue,
                  Colors.grey.shade400,
                ),
                lineHeight: 1.5,
              ),
              currentCode: _code,
              onCodeSubmitted: (code) {},
              onCodeChanged: (code) {
                if (code!.length == 4) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  _code = code;
                }
              },
            ),
            const SizedBox(height: 22.0),
            // Row(
            //   children: const [
            //     Icon(Icons.timer, color: Colors.blue),
            //     SizedBox(width: 7.0),
            //     Text(
            //       'Resend OTP in 30s',
            //       style: TextStyle(
            //         color: Color(0xff666666),
            //         fontSize: 16.0,
            //       ),
            //     )
            //   ],
            // ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Didn\'t Receive OTP?',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 15.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.refresh,
                          color: Colors.blue,
                        ),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            'Resend OTP',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 15.0,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      ],
                    ),
                    const Text(
                      'Change Number',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                )
              ],
            ),
            const Spacer(),
            BottomNavButton(
              onTap: () {},
              label: 'CONTINUE',
              isEnabled: false,
            ),
          ],
        ),
      ),
    );
  }
}
