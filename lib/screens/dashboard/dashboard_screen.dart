import 'package:flutter/material.dart';
import '/screens/dashboard/sections/ad_section.dart';
import '/constants/constants.dart';
import '/screens/dashboard/widgets/header.dart';
import 'sections/users_section.dart';

class DashBoardScreen extends StatelessWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: ListView(
        /// crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Header(),
          SizedBox(height: 10.0),
          Text(
            'Ads',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20.0),
          AdSection(),
          SizedBox(height: 20.0),
          Text(
            'Users',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w600,
              letterSpacing: 1.2,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 20.0),
          UsersSection(),
        ],
      ),

      ///  ),
    );
  }
}
