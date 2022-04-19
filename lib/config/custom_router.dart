import 'package:flutter/material.dart';
import '/screens/ad-webview/ad_webview.dart';
import '/screens/payment/screens/card_payment.dart';
import '/screens/payment/screens/razorpay_payment.dart';
import '/screens/profile/edit_profile.dart';
import '/screens/profile/profile_screen.dart';
import '/screens/ad-details/ad_details.dart';
import '/screens/payment/payment_screen.dart';
import '/screens/payment/payment_succuss.dart';
import '/screens/dashboard/dashboard.dart';
import '/screens/preview-ad/preview_ad.dart';
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

      case PreviewAdScreen.routeName:
        return PreviewAdScreen.route(args: settings.arguments as PreviewAdArgs);

      case PaymentScreen.routeName:
        return PaymentScreen.route(
            args: settings.arguments as PaymentScreenArgs);

      case PaymentSuccussfull.routeName:
        return PaymentSuccussfull.route();

      case DashBoard.routeName:
        return DashBoard.route();

      case AdDetails.routeName:
        return AdDetails.route(args: settings.arguments as AdDetailsArgs);

      case ProfileScreen.routeName:
        return ProfileScreen.route();

      case EditProfile.routeName:
        return EditProfile.route();

      case CardPayment.routeName:
        return CardPayment.route(args: settings.arguments as CardPaymentArgs);

      case RazorpayPayment.routeName:
        return RazorpayPayment.route(
            args: settings.arguments as RazorpayPaymentArgs);

      case AdWebView.routeName:
        return AdWebView.route(args: settings.arguments as AdWebViewArgs);

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
