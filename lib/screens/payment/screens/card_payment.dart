// main.dart
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:prmt_business/.env_key.dart';

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

class CardPayment extends StatefulWidget {
  static const String routeName = '/card';
  const CardPayment({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => const CardPayment(),
    );
  }

  @override
  State<CardPayment> createState() => _CardPaymentState();
}

class _CardPaymentState extends State<CardPayment> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  void payment() async {
    try {
      final paymentMethod = await Stripe.instance.createPaymentMethod(
        const PaymentMethodParams.card(billingDetails: BillingDetails()),
      );

      print('Payment method --- $paymentMethod');

      final result = await _makePayment(
          price: 1,
          paymentMethod: paymentMethod,
          billingDetails: paymentMethod.billingDetails);
      print('Resulta------- $result');

      print('Payment method $paymentMethod');
    } catch (error) {
      print('Error ${error.toString()}');
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

      // final paymentIntent = await StripePayment
      // .confirmPaymentIntent(
      //   PaymentIntent(
      //     clientSecret: data['client_secret'],
      //     paymentMethodId: paymentMethod.id,
      //   ),
      // );

      print('Payement Intent --------------- ${paymentIntent.status}');

      if (paymentIntent.status == PaymentIntentsStatus.Succeeded) {
        succuss = true;
      }
      return succuss;
    } catch (error) {
      print('Payment Error --- ${error.toString()}');
      // return false;
      return false;
    }
  }

  //final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            const SizedBox(height: 20.0),
            CreditCardWidget(
              cardNumber: cardNumber,
              expiryDate: expiryDate,
              cardHolderName: cardHolderName,
              cvvCode: cvvCode,
              showBackView: isCvvFocused,
              backgroundImage: 'assets/images/card_bg.png',
              obscureCardNumber: false,
              obscureCardCvv: false,
              isHolderNameVisible: false,
              height: 220,
              textStyle: const TextStyle(
                fontFamily: 'halter',
                fontSize: 16,
                color: Colors.white,
                package: 'flutter_credit_card',
              ),
              width: MediaQuery.of(context).size.width,
              isChipVisible: true,
              isSwipeGestureEnabled: true,
              animationDuration: const Duration(milliseconds: 1000),
              cardBgColor: Colors.black,
              onCreditCardWidgetChange: (value) {},
              customCardTypeIcons: [
                CustomCardTypeIcon(
                  cardType: CardType.mastercard,
                  cardImage: Image.asset(
                    'assets/images/mastercard.png',
                    height: 48,
                    width: 48,
                  ),
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15.0,
                vertical: 20.0,
              ),
              child: CardField(
                decoration: const InputDecoration(
                  disabledBorder: inputBorder,
                  enabledBorder: inputBorder,
                  focusedBorder: inputBorder,
                  contentPadding: EdgeInsets.fromLTRB(10, 20, 8, 12),
                ),
                dangerouslyGetFullCardDetails: true,
                onCardChanged: (card) {
                  print('Card $card');

                  print('Card number - ${card?.brand}');
                  setState(() {
                    cardNumber = card?.number ?? '';
                    cvvCode = card?.cvc ?? '';
                    expiryDate =
                        '${card?.expiryMonth ?? 'MM'} / ${card?.expiryYear ?? 'YY'}';
                  });
                },
              ),
            ),
            //  const SizedBox(height: 10.0),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: CheckboxListTile(
                title: const Text('Save card for future user'),
                value: true,
                onChanged: (value) {},
              ),
            ),
            const SizedBox(height: 30.0),
            SizedBox(
              height: 45.0,
              width: 120.0,
              child: ElevatedButton(
                onPressed: () => payment(),
                child: const Text(
                  'Pay ₹ 20',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
