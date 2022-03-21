import 'package:flutter/material.dart';
import '/screens/create-ad/ad_type.dart';
import '/widgets/bottom_nav_button.dart';
import 'ad_duration.dart';
import 'progress_container.dart';

class TargetLink extends StatelessWidget {
  const TargetLink({Key? key}) : super(key: key);

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

              const ProgressContainer(progress: 4),

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
              TextField(
                minLines: 2,
                maxLines: 3,
                // maxLength: 150,
                keyboardType: TextInputType.name,
                style: const TextStyle(fontSize: 20.0),

                // onChanged: (value) =>
                //     context.read<SignUpCubit>().phoneNoChanged(value),
                decoration: InputDecoration(
                  hintText:
                      'Your amazon, flipkart of other link starting with http:// or https://',
                  enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                  ),
                  hintStyle: TextStyle(
                    color: Colors.grey.shade400,
                    fontSize: 20.0,
                  ),
                ),
              ),
              //  const Spacer(),
              SizedBox(height: _canvas.height * 0.518),
              BottomNavButton(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const AdDuration(),
                  ),
                ),
                label: 'CONTINUE',
                isEnabled: false,
              ),
              const SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}
