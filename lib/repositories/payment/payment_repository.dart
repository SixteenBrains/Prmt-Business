import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '/models/payment_details.dart';
import '/.env_key.dart';
import '/config/paths.dart';
import '/models/failure.dart';
import '/models/save_card.dart';
import '/repositories/payment/base_payment_repo.dart';
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

  Future<void> addPaymentDetails({
    required String? userId,
    required PaymentDetails? details,
  }) async {
    try {
      if (userId == null || details == null) {
        return;
      }
      // await _firestore
      //     .collection(Paths.payments)
      //     .doc(userId)
      //     .set(details.toMap());

      await _firestore
          .collection(Paths.payments)
          .doc(userId)
          .collection(Paths.userPayments)
          .doc(details.adId)
          .set(details.toMap());
    } catch (error) {
      print('Error adding payment details ${error.toString()}');
    }
  }

  Future<List<PaymentDetails?>> getUserPaymentDetails(
      {required String? userId}) async {
    try {
      if (userId == null) {
        return [];
      }
      final paymentSnaps = await _firestore
          .collection(Paths.payments)
          .doc(userId)
          .collection(Paths.userPayments)
          .get();

      return paymentSnaps.docs
          .map((doc) => PaymentDetails.fromMap(doc.data()))
          .toList();
    } catch (error) {
      print('Error getting user payment details');
      throw const Failure(message: 'Error getting user payment details');
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

  Future<void> buyWithGooglePay(paymentResult) async {
    try {
      String apiBase = 'https://api.stripe.com/v1';
      String secretKey = stripeSecretKey;

      String paymentUrl = '$apiBase/payment_intents';

      int price = 1;

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
      print('Data response  --- $data');

      print(data.runtimeType);

      print('Client secrect --- ${data['client_secret']}');

      //  final response = await fetchPaymentIntentClientSecret();
      final clientSecret = data['clientSecret'];
      final token =
          paymentResult['paymentMethodData']['tokenizationData']['token'];

      print('Token -- $token');
      final tokenJson = Map.castFrom(json.decode(token));

      print('Token Json $tokenJson');

      print('Token id -- ${tokenJson['id']}');

      final params = PaymentMethodParams.cardFromToken(
        token: tokenJson['id'],
        setupFutureUsage: PaymentIntentsFutureUsage.OnSession,
      );

      print('Params -- $params');
      // Confirm Google pay payment method
      final paymentInent = await Stripe.instance.confirmPayment(
        clientSecret,
        params,
      );
      print('Payment Intent status -- ${paymentInent.status}');
      print('Payment Intent -- $paymentInent');
    } catch (error) {
      print('Google pay error from repo ${error.toString()}');
    }
  }
}
