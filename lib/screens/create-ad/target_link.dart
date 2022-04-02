import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prmt_business/widgets/custom_textfield.dart';
import '/screens/create-ad/cubit/create_ad_cubit.dart';
import '/widgets/bottom_nav_button.dart';
import 'package:string_validator/string_validator.dart';
import 'progress_container.dart';

class AdTargetLink extends StatefulWidget {
  const AdTargetLink({Key? key}) : super(key: key);

  @override
  State<AdTargetLink> createState() => _AdTargetLinkState();
}

class _AdTargetLinkState extends State<AdTargetLink> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    // final _canvas = MediaQuery.of(context).size;

    return BlocBuilder<CreateAdCubit, CreateAdState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     GestureDetector(
              //       onTap: () => Navigator.of(context).pop(),
              //       child: const CircleAvatar(
              //         backgroundColor: Color(0xffF4F4F9),
              //         radius: 25.0,
              //         child: Icon(
              //           Icons.arrow_back,
              //           color: Color(0xff999999),
              //         ),
              //       ),
              //     ),
              //     GestureDetector(
              //       onTap: () {},
              //       child: Container(
              //         height: 40.0,
              //         width: 150.0,
              //         decoration: BoxDecoration(
              //           border: Border.all(color: Colors.blue),
              //           borderRadius: BorderRadius.circular(20.0),
              //         ),
              //         child: const Center(
              //           child: Text(
              //             'Preview Ad',
              //             style: TextStyle(
              //               fontSize: 17.0,
              //               color: Colors.blue,
              //               fontWeight: FontWeight.w600,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),

              // const SizedBox(height: 20.0),

              ProgressContainer(progress: state.progress),

              const SizedBox(height: 20.0),
              Text(
                'Target Link',
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12.0),
              Text(
                'Provide your link that you want audience to\ngo to',
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 20.0),

              CustomTextField(
                initialValue: state.adTargetLink,
                minLines: 2,
                maxLines: 3,
                hintText:
                    'Your amazon, flipkart of other link starting with http:// or https://',
                onchanged: (value) =>
                    context.read<CreateAdCubit>().targetLinkChanged(value),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Target link can\'t be empty';
                  } else if (!isURL(value)) {
                    return 'Invalid target link';
                  }
                  return null;
                },
                inputType: TextInputType.text,
              ),

              const Spacer(),
              BottomNavButton(
                onTap: () {
                  FocusScope.of(context).unfocus();
                  if (_formKey.currentState!.validate()) {
                    context
                        .read<CreateAdCubit>()
                        .changePage(AdCurrentPage.date);
                  }
                },
                label: 'CONTINUE',
                isEnabled: state.adTargetLink.isNotEmpty,
              ),
            ],
          ),
        );
      },
    );
  }
}
