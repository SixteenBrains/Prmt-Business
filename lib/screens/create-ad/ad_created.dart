import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prmt_business/screens/create-ad/cubit/create_ad_cubit.dart';
import '/screens/create-ad/target_group.dart';

import '/widgets/bottom_nav_button.dart';

class AdCreated extends StatelessWidget {
  const AdCreated({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _canvas = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: _canvas.height * 0.12),
        Image.asset(
          'assets/images/Group 101.png',
          height: _canvas.height * 0.35,
          width: _canvas.height * 0.35,
          fit: BoxFit.contain,
        ),
        SizedBox(height: _canvas.height * 0.06),
        Text(
          'Awesome! Now lets select your target group, demographics and location ',
          style: TextStyle(
            color: Colors.grey.shade800,
            fontSize: 24.0,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        const Spacer(),
        BottomNavButton(
          onTap: () => context
              .read<CreateAdCubit>()
              .changePage(CurrentPage.demographics),
          label: 'CONTINUE',
          isEnabled: true,
        ),
      ],
    );
  }
}
