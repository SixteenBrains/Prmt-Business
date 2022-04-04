import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/widgets/show_snackbar.dart';
import '/screens/create-ad/cubit/create_ad_cubit.dart';
import '/screens/create-ad/widgets/custom_chip.dart';
import '/widgets/bottom_nav_button.dart';
import 'progress_container.dart';

const List<String> ageGroup = [
  '18-22 yrs',
  '23-28 yrs',
  '29-35 yrs',
  '36-42 yrs',
  '42-50 yrs',
  '51-60 yrs',
];

const List<String> incomeRange = [
  '5k-25k',
  '25k-40k',
  '40k-60k',
  '60k-100k',
  '100k plus',
];

const List<String> interests = [
  'Travelling',
  'Music',
  'Cricket',
  'Reading',
  'Cycling',
  'Cooking',
  'Painting',
  'Yoga',
  'Coffee',
  'Animation',
  'Pets',
  'Make-Up',
];

class TargetGroup extends StatelessWidget {
  const TargetGroup({Key? key}) : super(key: key);

  void _submit(BuildContext context, CreateAdState state) {
    if (state.ageGroup.isEmpty) {
      ShowSnackBar.showSnackBar(context,
          title: 'Please select age group', backgroundColor: Colors.deepOrange);
    } else if (state.incomeRange.isEmpty) {
      ShowSnackBar.showSnackBar(context,
          title: 'Please select income range',
          backgroundColor: Colors.deepOrange);
    } else if (state.interests.isEmpty) {
      ShowSnackBar.showSnackBar(context,
          title: 'Please select interest', backgroundColor: Colors.deepOrange);
    } else {
      context.read<CreateAdCubit>().changePage(AdCurrentPage.demographics);
    }
  }

  @override
  Widget build(BuildContext context) {
    //final _canvas = MediaQuery.of(context).size;
    return BlocBuilder<CreateAdCubit, CreateAdState>(
      builder: (context, state) {
        return Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProgressContainer(progress: state.progress),
                  const SizedBox(height: 20.0),
                  Text(
                    'Age',
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    'Select the preferred age-range of the target',
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Wrap(
                    alignment: WrapAlignment.center,
                    runAlignment: WrapAlignment.center,
                    runSpacing: 18.0,
                    spacing: 16.0,
                    children: ageGroup.map(
                      (age) {
                        final isSelected = state.ageGroup.contains(age);
                        return CustomChip(
                          onTap: () {
                            if (isSelected) {
                              context.read<CreateAdCubit>().removeAgeGroup(age);
                            } else {
                              context.read<CreateAdCubit>().addAgeGroup(age);
                            }
                          },
                          label: age,
                          isSelected: isSelected,
                        );
                      },
                    ).toList(),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'Income Range',
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    'Select the per month income of your target audiences:',
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Wrap(
                    runSpacing: 18.0,
                    spacing: 16.0,
                    children: incomeRange.map(
                      (income) {
                        bool isSelected = state.incomeRange.contains(income);
                        return CustomChip(
                          onTap: () {
                            if (isSelected) {
                              context
                                  .read<CreateAdCubit>()
                                  .removeIncomeRange(income);
                            } else {
                              context
                                  .read<CreateAdCubit>()
                                  .addIncomeRange(income);
                            }
                          },
                          label: income,
                          isSelected: isSelected,
                        );
                      },
                    ).toList(),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'Interest',
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    'Select what interest of your ad target',
                    style: TextStyle(
                      color: Colors.grey.shade800,
                      fontSize: 16.0,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Wrap(
                    alignment: WrapAlignment.start,
                    // runAlignment: WrapAlignment.spaceBetween,
                    runAlignment: WrapAlignment.start,
                    runSpacing: 18.0,
                    spacing: 35.0,
                    children: interests.map(
                      (interest) {
                        bool isSelected = state.interests.contains(interest);
                        return CustomChip(
                          onTap: () {
                            if (isSelected) {
                              context
                                  .read<CreateAdCubit>()
                                  .removeInterest(interest);
                            } else {
                              context
                                  .read<CreateAdCubit>()
                                  .addInterest(interest);
                            }
                          },
                          label: interest,
                          isSelected: isSelected,
                        );
                      },
                    ).toList(),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 2.0,
              right: 2.0,
              left: 2.0,
              child: BottomNavButton(
                onTap: () => _submit(context, state),
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
