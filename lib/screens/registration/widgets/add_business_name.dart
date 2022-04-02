import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/widgets/custom_textfield.dart';
import '/screens/registration/cubit/registration_cubit.dart';
import '/widgets/bottom_nav_button.dart';

class AddBusinessName extends StatefulWidget {
  const AddBusinessName({Key? key}) : super(key: key);

  @override
  State<AddBusinessName> createState() => _AddBusinessNameState();
}

class _AddBusinessNameState extends State<AddBusinessName> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationCubit, RegistrationState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Name of your business',
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12.0),
              Text(
                'Enter the name of your business.',
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 20.0),
              CustomTextField(
                initialValue: state.businessName,
                hintText: 'Your business name',
                onchanged: (value) => context
                    .read<RegistrationCubit>()
                    .businessNameChanged(value),
                validator: (value) {
                  if (value!.length < 5) {
                    return 'Business name too short';
                  }
                  return null;
                },
                maxLenght: 60,
                inputType: TextInputType.name,
              ),
              const Spacer(),
              BottomNavButton(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    context
                        .read<RegistrationCubit>()
                        .changePage(RegistrationCurrentPage.businessType);
                    // context.read<RegistrationCubit>().registerUser();

                  }
                },
                label: 'CONTINUE',
                isEnabled: state.businessName.isNotEmpty,
              ),
            ],
          ),
        );
      },
    );
  }
}
