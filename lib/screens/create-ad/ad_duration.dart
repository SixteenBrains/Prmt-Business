import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '/screens/create-ad/cubit/create_ad_cubit.dart';
import '/widgets/bottom_nav_button.dart';

import 'progress_container.dart';

class AdDuration extends StatefulWidget {
  const AdDuration({Key? key}) : super(key: key);

  @override
  State<AdDuration> createState() => _AdDurationState();
}

class _AdDurationState extends State<AdDuration> {
  final _startDateController = TextEditingController();
  final _endDateController = TextEditingController();

  @override
  void dispose() {
    _startDateController.dispose();
    _endDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final _canvas = MediaQuery.of(context).size;

    return Column(
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

        const SizedBox(height: 20.0),

        const ProgressContainer(progress: 5),

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
        TextField(
          controller: _startDateController,
          keyboardType: TextInputType.name,
          style: const TextStyle(fontSize: 20.0),
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: () async {
                final startDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2023),
                );
                if (startDate != null) {
                  setState(() {
                    _startDateController.text =
                        DateFormat('dd/MM/yyyy').format(startDate);
                  });
                }
              },
              child: const Icon(
                Icons.date_range,
                color: Colors.grey,
              ),
            ),
            hintText: 'DD/MM/YYYY',
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2),
            ),
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 20.0,
            ),
          ),
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
        TextField(
          controller: _endDateController,
          keyboardType: TextInputType.name,
          style: const TextStyle(fontSize: 20.0),
          decoration: InputDecoration(
            suffixIcon: GestureDetector(
              onTap: () async {
                final endDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2023),
                );
                if (endDate != null) {
                  setState(() {
                    _endDateController.text =
                        DateFormat('dd/MM/yyyy').format(endDate);
                  });
                }
              },
              child: const Icon(
                Icons.date_range,
                color: Colors.grey,
              ),
            ),
            hintText: 'DD/MM/YYYY',
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2),
            ),
            hintStyle: TextStyle(
              color: Colors.grey.shade400,
              fontSize: 20.0,
            ),
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

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Chip(
              padding:
                  const EdgeInsets.symmetric(horizontal: 4.0, vertical: 10.0),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
                side: BorderSide(color: Colors.grey.shade400, width: 1.5),
              ),
              label: const Text(
                '₹ 100',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            Chip(
              padding:
                  const EdgeInsets.symmetric(horizontal: 4.0, vertical: 10.0),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
                side: BorderSide(color: Colors.grey.shade400, width: 1.5),
              ),
              label: const Text(
                '₹ 200',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            Chip(
              padding:
                  const EdgeInsets.symmetric(horizontal: 4.0, vertical: 10.0),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
                side: BorderSide(color: Colors.grey.shade400, width: 1.5),
              ),
              label: const Text(
                '₹ 500',
                style: TextStyle(fontSize: 16.0),
              ),
            ),
            Chip(
              padding:
                  const EdgeInsets.symmetric(horizontal: 4.0, vertical: 10.0),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
                side: BorderSide(color: Colors.grey.shade400, width: 1.5),
              ),
              label: const Text(
                'Custom',
                style: TextStyle(fontSize: 16.0),
              ),
            )
          ],
        ),
        // Todo: added custom choosen text field as in
        //https://xd.adobe.com/view/4e4866b6-cc1b-44cb-aa8d-6498dcc1e92f-1b1b/screen/1fbbdc10-238d-4d5b-bf68-e75d2a377fa7/specs/
        const Spacer(),
        // SizedBox(height: _canvas.height * 0.15),
        BottomNavButton(
          onTap: () =>
              context.read<CreateAdCubit>().changePage(CurrentPage.awesome),
          label: 'CONTINUE',
          isEnabled: true,
        ),
        //const SizedBox(height: 10.0),
      ],
    );
  }
}
