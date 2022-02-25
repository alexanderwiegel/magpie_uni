import 'package:flutter/material.dart';

import 'package:magpie_uni/constants.dart';
import 'package:magpie_uni/size.config.dart';

class MagpieSwitch extends StatefulWidget {
  final bool public;
  final Function setPublic;

  const MagpieSwitch({Key? key, required this.public, required this.setPublic})
      : super(key: key);

  @override
  _MagpieSwitchState createState() => _MagpieSwitchState();
}

class _MagpieSwitchState extends State<MagpieSwitch> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Icon(Icons.public, color: mainColor, size: SizeConfig.iconSize),
        ),
        Text(
          "Private",
          style: TextStyle(
            fontSize: SizeConfig.iconSize / 1.8,
            color: widget.public ? Colors.black54 : mainColor,
          ),
        ),
        Switch(
          value: widget.public,
          onChanged: (value) => widget.setPublic(value),
        ),
        Text(
          "Public",
          style: TextStyle(
            fontSize: SizeConfig.iconSize / 1.8,
            color: widget.public ? accentColor : Colors.black54,
          ),
        ),
      ],
    );
  }
}
