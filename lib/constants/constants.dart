import 'package:flutter/material.dart';

const primaryColor = Color(0xFF2697FF);
const secondaryColor = Color(0xFF2A2D3E);
const bgColor = Color(0xFF212332);

const defaultPadding = 16.0;

const List<String> dailyBudget = ['100', '200', '500'];

const InputDecoration dateFieldDecoration = InputDecoration(
  hintText: 'DD/MM/YYYY',
  disabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.blue, width: 2),
  ),
  enabledBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.blue, width: 2),
  ),
  focusedBorder: UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.blue, width: 2),
  ),
);

const String errorImage =
    'https://developers.google.com/maps/documentation/streetview/images/error-image-generic.png';
