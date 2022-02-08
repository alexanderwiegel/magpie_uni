import 'package:flutter/material.dart';

class RegisterPageDescription extends StatelessWidget {
  const RegisterPageDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodyText1;

    return Column(
      children: [
        Text(
          "Let's Get Started",
          style: textStyle?.copyWith(
              color: Colors.black, fontWeight: FontWeight.w700, fontSize: 22),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text("Create an account to Magpie to get all features",
              style: textStyle?.copyWith(color: Colors.black54)),
        ),
      ],
    );
  }
}
