import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/screens/create-ad/cubit/create_ad_cubit.dart';
import '/widgets/custom_textfield.dart';
import '/widgets/bottom_nav_button.dart';
import 'progress_container.dart';

class AdContent extends StatefulWidget {
  const AdContent({Key? key}) : super(key: key);

  @override
  State<AdContent> createState() => _AdContentState();
}

class _AdContentState extends State<AdContent> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final _canvas = MediaQuery.of(context).size;

    return BlocBuilder<CreateAdCubit, CreateAdState>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const SizedBox(height: 25.0),
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
                ProgressContainer(progress: state.progress),
                const SizedBox(height: 20.0),
                Text(
                  'Enter Ad Content Text',
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12.0),
                Text(
                  'Enter the text description that customers will see when they see the ad',
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 20.0),

                CustomTextField(
                  minLines: 3,
                  maxLines: 3,
                  maxLenght: 150,
                  hintText:
                      'Write what your audience will see, make it so attractive that anyone who reads it, clicks it',
                  onchanged: (value) =>
                      context.read<CreateAdCubit>().contentTextChanged(value),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Ad content can\'t be empty';
                    } else if (value.length < 6) {
                      return 'Ad content too short';
                    }
                    return null;
                  },
                  inputType: TextInputType.text,
                ),

                // const Spacer(),

                SizedBox(height: _canvas.height * 0.45),

                BottomNavButton(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    if (_formKey.currentState!.validate()) {
                      context
                          .read<CreateAdCubit>()
                          .changePage(AdCurrentPage.adTargetLink);
                    }
                  },
                  label: 'CONTINUE',
                  isEnabled: state.adContentText.isNotEmpty,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
