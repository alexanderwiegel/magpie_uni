import 'package:flutter/material.dart';

import 'package:magpie_uni/constants.dart';

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
        const Padding(padding: EdgeInsets.only(left: 16)),
        const Icon(Icons.public, color: mainColor),
        const Padding(padding: EdgeInsets.only(left: 16)),
        Text(
          "Private",
          style: TextStyle(
            fontSize: 16,
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
            fontSize: 16,
            color: widget.public ? accentColor : Colors.black54,
          ),
        ),
      ],
    );
  }
}
