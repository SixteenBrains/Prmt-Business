import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '/constants/constants.dart';
import '/widgets/show_snackbar.dart';
import '/screens/create-ad/cubit/create_ad_cubit.dart';
import '/widgets/bottom_nav_button.dart';
import 'progress_container.dart';
import 'widgets/cubit/budget_cubit.dart';
import 'widgets/cubit/budget_widget.dart';

class AdDuration extends StatefulWidget {
  const AdDuration({Key? key}) : super(key: key);

  @override
  State<AdDuration> createState() => _AdDurationState();
}

class _AdDurationState extends State<AdDuration> {
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _submit(CreateAdState state) {
    if (_formKey.currentState!.validate()) {
      FocusScope.of(context).unfocus();
      if (state.budget == null) {
        ShowSnackBar.showSnackBar(context,
            title: 'Please select budget', backgroundColor: Colors.deepOrange);
      } else {
        context.read<CreateAdCubit>().changePage(AdCurrentPage.awesome);
      }
    }
  }

  @override
  void initState() {
    final _adCubit = context.read<CreateAdCubit>();
    if (_adCubit.state.startDate != null) {
      _startDateController.text =
          DateFormat('dd/MM/yyyy').format(_adCubit.state.startDate!);
    }
    if (_adCubit.state.endDate != null) {
      print('End date in null');
      _endDateController.text =
          DateFormat('dd/MM/yyyy').format(_adCubit.state.endDate!);
    }
    super.initState();
  }

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateAdCubit, CreateAdState>(
      builder: (context, state) {
        return Stack(
          children: [
            SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProgressContainer(progress: state.progress),
                    const SizedBox(height: 20.0),
                    Text(
                      'Start Date',
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Text(
                      'Select your start date for the ad',
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            enabled: false,
                            controller: _startDateController,
                            keyboardType: TextInputType.name,
                            style: const TextStyle(fontSize: 20.0),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Start date can\'t be empty';
                              } else {}
                              return null;
                            },
                            decoration: dateFieldDecoration,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            final startDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2023),
                            );
                            if (startDate != null) {
                              //  progress = 5;
                              context
                                  .read<CreateAdCubit>()
                                  .startDateChanged(startDate);
                              setState(() {
                                _startDateController.text =
                                    DateFormat('dd/MM/yyyy').format(startDate);
                              });
                            }
                          },
                          icon: const Icon(Icons.date_range),
                        ),
                      ],
                    ),
                    const SizedBox(height: 35.0),
                    Text(
                      'End Date',
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Text(
                      'Select your end date for the ad',
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            enabled: false,
                            controller: _endDateController,
                            keyboardType: TextInputType.name,
                            style: const TextStyle(fontSize: 20.0),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'End date can\'t be empty';
                              }
                              return null;
                            },
                            decoration: dateFieldDecoration,
                          ),
                        ),
                        IconButton(
                          onPressed: () async {
                            if (state.startDate != null) {
                              final endDate = await showDatePicker(
                                context: context,
                                initialDate: state.startDate!,
                                firstDate: state.startDate!,
                                lastDate: DateTime(2023),
                              );
                              if (endDate != null) {
                                context
                                    .read<CreateAdCubit>()
                                    .endDateChanged(endDate);
                                _endDateController.text =
                                    DateFormat('dd/MM/yyyy').format(endDate);
                                // progress = 6;
                              }
                            } else {
                              ShowSnackBar.showSnackBar(context,
                                  title: 'Please select start date first',
                                  backgroundColor: Colors.deepOrange);
                            }
                          },
                          icon: const Icon(Icons.date_range),
                        )
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    if (state.startDate != null && state.endDate != null)
                      Text(
                        'Your ad will be valid for ${state.endDate?.difference(state.startDate!).inDays} days',
                        style: const TextStyle(
                          fontSize: 15.0,
                          color: Colors.blue,
                        ),
                      ),
                    const SizedBox(height: 35.0),
                    Text(
                      'Daily Budget',
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 22.0,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12.0),
                    Text(
                      'Select your daily budget',
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        fontSize: 16.0,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    if (state.budget != '' && state.budget != null)
                      Text(
                        '₹ ${state.budget}',
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    BlocProvider(
                      create: (context) => BudgetCubit(
                        createAdCubit: context.read<CreateAdCubit>(),
                      ),
                      child: const BudgetWidget(),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: 2.0,
              right: 2.0,
              left: 2.0,
              child: BottomNavButton(
                onTap: () => _submit(state),
                label: 'CONTINUE',
                isEnabled: true,
              ),
            ),
          ],
        );
      },
    );
  }
}

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