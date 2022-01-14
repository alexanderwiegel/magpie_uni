import 'package:flutter/material.dart';

import '../constants.dart' as constants;

class MagpieFormField extends StatelessWidget {
  final bool enabled;
  final IconData? icon;
  final String? labelText;
  final String? hintText;
  final String? initialValue;
  final OutlineInputBorder? border;
  final TextEditingController? controller;
  final List<dynamic>? inputFormatter;
  final TextInputType? keyboardType;
  final Function? onChanged;
  final Function? validate;

  const MagpieFormField({
    Key? key,
    this.enabled = true,
    @required this.icon,
    @required this.labelText,
    this.hintText,
    this.initialValue,
    this.border,
    this.controller,
    this.inputFormatter,
    this.keyboardType,
    this.onChanged,
    this.validate
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TextFormField(
        enabled: enabled,
        controller: controller,
        decoration: InputDecoration(
          border: border,
          hintText: hintText,
          icon: Icon(
              icon,
              color: constants.mainColor
          ),
          labelText: labelText,
        ),
        initialValue: initialValue,
        // TODO: change the properties inputFormatters, onChanged and validator
        // to make them fit
        //inputFormatters: inputFormatter,
        keyboardType: keyboardType,
        maxLines: null,
        //onChanged: onChanged,
        textCapitalization: TextCapitalization.sentences,
        //validator: validate,
      ),
    );
  }
}
