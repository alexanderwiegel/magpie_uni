import 'package:flutter/material.dart';

import 'package:magpie_uni/Constants.dart';

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

  final Color color = textColor;

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
