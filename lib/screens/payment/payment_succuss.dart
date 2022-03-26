import 'package:flutter/material.dart';
import '/screens/dashboard/dashboard.dart';
import '/widgets/bottom_nav_button.dart';

class PaymentSuccussfull extends StatelessWidget {
  const PaymentSuccussfull({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _canvas = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: _canvas.height * 0.1),
            Image.asset(
              'assets/images/Group 422.png',
              height: _canvas.height * 0.35,
              width: _canvas.height * 0.35,
              fit: BoxFit.contain,
            ),
            SizedBox(height: _canvas.height * 0.06),
            Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: _canvas.width * 0.12),
                const Icon(
                  Icons.check,
                  color: Color(0xff221DC5),
                  size: 30.0,
                ),
                const SizedBox(width: 10.0),
                Text(
                  'Profile Completed',
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: 22.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                SizedBox(width: _canvas.width * 0.12),
                const Icon(
                  Icons.check,
                  color: Color(0xff221DC5),
                  size: 30.0,
                ),
                const SizedBox(width: 10.0),
                Text(
                  'Ad Created',
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: 22.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // const SizedBox(width: 55.0),
                SizedBox(width: _canvas.width * 0.12),
                const Icon(
                  Icons.check,
                  color: Color(0xff221DC5),
                  size: 30.0,
                ),
                const SizedBox(width: 10.0),
                Text(
                  'Payment Successfull',
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: 22.0,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            SizedBox(height: _canvas.width * 0.2),
            Text(
              'Your Ad is under moderation\nAnd will be live soon',
              style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            BottomNavButton(
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const DashBoard(),
                ),
              ),
              label: 'GO TO MY DASHBOARD',
              isEnabled: true,
            ),
          ],
        ),
      ),
    );
  }
}
