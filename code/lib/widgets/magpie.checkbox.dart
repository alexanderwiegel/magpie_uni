import 'package:flutter/material.dart';

import 'package:magpie_uni/Constants.dart';

//ignore: must_be_immutable
class MagpieCheckbox extends StatefulWidget {
  bool? public;

  MagpieCheckbox({Key? key, required this.public}) : super(key: key);

  @override
  _MagpieCheckboxState createState() => _MagpieCheckboxState();
}

class _MagpieCheckboxState extends State<MagpieCheckbox> {
  @override
  Widget build(BuildContext context) => CheckboxListTile(
        value: widget.public,
        onChanged: (value) => setState(() => widget.public = value),
        title: const Text("Public", style: TextStyle(color: Colors.black54)),
        secondary: const Icon(Icons.public, color: mainColor),
      );
}
