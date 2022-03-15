import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:prmt_business/widgets/bottom_nav_button.dart';

class CreateAccount extends StatelessWidget {
  const CreateAccount({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              'Awesome!',
              style: GoogleFonts.openSans(
                color: Colors.grey.shade800,
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              'Now tell us your Full Name',
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12.0),
            Text(
              'Enter your full name here.',
              style: TextStyle(
                color: Colors.grey.shade700,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              // onChanged: (value) =>
              //     context.read<SignUpCubit>().phoneNoChanged(value),
              decoration: InputDecoration(
                hintText: 'Eg - John Doe',
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue),
                ),
                hintStyle: TextStyle(
                  color: Colors.grey.shade400,
                  fontSize: 20.0,
                ),
              ),
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
