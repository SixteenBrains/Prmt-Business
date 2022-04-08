import 'package:flutter/material.dart';

class SavedCard extends StatelessWidget {
  const SavedCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 18.0,
        ),
        child: Row(
          /// mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              'assets/images/mastercard.png',
              height: 48,
              width: 48,
            ),
            const SizedBox(width: 25.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '5555 7777 8888 9999',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 5.0),
                Row(
                  // mainAxisAlignment:
                  //     MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      'Exp 12/21',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                    SizedBox(width: 35.0),
                    Text(
                      'cvv 889',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const Spacer(),
            Radio(
              value: false,
              groupValue: false,
              onChanged: (_) {},
            ),
          ],
        ),
      ),
    );
  }
}
