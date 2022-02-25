import 'package:flutter/material.dart';

import 'package:magpie_uni/size.config.dart';

class RegisterPageDescription extends StatelessWidget {
  const RegisterPageDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyle = theme.textTheme.bodyText1;

    return Column(
      children: [
        Text(
          "Let's get started",
          style: textStyle?.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w700,
            fontSize: SizeConfig.iconSize / 1.5,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(
            "Create an account for Magpie to get all features",
            textAlign: TextAlign.center,
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
