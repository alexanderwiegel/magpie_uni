import 'package:flutter/material.dart';

import 'wrapper.dart';
import 'view/profile.dart';
import 'constants.dart' as constants;

void main() {
  runApp(const Magpie());
}

class Magpie extends StatelessWidget {
  const Magpie({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage("pics/placeholder.jpg"), context);
    return MaterialApp(
        title: 'Magpie',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: constants.mainColor,
        ),
        routes: {
          "/": (context) => const Wrapper(),
          "/profile": (context) => const Profile(),
        });
  }
}
