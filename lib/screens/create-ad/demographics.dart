import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prmt_business/models/ad_model.dart';
import '/screens/create-ad/cubit/create_ad_cubit.dart';
import '/widgets/custom_textfield.dart';
import '/screens/create-ad/preview_ad.dart';
import '/widgets/bottom_nav_button.dart';
import 'progress_container.dart';

class DemoGraphics extends StatefulWidget {
  const DemoGraphics({Key? key}) : super(key: key);

  @override
  State<DemoGraphics> createState() => _DemoGraphicsState();
}

class _DemoGraphicsState extends State<DemoGraphics> {
  @override
  Widget build(BuildContext context) {
    final _canvas = MediaQuery.of(context).size;
    // final _stateController = TextEditingController();
    // final _cityController = TextEditingController();
    // const List<String> _states = [
    //   'Maharashtra',
    //   'Assam',
    //   'Madhya Pradesh',
    //   'Bihar',
    //   'Delhi'
    // ];

    // const List<String> _cities = ['Bhopal', 'Jabalpur', 'Indore'];

    // String _currentSelectedState = 'Maharashtra';

    // String _currentSelectedCity = 'Bhopal';

    final _formKey = GlobalKey<FormState>();

    return BlocBuilder<CreateAdCubit, CreateAdState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProgressContainer(progress: state.progress),
                const SizedBox(height: 20.0),
                Text(
                  'Your State',
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12.0),
                Text(
                  'Select your state',
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 20.0),

                CustomTextField(
                  initialValue: state.state,
                  hintText: 'Maharashtra',
                  onchanged: (value) =>
                      context.read<CreateAdCubit>().stateChanged(value),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'State name can\'t be empty';
                    }
                    return null;
                  },
                  inputType: TextInputType.name,
                ),

                // FormField<String>(
                //   builder: (FormFieldState<String> state) {
                //     return InputDecorator(
                //       decoration: InputDecoration(
                //         hintText: 'Maharashtra',
                //         enabledBorder: const UnderlineInputBorder(
                //           borderSide: BorderSide(color: Colors.blue, width: 2),
                //         ),
                //         focusedBorder: const UnderlineInputBorder(
                //           borderSide: BorderSide(color: Colors.blue, width: 2),
                //         ),
                //         hintStyle: TextStyle(
                //           color: Colors.grey.shade400,
                //           fontSize: 20.0,
                //         ),
                //       ),
                //       isEmpty: _currentSelectedState == '',
                //       child: DropdownButtonHideUnderline(
                //         child: DropdownButton<String>(
                //           value: _currentSelectedState,
                //           icon: const Icon(Icons.keyboard_arrow_down),
                //           isDense: true,
                //           onChanged: (String? newValue) {
                //             print('Selected --- $newValue');
                //             setState(() {
                //               _currentSelectedState = newValue!;
                //               //state.didChange(newValue);
                //             });
                //           },
                //           items: _states.map((String value) {
                //             return DropdownMenuItem<String>(
                //               value: value,
                //               child: Text(value),
                //             );
                //           }).toList(),
                //         ),
                //       ),
                //     );
                //   },
                // ),
                const SizedBox(height: 30.0),
                Text(
                  'Your City',
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: 22.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 12.0),
                Text(
                  'Select your city',
                  style: TextStyle(
                    color: Colors.grey.shade800,
                    fontSize: 16.0,
                  ),
                ),
                const SizedBox(height: 20.0),

                CustomTextField(
                  initialValue: state.city,
                  hintText: 'Mumbai',
                  onchanged: (value) =>
                      context.read<CreateAdCubit>().cityChanged(value),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'City name can\'t be empty';
                    }
                    return null;
                  },
                  inputType: TextInputType.name,
                ),

                // FormField<String>(
                //   builder: (FormFieldState<String> state) {
                //     return InputDecorator(
                //       decoration: InputDecoration(
                //         hintText: 'Bhopal',
                //         enabledBorder: const UnderlineInputBorder(
                //           borderSide: BorderSide(color: Colors.blue, width: 2),
                //         ),
                //         focusedBorder: const UnderlineInputBorder(
                //           borderSide: BorderSide(color: Colors.blue, width: 2),
                //         ),
                //         hintStyle: TextStyle(
                //           color: Colors.grey.shade400,
                //           fontSize: 20.0,
                //         ),
                //       ),
                //       isEmpty: _currentSelectedCity == '',
                //       child: DropdownButtonHideUnderline(
                //         child: DropdownButton<String>(
                //           value: _currentSelectedCity,
                //           icon: const Icon(Icons.keyboard_arrow_down),
                //           isDense: true,
                //           onChanged: (String? newValue) {
                //             print('Selected --- ');
                //             setState(() {
                //               _currentSelectedCity = newValue!;
                //               //state.didChange(newValue);
                //             });
                //           },
                //           items: _cities.map((String value) {
                //             return DropdownMenuItem<String>(
                //               value: value,
                //               child: Text(value),
                //             );
                //           }).toList(),
                //         ),
                //       ),
                //     );
                //   },
                // ),

                SizedBox(height: _canvas.height * 0.37),

                BottomNavButton(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      FocusScope.of(context).unfocus();
                      Navigator.of(context).pushNamed(
                        PreviewAd.routeName,
                        arguments: PreviewAdArgs(
                          adModel: AdModel(
                            adName: state.adName,
                            adContent: state.adContentText,
                            adTargetLink: state.adTargetLink,
                            ageGroup: state.ageGroup,
                            adId: '1',
                            adImage: state.adImage,
                            adVideo: state.adVideo,
                            state: state.state,
                            city: state.city,
                            startDate: state.startDate,
                            endDate: state.endDate,
                            incomeRange: state.incomeRange,
                            interests: state.interests,
                          ),
                        ),
                      );
                    }
                  },
                  label: 'CONTINUE',
                  isEnabled: true,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
