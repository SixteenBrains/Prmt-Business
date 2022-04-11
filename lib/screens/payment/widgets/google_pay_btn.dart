import 'package:flutter/material.dart';
import 'package:pay/pay.dart' as pay;
import 'package:flutter_bloc/flutter_bloc.dart';
import '/screens/payment/cubit/payment_cubit.dart';

class GooglePayBtn extends StatelessWidget {
  final List<pay.PaymentItem> paymentItems;
  const GooglePayBtn({Key? key, required this.paymentItems}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20.0,
        //  vertical: 10.0,
      ),
      child: pay.GooglePayButton(
        type: pay.GooglePayButtonType.buy,
        style: pay.GooglePayButtonStyle.white,
        paymentConfigurationAsset: 'google_pay_payment_profile.json',
        paymentItems: paymentItems,
        margin: const EdgeInsets.only(top: 15),
        // onPaymentResult: onGooglePayResult,
        onPaymentResult: context.read<PaymentCubit>().buyWithGooglePay,
        loadingIndicator: const Center(
          child: CircularProgressIndicator(),
        ),
        onPressed: () async {
          // 1. Add your stripe publishable key to assets/google_pay_payment_profile.json
          //await debugChangedStripePublishableKey();
        },
        childOnError: const Text('Google Pay is not available in this device'),
        onError: (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  'There was an error while trying to perform the payment'),
            ),
          );
        },
      ),
    );
  }
}
