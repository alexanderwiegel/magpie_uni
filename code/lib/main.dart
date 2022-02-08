// @dart=2.9

import 'package:flutter/material.dart';

import 'package:magpie_uni/view/auth/register/register.page.dart';
import 'package:magpie_uni/view/auth/login/login.page.dart';
import 'package:magpie_uni/Constants.dart' as Constants;
import 'package:magpie_uni/view/homePage.dart';
import 'package:magpie_uni/view/statistic.dart';
import 'package:magpie_uni/wrapper.dart';

void main() {
  runApp(const Magpie());
}

class Magpie extends StatelessWidget {
  const Magpie({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage("pics/placeholder.jpg"), context);
    return MaterialApp(
      title: 'Magpie',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Constants.mainColor,
      ),
      routes: {
        "/": (context) => LoginScreen(),
        "/login": (context) => const LoginScreen(),
        "/register": (context) => const RegisterScreen(),
        // "/profile": (context) => const Profile(),
        "/home": (context) => const HomePage(),
        "/statistic": (context) => Statistic(),
      },
    );
  }
}
