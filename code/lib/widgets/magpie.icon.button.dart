import 'package:flutter/material.dart';

import '../Constants.dart' as Constants;

class MagpieIconButton extends StatelessWidget {
  final IconData? icon;
  final String? tooltip;
  final VoidCallback? onPressed;

  const MagpieIconButton({
    Key? key,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  }) : super(key: key);

  final Color color = Constants.textColor;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      tooltip: tooltip,
      onPressed: onPressed,
      color: color,
      iconSize: 30,
    );
  }
}
