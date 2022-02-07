import 'package:flutter/material.dart';

import '../constants.dart' as constants;

class MagpieIconButton extends StatelessWidget {
  final IconData? icon;
  final String? tooltip;
  final Function? onPressed;

  const MagpieIconButton({
    Key? key,
    @required this.icon,
    @required this.tooltip,
    @required this.onPressed,

  }) : super(key: key);

  final Color color = constants.textColor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      tooltip: tooltip,
      onPressed: () => onPressed,
      color: color,
    );
  }
}
