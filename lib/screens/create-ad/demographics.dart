import 'package:flutter/material.dart';
import '/widgets/bottom_nav_button.dart';
import 'preview_ad.dart';
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
    const List<String> _states = [
      'Maharashtra',
      'Assam',
      'Madhya Pradesh',
      'Bihar',
      'Delhi'
    ];

    const List<String> _cities = ['Bhopal', 'Jabalpur', 'Indore'];

    String _currentSelectedState = 'Maharashtra';

    String _currentSelectedCity = 'Bhopal';

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
              FormField<String>(
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                      hintText: 'Maharashtra',
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
                    isEmpty: _currentSelectedState == '',
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _currentSelectedState,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        isDense: true,
                        onChanged: (String? newValue) {
                          print('Selected --- $newValue');
                          setState(() {
                            _currentSelectedState = newValue!;
                            //state.didChange(newValue);
                          });
                        },
                        items: _states.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
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
              FormField<String>(
                builder: (FormFieldState<String> state) {
                  return InputDecorator(
                    decoration: InputDecoration(
                      hintText: 'Bhopal',
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
                    isEmpty: _currentSelectedCity == '',
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _currentSelectedCity,
                        icon: const Icon(Icons.keyboard_arrow_down),
                        isDense: true,
                        onChanged: (String? newValue) {
                          print('Selected --- $newValue');
                          setState(() {
                            _currentSelectedCity = newValue!;
                            //state.didChange(newValue);
                          });
                        },
                        items: _cities.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: _canvas.height * 0.34),
              const SizedBox(height: 25.0),
              BottomNavButton(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => const PreviewAd(),
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
