import 'package:flutter/material.dart';

import 'package:magpie_uni/size.config.dart';

class MagpieButton extends StatelessWidget {
  final String label;
  final TextStyle? textStyle;
  final EdgeInsets? padding;
  final Color? color;
  final Color? textColor;
  final Color? disabledColor;
  final Function() onPressed;
  final bool enabled;
  final bool loading;
  final bool outlined;

  const MagpieButton.primary({
    required this.label,
    Key? key,
    this.color,
    this.textColor,
    this.disabledColor,
    this.textStyle,
    this.padding,
    required this.onPressed,
    this.enabled = true,
    this.loading = false,
  })  : outlined = false,
        super(key: key);

  const MagpieButton.secondary({
    required this.label,
    Key? key,
    this.color,
    this.textColor,
    this.disabledColor,
    this.textStyle,
    this.padding,
    required this.onPressed,
    this.enabled = true,
    this.loading = false,
  })  : outlined = true,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = this.color ?? theme.colorScheme.secondary;
    final textColor = this.textColor ??
        (outlined ? theme.colorScheme.secondary : Colors.white);
    final disabledColor = this.disabledColor ?? Theme.of(context).disabledColor;
    final TextStyle textStyle = this.textStyle ?? theme.textTheme.headline6!;

    if (outlined) {
      //secondary button
      return OutlinedButton(
        style: OutlinedButton.styleFrom(
          side:
              BorderSide(color: (enabled && !loading) ? color : disabledColor),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        ),
        onPressed: enabled ? onPressed : null,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Stack(
            children: [
              Text(
                loading ? '' : label,
                style: textStyle.copyWith(
                  color: enabled ? textColor : disabledColor,
                  fontSize: SizeConfig.iconSize / 1.75,
                ),
              ),
              if (loading)
                SizedBox(
                  height: textStyle.fontSize,
                  width: textStyle.fontSize,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: textColor,
                  ),
                )
            ],
          ),
        ),
      );
    } else {
      //primary button
      return MaterialButton(
        padding: const EdgeInsets.all(10.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        color: color,
        disabledColor: disabledColor,
        onPressed: (enabled && !loading) ? onPressed : null,
        child: Stack(
          children: [
            Text(
              loading ? '' : label,
              style: textStyle.copyWith(
                color: textColor,
                fontSize: SizeConfig.iconSize / 1.75,
              ),
            ),
            if (loading)
              SizedBox(
                height: textStyle.fontSize,
                width: textStyle.fontSize,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: textColor,
                ),
              )
          ],
        ),
      );
    }
  }
}
