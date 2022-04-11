import 'package:flutter/material.dart';

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';

import 'package:prmt_business/.env_key.dart';

import 'package:stripe_checkout/stripe_checkout.dart';
import 'package:http/http.dart' as http;

class CheckoutTest extends StatefulWidget {
  const CheckoutTest({Key? key}) : super(key: key);

  @override
  State<CheckoutTest> createState() => _CheckoutTestState();
}

class _CheckoutTestState extends State<CheckoutTest> {
  final kApiUrl = defaultTargetPlatform == TargetPlatform.android
      ? 'http://10.0.2.2:4242'
      : 'http://localhost:4242';

  Future<void> getCheckout() async {
    final String sessionId = await _createCheckoutSession();
    final result = await redirectToCheckout(
      context: context,
      sessionId: sessionId,
      publishableKey: stripePublishableKey,
      successUrl: 'https://checkout.stripe.dev/success',
      canceledUrl: 'https://checkout.stripe.dev/cancel',
    );

    if (mounted) {
      final text = result.when(
        success: () => 'Paid succesfully',
        canceled: () => 'Checkout canceled',
        error: (e) => 'Error $e',
        redirected: () => 'Redirected succesfully',
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(text)),
      );
    }
  }

  Future createSessionId() async {
    try {
      String apiBase = 'https://api.stripe.com/v1';
      String secretKey = stripeSecretKey;

      String paymentUrl = '$apiBase/checkout/sessions';
      Map<String, dynamic> body = {
        'success_url': 'https://example.com/success',
        'cancel_url': 'https://example.com/cancel',
        'line_items[0][price]': '1',
        'line_items[0][quantity]': '1',

        // 'line_items':
        //     jsonEncode({'price': 'price_H5ggYwtDq4fbrJ', 'quantity': '1'}),
        'mode': 'payment',
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
      print('Checkout Data --- $data');
    } catch (error) {
      print('Checkout Error creating session id ${error.toString()}');
    }
  }

  Future<String> _createCheckoutSession() async {
    final url = Uri.parse('$kApiUrl/create-checkout-session');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        // if (kIsWeb) 'port': getUrlPort(),
        if (kIsWeb) 'port': 'web port',
      }),
    );
    final Map<String, dynamic> bodyResponse = json.decode(response.body);
    final id = bodyResponse['id'] as String;
    log('Checkout session id $id');
    return id;
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => createSessionId(),
      child: const Text('Checkout'),
    );
  }
}
