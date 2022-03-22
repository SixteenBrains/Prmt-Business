import 'package:flutter/material.dart';
import '/screens/create-ad/ad_type.dart';
import '/widgets/bottom_nav_button.dart';
import 'progress_container.dart';

class AdName extends StatelessWidget {
  const AdName({Key? key}) : super(key: key);

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
              Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
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
              ),

              const SizedBox(height: 20.0),

              const ProgressContainer(progress: 1),

              const SizedBox(height: 20.0),
              Text(
                'Name of your ad',
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12.0),
              Text(
                'Enter the name of ad.',
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 20.0),
              TextField(
                minLines: 2,
                maxLines: 2,
                maxLength: 60,
                keyboardType: TextInputType.name,
                style: const TextStyle(fontSize: 20.0),

                // onChanged: (value) =>
                //     context.read<SignUpCubit>().phoneNoChanged(value),
                decoration: InputDecoration(
                  hintText:
                      'A name you can remember, e.g. the product name or dicount rate',
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
              SizedBox(height: _canvas.height * 0.51),
              BottomNavButton(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const AdType(),
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
