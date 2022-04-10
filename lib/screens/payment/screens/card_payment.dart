// main.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import '/models/ad_model.dart';
import '/screens/payment/payment_succuss.dart';
import '/widgets/error_dialog.dart';
import '/widgets/show_snackbar.dart';
import '/widgets/loading_indicator.dart';
import '/.env_key.dart';
import '/blocs/auth/auth_bloc.dart';
import '/repositories/ad/ad_repository.dart';
import '/repositories/payment/payment_repository.dart';
import '/screens/payment/cubit/payment_cubit.dart';

// payment_screen.dart

const inputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(
    Radius.circular(8.0),
  ),
  borderSide: BorderSide(
    color: Colors.blue,
    width: 1.8,
  ),
);

class CardPaymentArgs {
  final AdModel? adModel;

  CardPaymentArgs({required this.adModel});
}

class CardPayment extends StatefulWidget {
  static const String routeName = '/card';
  const CardPayment({
    Key? key,
    required this.adModel,
  }) : super(key: key);

  final AdModel? adModel;

  static Route route({required CardPaymentArgs args}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => BlocProvider(
        create: (context) => PaymentCubit(
          ad: args.adModel,
          adRepository: context.read<AdRepository>(),
          paymentRepository: context.read<PaymentRepository>(),
          authBloc: context.read<AuthBloc>(),
        ),
        child: CardPayment(adModel: args.adModel),
      ),
    );
  }

  @override
  State<CardPayment> createState() => _CardPaymentState();
}

class _CardPaymentState extends State<CardPayment> {
  void payment() async {
    try {
      context.read<PaymentCubit>().updatePayment(status: PaymentStatus.loading);

      // const billingDetails = BillingDetails(
      //   email: 'rishukumar.prince@gmail.com',
      //   phone: '+918540928489',
      //   address: Address(
      //     city: 'Bhopal',
      //     country: 'IN',
      //     line1: 'Patel Nagar',
      //     line2: '',
      //     state: 'Madhya Pradesh',
      //     postalCode: '462022',
      //   ),
      // );

      // final paymentMethod = await Stripe.instance
      //     .createPaymentMethod(PaymentMethodParams.fromJson(jsonCard));

      final paymentMethod = await Stripe.instance.createPaymentMethod(
        // const PaymentMethodParams.card(billingDetails: billingDetails),
        const PaymentMethodParams.card(),
      );

      print('Payment method --- $paymentMethod');

      final result = await _makePayment(
          price: 1,
          paymentMethod: paymentMethod,
          billingDetails: paymentMethod.billingDetails);
      print('Resulta------- $result');
      if (result) {
        context
            .read<PaymentCubit>()
            .updatePayment(status: PaymentStatus.paymentSuccuss);
        context.read<PaymentCubit>().publishAd(ad: widget.adModel);
      }

      print('Payment method $paymentMethod');
    } on StripeException catch (error) {
      print('Error 0 ${error.toString()}');
      // _controller.clear();
      context.read<PaymentCubit>().throwPaymentError(error.error.message);
    } catch (error) {
      print('Error 1 ${error.toString()}');
      // _controller.clear();
      context.read<PaymentCubit>().throwPaymentError(error.toString());
    }
  }

  Future<bool> _makePayment({
    required double? price,
    required PaymentMethod paymentMethod,
    required BillingDetails billingDetails,
  }) async {
    bool succuss = false;

    try {
      String apiBase = 'https://api.stripe.com/v1';
      String secretKey = stripeSecretKey;

      String paymentUrl = '$apiBase/payment_intents';

      Map<String, dynamic> body = {
        'amount': '${price?.round()}00',
        'currency': 'INR',
        'payment_method_types[]': 'card'
      };
      Map<String, String> headers = {
        'Authorization': 'Bearer $secretKey',
        'Content-Type': 'application/x-www-form-urlencoded',
      };

      final response = await http.post(
        Uri.parse(
          paymentUrl,
        ),
        body: body,
        headers: headers,
      );
      final data = jsonDecode(response.body);
      print('Data --- $data');

      print(data.runtimeType);

      print('Client secrect --- ${data['client_secret']}');

      final paymentParams = PaymentMethodParams.card(
        billingDetails: billingDetails,
        // setupFutureUsage:
        //     _saveCard == true ? PaymentIntentsFutureUsage.OffSession : null,
      );

      final paymentIntent = await Stripe.instance
          .confirmPayment(data['client_secret'], paymentParams);

      print('Payement Intent --------------- ${paymentIntent.status}');

      if (paymentIntent.status == PaymentIntentsStatus.Succeeded) {
        succuss = true;
      }
      return succuss;
    } on StripeException catch (error) {
      print('Payment Error from strip exception --- ${error.toString()}');
      context
          .read<PaymentCubit>()
          .throwPaymentError(error.error.localizedMessage);
      //_controller.clear();
      return false;
    } catch (error) {
      print('Payment Error 2 --- ${error.toString()}');
      // _controller.clear();
      context.read<PaymentCubit>().throwPaymentError(error.toString());

      return false;
    }
  }

  //final _controller = CardFormEditController();

  // @override
  // void initState() {
  //   _controller.addListener(update);
  //   super.initState();
  // }

  CardFieldInputDetails? _card;

  Map<String, dynamic> jsonCard = {
    'type': 'Visa',
    'card': {
      'number': '4242424242424242',
      'exp_month': '12',
      'exp_year': '34',
      'cvc': '123',
    },
  };

  // void update() => setState(() {});
  // @override
  // void dispose() {
  //   _controller.removeListener(update);
  //   _controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentCubit, PaymentState>(
      listener: (context, state) {
        if (state.status == PaymentStatus.error) {
          print('Status payment -- ${state.status}');
          showDialog(
            context: context,
            builder: (context) {
              return ErrorDialog(content: state.failure.message);
            },
          );
        }
        if (state.status == PaymentStatus.paymentSuccuss) {
          ShowSnackBar.showSnackBar(context, title: 'Payment succussfull');
        }
        if (state.status == PaymentStatus.succuss) {
          Navigator.of(context).pushNamed(PaymentSuccussfull.routeName);
        }
      },
      builder: (context, state) {
        if (state.status == PaymentStatus.loading) {
          return const Scaffold(body: LoadingIndicator());
        }
        return WillPopScope(
          onWillPop: () async => true,
          // state.status == PaymentStatus.loading ? false : true,
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              elevation: 0.0,
              backgroundColor: Colors.white,
              iconTheme: const IconThemeData(color: Colors.black),
              title: const Text(
                'Card Payment',
                style: TextStyle(color: Colors.black),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 50.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: CardField(
                      // dangerouslyGetFullCardDetails: true,
                      // dangerouslyUpdateFullCardDetails: true,
                      onCardChanged: (card) {
                        setState(() {
                          _card = card;
                        });
                      },
                    ),
                    // CardFormField(
                    //   enablePostalCode: false,
                    //   backgroundColor: Colors.black,
                    //   controller: _controller,
                    // ),
                  ),
                  const SizedBox(height: 20.0),
                  SizedBox(
                    height: 45.0,
                    width: 120.0,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (widget.adModel?.budget != null) {
                          payment();
                          print('details -- $_card');
                          if (_card?.complete == true) {
                            print('Details completed');
                            payment();
                            // final paymentMethod =
                            //     await Stripe.instance.createPaymentMethod(
                            //   const PaymentMethodParams.card(
                            //       billingDetails: BillingDetails()),
                            // );
                            // context.read<PaymentCubit>().cardPayment(
                            //     price: double.parse(widget.adModel!.budget!),
                            //     paymentMethod: paymentMethod);
                          } else {
                            print('Details incompleted');
                            ShowSnackBar.showSnackBar(context,
                                title: 'Card details incomplete');
                          }
                        }
                      },

                      //=> payment(),
                      child: Text(
                        'Pay ₹ ${widget.adModel?.budget ?? 'N/A'}',
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
