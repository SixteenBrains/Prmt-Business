import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:prmt_business/widgets/bottom_nav_button.dart';
import '/widgets/loading_indicator.dart';
import '/screens/registration/cubit/registration_cubit.dart';

class AddBusinessType extends StatefulWidget {
  const AddBusinessType({Key? key}) : super(key: key);

  @override
  State<AddBusinessType> createState() => _AddBusinessTypeState();
}

class _AddBusinessTypeState extends State<AddBusinessType> {
  @override
  void initState() {
    context.read<RegistrationCubit>().getBusinessTypes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegistrationCubit, RegistrationState>(
      builder: (context, state) {
        if (state.status == RegistrationStatus.loading) {
          return const LoadingIndicator();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Awesome!',
              style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 22.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 4.0),
            Text(
              'Now tell us your Business Type',
              style: TextStyle(
                color: Colors.grey.shade800,
                fontSize: 20.0,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20.0),
            Expanded(
              child: ListView.builder(
                itemCount: state.types.length,
                itemBuilder: (context, index) {
                  final type = state.types[index];
                  //  return Text(type?.type ?? 'N/A');
                  if (type != null) {
                    return CheckboxListTile(
                      title: Text(type.type ?? 'N/A'),
                      value: state.businessType == type,
                      onChanged: (value) => context
                          .read<RegistrationCubit>()
                          .chooseBusinessType(type),
                    );
                  }
                  return const Text('N/A');
                },
              ),
            ),
            BottomNavButton(
              onTap: () => context.read<RegistrationCubit>().registerUser(),
              label: 'CONTINUE',
              isEnabled: state.businessName.isNotEmpty,
            ),
          ],
        );
      },
    );
  }
}
