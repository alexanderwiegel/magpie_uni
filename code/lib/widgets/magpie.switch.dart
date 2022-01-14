import 'package:flutter/material.dart';

import '../constants.dart' as constants;

class MagpieSwitch extends StatefulWidget {
  bool? public;

  MagpieSwitch({Key? key, @required this.public}) : super(key: key);

  @override
  _MagpieSwitchState createState() => _MagpieSwitchState();
}

class _MagpieSwitchState extends State<MagpieSwitch> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Padding(padding: EdgeInsets.only(left: 16)),
        const Icon(Icons.public, color: constants.mainColor),
        const Padding(padding: EdgeInsets.only(left: 16)),
        Text("Private", style: TextStyle(fontSize: 16,
            color: widget.public! ? Colors.black54 : constants.mainColor)),
        Switch(
          value: widget.public!,
          onChanged: (value) => setState(() => widget.public = value),
        ),
        Text("Public", style: TextStyle(fontSize: 16,
            color: widget.public! ? constants.accentColor : Colors.black54)),
      ],
    );
  }
}
