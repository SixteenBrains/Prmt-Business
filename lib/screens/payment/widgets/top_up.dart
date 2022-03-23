import 'package:flutter/material.dart';

import 'topup_payment.dart';

class TopUp extends StatelessWidget {
  const TopUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.grey.shade700),
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20.0,
        ),
        title: const Text('Top-Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 20.0,
        ),
        child: Column(
          children: const [
            TopUpCard(price: 300, validity: 1),
            SizedBox(height: 10.0),
            TopUpCard(price: 600, validity: 2),
            SizedBox(height: 10.0),
            TopUpCard(price: 900, validity: 3),
          ],
        ),
      ),
    );
  }
}

class TopUpCard extends StatelessWidget {
  final int price;
  final int validity;

  const TopUpCard({Key? key, required this.price, required this.validity})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xffF4F4F9),
      // color: Colors.blue.shade100,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 25.0,
          horizontal: 20.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '₹ $price',
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 22.0,
                      ),
                    ),
                    Text(
                      'Validity - $validity Day',
                      style: TextStyle(
                        color: Colors.grey.shade700,
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () => Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => TopUpPaymentScreen(
                        price: price,
                        validity: validity,
                      ),
                    ),
                  ),
                  child: Container(
                    height: 42.0,
                    width: 100.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: const Center(
                      child: Text(
                        'Buy',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
