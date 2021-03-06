import 'package:flutter/material.dart';

import 'package:magpie_uni/constants.dart';
import 'package:magpie_uni/size.config.dart';

// ignore: must_be_immutable
class MagpieTextFormField extends StatefulWidget {
  //#region fields and constructor
  final FocusNode? focusNode;
  bool obscure;
  final String name;
  final String hintText;
  final bool enabled;
  final String labelText;
  final IconData? leadingIcon;
  final IconData? trailingIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final Function(String?) onChanged;

  MagpieTextFormField.email({
    Key? key,
    this.enabled = true,
    this.leadingIcon = Icons.email,
    this.labelText = 'Email address',
    this.focusNode,
    required this.validator,
    required this.name,
    required this.onChanged,
    this.trailingIcon,
    this.controller,
    this.hintText = "Email",
    this.obscure = false,
  })  : keyboardType = TextInputType.emailAddress,
        super(key: key);

  //#endregion

  MagpieTextFormField.password({
    Key? key,
    this.enabled = true,
    this.leadingIcon = Icons.lock,
    required this.labelText,
    this.focusNode,
    required this.validator,
    required this.name,
    required this.onChanged,
    this.trailingIcon = Icons.visibility,
    this.controller,
    required this.hintText,
    this.obscure = true,
  })  : keyboardType = TextInputType.visiblePassword,
        super(key: key);

  MagpieTextFormField.name({
    Key? key,
    this.enabled = true,
    this.leadingIcon = Icons.person,
    required this.labelText,
    this.focusNode,
    required this.validator,
    required this.name,
    required this.onChanged,
    this.trailingIcon,
    this.controller,
    required this.hintText,
    this.obscure = false,
  })  : keyboardType = TextInputType.name,
        super(key: key);

  @override
  State<MagpieTextFormField> createState() => _MagpieTextFormFieldState();
}

class _MagpieTextFormFieldState extends State<MagpieTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: widget.key,
      focusNode: widget.focusNode,
      enabled: widget.enabled,
      controller: widget.controller,
      onChanged: widget.onChanged,
      keyboardType: widget.keyboardType,
      validator: widget.validator,
      obscureText: widget.obscure,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
        contentPadding: const EdgeInsets.all(20),
        hintText: widget.hintText,
        prefixIcon: widget.leadingIcon != null
            ? Icon(
                widget.leadingIcon,
                color: mainColor,
                size: SizeConfig.iconSize * 0.75,
              )
            : null,
        suffixIcon: widget.trailingIcon != null
            ? IconButton(
                icon: Icon(
                  !widget.obscure ? Icons.visibility : Icons.visibility_off,
                  color: Theme.of(context).primaryColorDark,
                  size: SizeConfig.iconSize * 0.75,
                ),
                onPressed: () =>
                    setState(() => widget.obscure = !widget.obscure),
              )
            : null,
        labelText: widget.labelText,
      ),
      textCapitalization: TextCapitalization.sentences,
      style: TextStyle(fontSize: SizeConfig.iconSize / 1.75),
    );
  }
}
