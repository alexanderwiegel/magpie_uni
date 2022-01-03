import 'package:flutter/material.dart';

import '../constants.dart' as constants;
import '../size.config.dart';

class MagpieIcon extends StatelessWidget {
  final IconData? icon;
  final Function? onPressed;
  final String? tooltip;

  MagpieIcon({
    Key? key,
    @required this.icon,
    @required this.onPressed,
    @required this.tooltip,
  }) : super(key: key);

  final Color color = constants.textColor;
  final iconSize =
  SizeConfig.isTablet ? SizeConfig.vert * 3 : SizeConfig.hori * 10;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: color,
      tooltip: tooltip,
      icon: Icon(icon),
      iconSize: iconSize,
      onPressed: () => {},
    );
  }
}
