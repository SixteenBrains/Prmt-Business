import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/screens/registration/screens/registration_screen.dart';
import '/blocs/auth/auth_bloc.dart';
import '/screens/signup/signup_screen.dart';
import '/widgets/loading_indicator.dart';

class AuthWrapper extends StatelessWidget {
  static const String routeName = '/authwrapper';

  const AuthWrapper({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const AuthWrapper(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.unauthenticated) {
          Navigator.of(context).pushNamed(SignUpScreen.routeName);
        } else if (state.status == AuthStatus.authenticated) {
          print('Auth State user - ${state.user?.uid}');

          Navigator.of(context).pushNamed(RegistrationScreen.routeName);
        }
      },
      child: const Scaffold(
        body: LoadingIndicator(),
      ),
    );
  }
}
