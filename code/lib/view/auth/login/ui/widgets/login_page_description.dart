import 'package:flutter/material.dart';

import 'package:magpie_uni/size.config.dart';

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
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: SizeConfig.iconSize / 1.5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Login to your existing account for Magpie",
            style: textStyle?.copyWith(
              color: Colors.black54,
              fontSize: SizeConfig.iconSize / 2,
            ),
          ),
        ),
      ],
    );
  }
}
