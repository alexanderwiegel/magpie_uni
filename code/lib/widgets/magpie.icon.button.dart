import 'package:flutter/material.dart';

import 'package:magpie_uni/constants.dart';
import 'package:magpie_uni/size.config.dart';

class MagpieIconButton extends StatelessWidget {
  final IconData? icon;
  final String? tooltip;
  final VoidCallback? onPressed;
  late final Color color;

  MagpieIconButton({
    Key? key,
    required this.icon,
    required this.tooltip,
    required this.onPressed,
    this.color = textColor,
  }) : super(key: key);

  final double iconSize = SizeConfig.vert * 5;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      tooltip: tooltip,
      onPressed: onPressed,
      color: color,
      iconSize: iconSize,
    );
  }
}
