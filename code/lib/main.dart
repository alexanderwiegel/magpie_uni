import 'package:flutter/material.dart';

import 'wrapper.dart';
import 'view/home.dart';
import 'constants.dart' as constants;

void main() {
  runApp(Magpie());
}

class Magpie extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Magpie',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: constants.mainColor,
        ),
        routes: {
          "/": (context) => Wrapper(),
          "/home": (context) => HomeScreen(),
        });
  }
}
