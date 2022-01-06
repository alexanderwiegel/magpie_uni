import 'package:flutter/material.dart';

import 'constants.dart' as constants;
import 'view/profile.dart';
import 'wrapper.dart';

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
