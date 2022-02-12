// @dart=2.9

import 'package:flutter/material.dart';

import 'package:magpie_uni/constants.dart';
import 'package:magpie_uni/view/auth/register/register.page.dart';
import 'package:magpie_uni/view/auth/login/login.page.dart';
import 'package:magpie_uni/view/home.page.dart';
import 'package:magpie_uni/view/statistic.dart';
import 'package:magpie_uni/wrapper.dart';

void main() => runApp(const Magpie());

class Magpie extends StatelessWidget {
  const Magpie({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage("pics/placeholder.jpg"), context);
    return MaterialApp(
      title: 'Magpie',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: mainColor),
      routes: {
        "/": (context) => const Wrapper(),
        "/login": (context) => const LoginScreen(),
        "/register": (context) => const RegisterScreen(),
        "/home": (context) => const HomePage(),
        "/statistic": (context) => Statistic(),
      },
    );
  }
}
