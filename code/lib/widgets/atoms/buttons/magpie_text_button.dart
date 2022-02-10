import 'package:flutter/material.dart';

import 'package:magpie_uni/constants.dart';

class MagpieTextButton extends StatelessWidget {
  final String label;
  final Color color;
  final Function() onPressed;

  const MagpieTextButton.primary({
    Key? key,
    required this.label,
    this.color = mainColor, //TODO TextColor to TextStyle
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //primary button
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.transparent),
        backgroundColor: Colors.transparent,
      ),
      onPressed: onPressed,
      child: Text(
        label,
        style: TextStyle(
          color: color,
        ),
      ),
    );
  }
}
