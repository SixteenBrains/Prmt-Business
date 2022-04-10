import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:prmt_business/.env_key.dart';
import 'package:prmt_business/config/paths.dart';
import 'package:prmt_business/models/failure.dart';
import 'package:prmt_business/models/save_card.dart';
import 'package:prmt_business/repositories/payment/base_payment_repo.dart';
import 'package:http/http.dart' as http;

class PaymentRepository extends BasePaymentRepository {
  final FirebaseFirestore _firestore;

  PaymentRepository({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> saveCard({
    required String? userId,
    required SaveCard? card,
  }) async {
    try {
      if (userId != null && card != null) {
        await _firestore
            .collection(Paths.users)
            .doc(userId)
            .collection(Paths.savedCards)
            .add(card.toMap());
      }
    } catch (error) {
      print('Save card error ${error.toString()}');
      throw const Failure(message: 'Error in saving card');
    }
  }

  Future<bool?> cardPayment(
      {required double price, required PaymentMethod paymentMethod}) async {
    try {
      bool succuss = false;

      String apiBase = 'https://api.stripe.com/v1';
      String secretKey = stripeSecretKey;

      String paymentUrl = '$apiBase/payment_intents';

      Map<String, dynamic> body = {
        'amount': '${price.round()}00',
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
        billingDetails: paymentMethod.billingDetails,
        // setupFutureUsage:
        //     _saveCard == true ? PaymentIntentsFutureUsage.OffSession : null,
      );

      print('Payment params $paymentParams');

      final paymentIntent = await Stripe.instance
          .confirmPayment(data['client_secret'], paymentParams);

      print('Payement Intent --------------- ${paymentIntent.status}');

      if (paymentIntent.status == PaymentIntentsStatus.Succeeded) {
        succuss = true;
      } else if (paymentIntent.status == PaymentIntentsStatus.Canceled) {
        return false;
      }
      print('succuss -- $succuss');
      return succuss;
    } on StripeException catch (error) {
      print('Error in card payment ${error.error.localizedMessage}');

      throw Failure(
          message: error.error.localizedMessage ?? 'Something went d');
      // return false;
    } catch (error) {
      print('Error in card payment ${error.toString()}');
      throw const Failure(message: 'Something went wrong');

      //  return false;
    }
  }
}
