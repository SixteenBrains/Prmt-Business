import 'package:flutter/material.dart';
import '/screens/create-ad/preview_ad.dart';
import '/screens/create-ad/screens/create_ad_sceen.dart';
import '/screens/onboarding/onboarding_screen.dart';
import '/screens/registration/screens/registration_screen.dart';
import '/screens/signup/otp_screen.dart';
import '/screens/signup/signup_screen.dart';
import '/screens/splash/splash_screen.dart';
import 'auth_wrapper.dart';

class CustomRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    print('Route: ${settings.name}');
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            settings: const RouteSettings(name: '/'),
            builder: (_) => const Scaffold());

      case SplashScreen.routeName:
        return SplashScreen.route();

      case OnBoardingScreen.routeName:
        return OnBoardingScreen.route();

      case AuthWrapper.routeName:
        return AuthWrapper.route();

      case SignUpScreen.routeName:
        return SignUpScreen.route();

      // case ProfileCompleted.routeName:
      //   return ProfileCompleted.route();

      case OtpScreen.routeName:
        return OtpScreen.route(args: settings.arguments as OtpScreenArgs);

      case RegistrationScreen.routeName:
        return RegistrationScreen.route();

      case CreateAdScreen.routeName:
        return CreateAdScreen.route();

      case PreviewAd.routeName:
        return PreviewAd.route();

      default:
        return _errorRoute();
    }
  }

  static Route onGenerateNestedRouter(RouteSettings settings) {
    print('NestedRoute: ${settings.name}');
    switch (settings.name) {
      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
        appBar: AppBar(
          title: const Text(
            'Error',
          ),
        ),
        body: const Center(
          child: Text(
            'Something went wrong',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
