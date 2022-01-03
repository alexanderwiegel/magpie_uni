import 'package:flutter/material.dart';

import '../constants.dart' as constants;

class MagpieIconButton extends StatelessWidget {
  final IconData? icon;
  final Function? onPressed;
  final String? tooltip;

  MagpieIconButton({
    Key? key,
    @required this.icon,
    @required this.onPressed,
    @required this.tooltip,
  }) : super(key: key);

  final Color color = constants.textColor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: color,
      tooltip: tooltip,
      icon: Icon(icon),
      onPressed: () => onPressed,
    );
  }
}
