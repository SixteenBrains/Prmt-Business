import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/widgets/ask_to_action.dart';
import '/blocs/auth/auth_bloc.dart';
import '/widgets/bottom_nav_button.dart';

class CreateAccount extends StatelessWidget {
  static const String routeName = '/create-account';
  const CreateAccount({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const CreateAccount(),
    );
  }

  void _logout(BuildContext context) async {
    final result = await AskToAction.deleteAction(
        context: context, title: 'Logout', content: 'Do you want to logout ?');
    if (result) {
      // await SharedPrefs().setFirstTime(true);
      context.read<AuthBloc>().add(AuthLogoutRequested());
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
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
                  IconButton(
                    onPressed: () => _logout(context),
                    icon: const Icon(
                      Icons.logout,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
              // Align(
              //   alignment: Alignment.topLeft,
              //   child: GestureDetector(
              //     onTap: () => Navigator.of(context).pop(),
              //     child: const CircleAvatar(
              //       backgroundColor: Color(0xffF4F4F9),
              //       radius: 25.0,
              //       child: Icon(
              //         Icons.arrow_back,
              //         color: Color(0xff999999),
              //       ),
              //     ),
              //   ),
              // ),
              const SizedBox(height: 20.0),
              Text(
                'Awesome!',
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4.0),
              Text(
                'Now tell us your Full Name',
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 20.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12.0),
              Text(
                'Enter your full name here.',
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                style: const TextStyle(fontSize: 20.0),
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
                // onTap: () => Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (_) => const AddEmail(),
                //   ),
                // ),
                label: 'CONTINUE',
                isEnabled: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
