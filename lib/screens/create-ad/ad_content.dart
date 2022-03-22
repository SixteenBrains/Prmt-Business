import 'package:flutter/material.dart';
import '/widgets/bottom_nav_button.dart';
import 'progress_container.dart';
import 'target_link.dart';

class AdContent extends StatelessWidget {
  const AdContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _canvas = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
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

              const ProgressContainer(progress: 3),

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
              TextField(
                minLines: 3,
                maxLines: 3,
                maxLength: 150,
                keyboardType: TextInputType.name,
                style: const TextStyle(fontSize: 20.0),

                // onChanged: (value) =>
                //     context.read<SignUpCubit>().phoneNoChanged(value),
                decoration: InputDecoration(
                  hintText:
                      'Write what your audience will see, make it so attractive that anyone who reads it, clicks it',
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
              SizedBox(height: _canvas.height * 0.44),
              BottomNavButton(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const TargetLink(),
                  ),
                ),
                label: 'CONTINUE',
                isEnabled: true,
              ),
              //  const SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }
}
