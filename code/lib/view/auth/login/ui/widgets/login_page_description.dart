import 'package:flutter/material.dart';

class LoginPageDescription extends StatelessWidget {
  const LoginPageDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodyText1;

    return Column(
      children: [
        Text(
          "Welcome",
          style: textStyle?.copyWith(
              color: Colors.black, fontWeight: FontWeight.w700, fontSize: 22),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text("Login to your existing account for Magpie",
              style: textStyle?.copyWith(color: Colors.black54)),
        ),
      ],
    );
  }
}
