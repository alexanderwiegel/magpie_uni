import 'package:flutter/material.dart';
import 'package:magpie_uni/view/auth/register/register.page.dart';
import 'package:magpie_uni/view/home.dart';
import 'view/auth/login/login.page.dart';
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
        home: const LoginScreen(),
        routes: {
          //"/": (context) => Wrapper(),
          "/home": (context) => HomeScreen(),
          "/login": (context) => const LoginScreen(),
          "/register": (context) => const RegisterScreen(),
        });
  }
}
