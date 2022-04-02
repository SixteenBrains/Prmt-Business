import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/widgets/custom_textfield.dart';
import '/screens/create-ad/cubit/create_ad_cubit.dart';
import '/widgets/bottom_nav_button.dart';
import 'progress_container.dart';

class AdName extends StatefulWidget {
  const AdName({Key? key}) : super(key: key);

  @override
  State<AdName> createState() => _AdNameState();
}

class _AdNameState extends State<AdName> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //   final _canvas = MediaQuery.of(context).size;

    return BlocBuilder<CreateAdCubit, CreateAdState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProgressContainer(progress: state.progress),
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
                initialValue: state.adName,
                minLines: 2,
                maxLines: 2,
                maxLenght: 150,
                hintText:
                    'Write what your audience will see, make it so attractive that anyone who reads it, clicks it',
                onchanged: (value) =>
                    context.read<CreateAdCubit>().adNameChanged(value),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Ad name can\'t be empty';
                  } else if (value.length < 4) {
                    return 'Ad name too short';
                  }
                  return null;
                },
                inputType: TextInputType.name,
              ),
              const Spacer(),
              BottomNavButton(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    FocusScope.of(context).unfocus();
                    context
                        .read<CreateAdCubit>()
                        .changePage(AdCurrentPage.adType);
                  }
                },
                label: 'CONTINUE',
                isEnabled: state.adName.isNotEmpty,
              ),
            ],
          ),
        );
      },
    );
  }
}
