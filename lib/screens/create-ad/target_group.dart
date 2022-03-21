import 'package:flutter/material.dart';
import 'package:prmt_business/screens/create-ad/demographics.dart';
import 'package:prmt_business/screens/create-ad/widgets/custom_chip.dart';
import '/screens/create-ad/ad_type.dart';

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

  @override
  Widget build(BuildContext context) {
    final _canvas = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 10.0,
          horizontal: 25.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 25.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const CircleAvatar(
                      backgroundColor: Color(0xffF4F4F9),
                      radius: 25.0,
                      child: Icon(
                        Icons.arrow_back,
                        color: Color(0xff999999),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 40.0,
                      width: 150.0,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: const Center(
                        child: Text(
                          'Preview Ad',
                          style: TextStyle(
                            fontSize: 17.0,
                            color: Colors.blue,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              const ProgressContainer(progress: 6),
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
                children:
                    ageGroup.map((age) => CustomChip(label: age)).toList(),
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
                // alignment: WrapAlignment.center,
                //runAlignment: WrapAlignment.center,
                runSpacing: 18.0,
                spacing: 16.0,
                children: incomeRange
                    .map((income) => CustomChip(label: income))
                    .toList(),
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
                alignment: WrapAlignment.center,
                runAlignment: WrapAlignment.center,
                runSpacing: 18.0,
                spacing: 16.0,
                children: interests
                    .map((interest) => CustomChip(label: interest))
                    .toList(),
              ),
              //   SizedBox(height: _canvas.height * 0.51),
              const SizedBox(height: 25.0),
              BottomNavButton(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const DemoGraphics(),
                  ),
                ),
                label: 'CONTINUE',
                isEnabled: true,
              ),
              const SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}
