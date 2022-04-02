import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prmt_business/widgets/custom_textfield.dart';
import '/screens/create-ad/cubit/create_ad_cubit.dart';
import '/widgets/bottom_nav_button.dart';
import 'progress_container.dart';

class AdName extends StatelessWidget {
  const AdName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //   final _canvas = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ProgressContainer(progress: 1),
        const SizedBox(height: 20.0),
        Text(
          'Name of your ad',
          style: TextStyle(
            color: Colors.grey.shade800,
            fontSize: 22.0,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12.0),
        Text(
          'Enter the name of ad.',
          style: TextStyle(
            color: Colors.grey.shade800,
            fontSize: 16.0,
          ),
        ),
        const SizedBox(height: 20.0),

        CustomTextField(
          minLines: 2,
          maxLines: 2,
          maxLenght: 150,
          hintText:
              'Write what your audience will see, make it so attractive that anyone who reads it, clicks it',
          onchanged: (value) {},
          validator: (value) {},
          inputType: TextInputType.name,
        ),

        const Spacer(),

        BottomNavButton(
          onTap: () =>
              context.read<CreateAdCubit>().changePage(CurrentPage.adType),
          label: 'CONTINUE',
          isEnabled: true,
        ),
        // const SizedBox(height: 10.0),
      ],
    );
  }
}
