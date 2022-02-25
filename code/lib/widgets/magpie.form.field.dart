import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:magpie_uni/constants.dart';
import 'package:magpie_uni/size.config.dart';

class MagpieFormField extends StatelessWidget {
  //#region fields and constructor
  final bool enabled;
  final IconData? icon;
  final String? labelText;
  final String? hintText;
  final String? initialValue;
  final OutlineInputBorder? border;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatter;
  final TextInputType? keyboardType;
  final Function? validate;

  const MagpieFormField({
    Key? key,
    this.enabled = true,
    required this.icon,
    required this.labelText,
    this.hintText,
    this.initialValue,
    this.border,
    this.controller,
    this.inputFormatter,
    this.keyboardType,
    this.validate,
  }) : super(key: key);
  //#endregion

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: TextFormField(
        enabled: enabled,
        controller: controller,
        decoration: InputDecoration(
          border: border,
          hintText: hintText,
          icon: Icon(icon, color: mainColor, size: SizeConfig.iconSize),
          labelText: labelText,
        ),
        initialValue: initialValue,
        inputFormatters: inputFormatter,
        keyboardType: keyboardType,
        maxLines: null,
        textCapitalization: TextCapitalization.sentences,
        validator: (value) => validate != null ? validate!(value) : null,
        style: TextStyle(fontSize: SizeConfig.iconSize / 1.8),
      ),
    );
  }
}
