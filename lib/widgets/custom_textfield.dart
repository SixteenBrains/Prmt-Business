import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Function(String value) onchanged;
  final String? Function(String? value) validator;
  final int? maxLenght;

  const CustomTextField(
      {Key? key,
      required this.hintText,
      required this.onchanged,
      required this.validator,
      this.maxLenght})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLenght,
      style: const TextStyle(fontSize: 20.0),
      onChanged: onchanged,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
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
    );
  }
}
