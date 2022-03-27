import 'package:flutter/material.dart';
import '/constants/constants.dart';
import '/screens/dashboard/widgets/header.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

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
              'Users',
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
