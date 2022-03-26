import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '/widgets/bottom_nav_button.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _canvas = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20.0,
        ),
        iconTheme: const IconThemeData(
          color: Colors.grey,
          size: 25.0,
        ),
        title: const Text('Profile Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 20.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10.0),
              TextFormField(
                initialValue: '7506079111',

                style: const TextStyle(fontSize: 20.0),
                // onChanged: (value) =>
                //     context.read<SignUpCubit>().phoneNoChanged(value),
                decoration: InputDecoration(
                  labelText: 'Mobile Number',
                  hintText: 'Eg - 98282928292',
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
                  suffix: const Icon(
                    FontAwesomeIcons.edit,
                    color: Colors.grey,
                    size: 18.0,
                  ),
                ),
              ),
              const SizedBox(height: 25.0),
              TextFormField(
                initialValue: 'Amalendu Hajraa',

                style: const TextStyle(fontSize: 20.0),
                // onChanged: (value) =>
                //     context.read<SignUpCubit>().phoneNoChanged(value),
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  hintText: 'Enter Full Name',
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
                  // suffix: const Icon(
                  //   FontAwesomeIcons.edit,
                  //   color: Colors.grey,
                  //   size: 18.0,
                  // ),
                ),
              ),
              const SizedBox(height: 25.0),
              TextFormField(
                initialValue: 'Amalendu.h123@gmail.com',

                style: const TextStyle(fontSize: 20.0),
                // onChanged: (value) =>
                //     context.read<SignUpCubit>().phoneNoChanged(value),
                decoration: InputDecoration(
                  labelText: 'Email ID',
                  hintText: 'Enter Email',
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
                  // suffix: const Icon(
                  //   FontAwesomeIcons.edit,
                  //   color: Colors.grey,
                  //   size: 18.0,
                  // ),
                ),
              ),
              const SizedBox(height: 25.0),
              TextFormField(
                initialValue: 'Maharashtra',

                style: const TextStyle(fontSize: 20.0),
                // onChanged: (value) =>
                //     context.read<SignUpCubit>().phoneNoChanged(value),
                decoration: InputDecoration(
                  labelText: 'State',
                  hintText: 'Enter State',
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
                  // suffix: const Icon(
                  //   FontAwesomeIcons.edit,
                  //   color: Colors.grey,
                  //   size: 18.0,
                  // ),
                ),
              ),
              const SizedBox(height: 25.0),
              TextFormField(
                initialValue: 'Mumbai',

                style: const TextStyle(fontSize: 20.0),
                // onChanged: (value) =>
                //     context.read<SignUpCubit>().phoneNoChanged(value),
                decoration: InputDecoration(
                  labelText: 'City',
                  hintText: 'Enter City',
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
                  // suffix: const Icon(
                  //   FontAwesomeIcons.edit,
                  //   color: Colors.grey,
                  //   size: 18.0,
                  // ),
                ),
              ),
              SizedBox(height: _canvas.height * 0.22),
              BottomNavButton(
                label: 'CREATE NEW AD',
                isEnabled: true,
                onTap: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
