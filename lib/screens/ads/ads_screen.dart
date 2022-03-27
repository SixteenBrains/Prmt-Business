import 'package:flutter/material.dart';
import '/constants/constants.dart';
import '/screens/dashboard/widgets/header.dart';

class AdsScreen extends StatelessWidget {
  const AdsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        children: const [
          Header(),
          Spacer(),
          Center(
            child: Text(
              'Ads',
              style: TextStyle(
                fontSize: 25.0,
                color: Colors.white,
              ),
            ),
          ),
          Spacer(),
        ],
      ),

      ///  ),
    );
  }
}
