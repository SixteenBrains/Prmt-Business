import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import '/screens/payment/payment_succuss.dart';
import '/widgets/error_dialog.dart';
import '/widgets/show_snackbar.dart';
import '/blocs/auth/auth_bloc.dart';
import '/repositories/ad/ad_repository.dart';
import '/repositories/payment/payment_repository.dart';
import '/widgets/loading_indicator.dart';
import '/.env_key.dart';
import '/models/ad_model.dart';
import '/screens/payment/cubit/payment_cubit.dart';

import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayPaymentArgs {
  final AdModel? ad;

  RazorpayPaymentArgs({required this.ad});
}

class RazorpayPayment extends StatefulWidget {
  static const String routeName = '/razorpayPayment';
  const RazorpayPayment({Key? key, required this.ad}) : super(key: key);

  final AdModel? ad;

  static Route route({required RazorpayPaymentArgs args}) {
    return MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (context) => PaymentCubit(
          paymentRepository: context.read<PaymentRepository>(),
          ad: args.ad,
          adRepository: context.read<AdRepository>(),
          authBloc: context.read<AuthBloc>(),
        ),
        child: RazorpayPayment(ad: args.ad),
      ),
    );
  }

  @override
  _RazorpayPaymentState createState() => _RazorpayPaymentState();
}

class _RazorpayPaymentState extends State<RazorpayPayment> {
  //static const platform = MethodChannel('razorpay_flutter');

  late Razorpay _razorpay;

  @override
  void initState() {
    super.initState();
    // openCheckout();
    _razorpay = Razorpay();
    openCheckout();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    final _authBloc = context.read<AuthBloc>();
    if (widget.ad?.budget != null) {
      var options = {
        'key': razorpayKeyId,
        'amount': int.tryParse('${widget.ad!.budget!}00'),
        'name': widget.ad?.title ?? 'N/A',
        'description': widget.ad?.description ?? 'N/A',
        'retry': {'enabled': true, 'max_count': 1},
        'send_sms_hash': true,
        'prefill': {
          'contact': _authBloc.state.user?.phoneNumber ?? 'N/A',
          'email': _authBloc.state.user?.email ?? 'N/A'
        },
        'external': {
          'wallets': ['paytm']
        }
        // 'key': razorpayKeyId,
        // 'amount': 100,
        // 'name': 'Acme Corp.',
        // 'description': 'Fine T-Shirt',
        // 'retry': {'enabled': true, 'max_count': 1},
        // 'send_sms_hash': true,
        // 'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
        // 'external': {
        //   'wallets': ['paytm']
        // }
      };

      try {
        _razorpay.open(options);
      } catch (e) {
        debugPrint('Error: e');
      }
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Success Response: ${response.paymentId}');

    if (response.paymentId != null) {
      context.read<PaymentCubit>().publishAd(ad: widget.ad);
    }
    /*Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Error Response: ${response.message}');
    /* Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        toastLength: Toast.LENGTH_SHORT); */
    context.read<PaymentCubit>().throwPaymentError(response.message);
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External SDK Response: ${response.walletName}');
    /* Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentState>(
      listener: (context, state) {
        if (state.status == PaymentStatus.error) {
          showDialog(
            context: context,
            builder: (context) => ErrorDialog(
              content: state.failure.message,
            ),
          );
        }
        if (state.status == PaymentStatus.paymentSuccuss) {
          ShowSnackBar.showSnackBar(context, title: 'Payment Succussfull');
        }

        if (state.status == PaymentStatus.succuss) {
          Navigator.of(context).pushNamed(PaymentSuccussfull.routeName);
        }
      },
      builder: (context, state) {
        if (state.status == PaymentStatus.loading) {
          return const Scaffold(body: LoadingIndicator());
        }
        return Scaffold(
          body: Center(
            child: ElevatedButton(
              child: const Text('Retry Payment'),
              onPressed: openCheckout,
            ),
          ),
        );
      },
    );
  }
}
