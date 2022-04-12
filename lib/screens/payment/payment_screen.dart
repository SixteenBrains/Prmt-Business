import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/screens/payment/widgets/google_pay_btn.dart';
import '/repositories/payment/payment_repository.dart';
import '/screens/payment/screens/card_payment.dart';
import '/widgets/loading_indicator.dart';
import '/blocs/auth/auth_bloc.dart';
import '/repositories/ad/ad_repository.dart';
import '/screens/payment/cubit/payment_cubit.dart';
import '/models/ad_model.dart';
import '/widgets/bottom_nav_button.dart';

import 'widgets/add_icon.dart';

import 'package:pay/pay.dart' as pay;

class PaymentScreenArgs {
  final AdModel? ad;

  PaymentScreenArgs({required this.ad});
}

class PaymentScreen extends StatelessWidget {
  static const String routeName = '/payment';

  final AdModel? ad;
  const PaymentScreen({
    Key? key,
    required this.ad,
  }) : super(key: key);

  static Route route({required PaymentScreenArgs args}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (_) => BlocProvider(
        create: (context) => PaymentCubit(
          ad: args.ad,
          adRepository: context.read<AdRepository>(),
          authBloc: context.read<AuthBloc>(),
          paymentRepository: context.read<PaymentRepository>(),
        ),
        child: PaymentScreen(ad: args.ad),
      ),
    );
  }

  // Future<void> onGooglePayResult(
  //   paymentResult,
  // ) async {
  //   String apiBase = 'https://api.stripe.com/v1';
  //   String secretKey = stripeSecretKey;

  //   String paymentUrl = '$apiBase/payment_intents';

  //   int price = 1;

  //   Map<String, dynamic> body = {
  //     'amount': '${price.round()}00',
  //     'currency': 'INR',
  //     'payment_method_types[]': 'card'
  //   };
  //   Map<String, String> headers = {
  //     'Authorization': 'Bearer $secretKey',
  //     'Content-Type': 'application/x-www-form-urlencoded',
  //   };

  //   final response = await http.post(
  //     Uri.parse(
  //       paymentUrl,
  //     ),
  //     body: body,
  //     headers: headers,
  //   );
  //   final data = jsonDecode(response.body);
  //   print('Data --- $data');

  //   print(data.runtimeType);

  //   print('Client secrect --- ${data['client_secret']}');

  //   //  final response = await fetchPaymentIntentClientSecret();
  //   final clientSecret = data['clientSecret'];
  //   final token =
  //       paymentResult['paymentMethodData']['tokenizationData']['token'];
  //   final tokenJson = Map.castFrom(json.decode(token));

  //   final params = stripe.PaymentMethodParams.cardFromToken(
  //     token: tokenJson['id'],
  //   );
  //   // Confirm Google pay payment method
  //   final paymentInent = await stripe.Stripe.instance.confirmPayment(
  //     clientSecret,
  //     params,
  //   );
  //   print('Payment Intent status -- ${paymentInent.status}');
  //   print('Payment Intent -- $paymentInent');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey.shade600),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
        ),
        title: const Text('Payment'),
      ),
      body: BlocConsumer<PaymentCubit, PaymentState>(
        listener: (context, state) {
          // if (state.status == PaymentStatus.succuss) {
          //   Navigator.of(context).pushNamed(PaymentSuccussfull.routeName);
          // }
        },
        builder: (context, state) {
          if (state.status == PaymentStatus.loading) {
            return const LoadingIndicator();
          }
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 140.0,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color(0XFF2588E7),
                        Color(0XFF134474),
                      ],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Total Payment',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                        ),
                      ),
                      Text(
                        '₹ ${ad?.budget ?? 'N/A'}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 38.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20.0),

                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 20.0,
                      ),
                      child: Text(
                        'Credit/Debit Cards',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Card(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () => Navigator.of(context)
                                      .pushNamed(CardPayment.routeName),
                                  child: const AddIcon(),
                                ),
                                const SizedBox(width: 15.0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Add New Card',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    Text(
                                      'Save and pay via card',
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 8.0),
                                    SizedBox(
                                      width: 140.0,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Icon(
                                            FontAwesomeIcons.ccVisa,
                                            color: Colors.grey.shade500,
                                            size: 27.0,
                                          ),
                                          Icon(
                                            FontAwesomeIcons.ccMastercard,
                                            color: Colors.grey.shade500,
                                            size: 27.0,
                                          ),
                                          Icon(
                                            FontAwesomeIcons.ccAmex,
                                            color: Colors.grey.shade500,
                                            size: 27.0,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // const Padding(
                    //   padding: EdgeInsets.symmetric(
                    //     horizontal: 20.0,
                    //     vertical: 20.0,
                    //   ),
                    //   child: Text(
                    //     'Saved Cards',
                    //     style: TextStyle(
                    //       fontSize: 20.0,
                    //       fontWeight: FontWeight.w600,
                    //     ),
                    //   ),
                    // ),
                    // const SavedCard(),
                    // SavedCard(),

                    const Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 20.0,
                      ),
                      child: Text(
                        'UPI',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10.0),
                    // ElevatedButton(
                    //   onPressed: () => Navigator.of(context).push(
                    //     MaterialPageRoute(
                    //       builder: (_) => const RazorpayPayment(),
                    //     ),
                    //   ),
                    //   child: const Text('Razorpay'),
                    // ),

                    GooglePayBtn(
                      paymentItems: [
                        pay.PaymentItem(
                          label: 'Total',
                          amount: ad?.budget ?? '',
                          status: pay.PaymentItemStatus.final_price,
                        ),
                      ],
                    ),
                    // Card(
                    //   margin: EdgeInsets.zero,
                    //   shape: const RoundedRectangleBorder(
                    //       borderRadius: BorderRadius.zero),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.stretch,
                    //     children: [
                    //       const Divider(),
                    //       Padding(
                    //         padding: const EdgeInsets.symmetric(
                    //           horizontal: 20.0,
                    //           vertical: 10.0,
                    //         ),
                    //         child: Row(
                    //           crossAxisAlignment: CrossAxisAlignment.start,
                    //           children: [
                    //             const AddIcon(),
                    //             const SizedBox(width: 15.0),
                    //             Column(
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //                 const Text(
                    //                   'Add New Card',
                    //                   style: TextStyle(
                    //                     fontSize: 16.0,
                    //                     fontWeight: FontWeight.w600,
                    //                   ),
                    //                 ),
                    //                 const SizedBox(height: 8.0),
                    //                 Text(
                    //                   'Save and pay via card',
                    //                   style: TextStyle(
                    //                     color: Colors.grey.shade600,
                    //                     fontSize: 15.0,
                    //                     fontWeight: FontWeight.w600,
                    //                   ),
                    //                 ),
                    //               ],
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 20.0,
                        horizontal: 20.0,
                      ),
                      child: Text(
                        'Wallets',
                        style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.zero,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15.0,
                              vertical: 15.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      'assets/images/amazon-pay.svg',
                                      height: 25.0,
                                      width: 25.0,
                                    ),
                                    const SizedBox(width: 10.0),
                                    const Text(
                                      'Amazon Pay',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    )
                                  ],
                                ),
                                const Text(
                                  'Link Account',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 15.0,
                              vertical: 15.0,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/phone-pe.png',
                                      height: 32.0,
                                      width: 32.0,
                                      fit: BoxFit.cover,
                                    ),
                                    const SizedBox(width: 10.0),
                                    const Text(
                                      'Phone Pay',
                                      style: TextStyle(
                                        fontSize: 16.0,
                                      ),
                                    )
                                  ],
                                ),
                                const Text(
                                  'Link Account',
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 15.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 20.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: BottomNavButton(
                    onTap: () async {
                      Navigator.of(context).pushNamed(CardPayment.routeName,
                          arguments: CardPaymentArgs(ad: ad));
                      // context
                      //     .read<AdRepository>()
                      //     .publishAd(ad: ad, userId: ad?.author?.uid);

                      //  context.read<PaymentCubit>().publishAd();

                      //
                    },
                    label: 'CONTINUE',
                    isEnabled: true,
                  ),
                ),
                const SizedBox(height: 20.0),
              ],
            ),
          );
        },
      ),
    );
  }
}
