import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prmt_business/screens/create-ad/cubit/create_ad_cubit.dart';
import '/screens/create-ad/ad_type.dart';
import '/widgets/bottom_nav_button.dart';
import 'progress_container.dart';

class AdName extends StatelessWidget {
  const AdName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _canvas = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20.0),
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
        TextField(
          minLines: 2,
          maxLines: 2,
          maxLength: 60,
          keyboardType: TextInputType.name,
          style: const TextStyle(fontSize: 20.0),

          // onChanged: (value) =>
          //     context.read<SignUpCubit>().phoneNoChanged(value),
          decoration: InputDecoration(
            hintText:
                'A name you can remember, e.g. the product name or dicount rate',
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 20.0,
            ),
          ),
        ),
        //  const Spacer(),
        SizedBox(height: _canvas.height * 0.5),
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
