import 'package:flutter/material.dart';

import 'wrapper.dart';
import 'view/home.dart';
import 'constants.dart' as constants;

void main() {
  runApp(const Magpie());
}

class Magpie extends StatelessWidget {
  const Magpie({Key? key}) : super(key: key);

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
