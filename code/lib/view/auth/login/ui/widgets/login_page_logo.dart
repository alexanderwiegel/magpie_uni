import 'package:flutter/material.dart';

class LoginPageLogo extends StatelessWidget {
  const LoginPageLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => const Image(
        image: AssetImage("pics/logo.png"),
        width: 200.0,
      );
}
