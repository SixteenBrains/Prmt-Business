import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '/screens/create-account/create_account.dart';
import '/widgets/bottom_nav_button.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String _code = '';
  bool _resendCode = false;
  int _countDown = 30;

  late Timer _timer;

  @override
  void initState() {
    startTimer();

    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_countDown == 0) {
          setState(() {
            timer.cancel();
            _resendCode = true;
          });
        } else {
          setState(() {
            _countDown--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // final timeLeft = 30 - _timer.tick;
    print('Sms code $_code');
    print(_resendCode);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
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
            if (!_resendCode)
              Row(
                children: [
                  const Icon(Icons.timer, color: Colors.blue),
                  const SizedBox(width: 7.0),
                  Text(
                    'Resend OTP in ${_countDown}s',
                    style: const TextStyle(
                      color: Color(0xff666666),
                      fontSize: 16.0,
                    ),
                  )
                ],
              ),
            if (_resendCode)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Didn\'t Receive OTP?',
                    style: TextStyle(
                      color: Colors.black,
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
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text(
                          'Change Number',
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 15.0,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            const Spacer(),
            BottomNavButton(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const CreateAccount(),
                ),
              ),
              label: 'CONTINUE',
              isEnabled: true,
            ),
          ],
        ),
      ),
    );
  }
}
