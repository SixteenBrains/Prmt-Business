import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '/screens/otp/otp_screen.dart';
import '/screens/signup/cubit/signup_cubit.dart';
import '/widgets/bottom_nav_button.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpCubit, SignUpState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state.status == SignUpStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
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
                    'Your Mobile Number',
                    style: GoogleFonts.openSans(
                      color: Colors.grey.shade800,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    'To start the app, we need your mobile number linked',
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Row(
                    children: [
                      const Text(
                        '+91',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Expanded(
                        child: TextField(
                          style: const TextStyle(fontSize: 20.0),
                          keyboardType: TextInputType.phone,
                          onChanged: (value) =>
                              context.read<SignUpCubit>().phoneNoChanged(value),
                          decoration: InputDecoration(
                            hintText: 'Eg - 1234567890',
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
                      ),
                    ],
                  ),
                  const Spacer(),
                  BottomNavButton(
                    onTap: () {
                      if (state.phNoIsEmpty) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const OtpScreen(),
                          ),
                        );
                      }
                    },
                    label: 'CONTINUE',
                    isEnabled: state.phNoIsEmpty,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
