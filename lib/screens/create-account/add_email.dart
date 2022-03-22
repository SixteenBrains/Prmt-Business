import 'package:flutter/material.dart';
import '/screens/create-account/add_business_name.dart';
import '/widgets/bottom_nav_button.dart';

class AddEmail extends StatelessWidget {
  const AddEmail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              'Your Email ID',
              style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12.0),
            Text(
              'Enter your email address to get your\nupdates on your email.',
              style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 16.0,
              ),
            ),
            const SizedBox(height: 20.0),
            TextField(
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(fontSize: 20.0),
              // onChanged: (value) =>
              //     context.read<SignUpCubit>().phoneNoChanged(value),
              decoration: InputDecoration(
                hintText: 'Eg - abc@gmail.com',
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
              onTap: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const AddBusinessName(),
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
