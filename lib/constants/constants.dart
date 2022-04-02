export 'live_ads_const.dart';

// const List<int> dailyBudget = [100, 200, 500];

import 'package:flutter/material.dart';

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
