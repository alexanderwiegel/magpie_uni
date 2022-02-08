import 'package:flutter/material.dart';

import 'package:magpie_uni/size.config.dart';

class MagpiePhotoAlert {
  static void displayPhotoAlert(BuildContext context) async {
    await _photoAlert(context);
  }

  static Future<void> _photoAlert(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Text(
              "You must use your own image.",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: SizeConfig.isTablet
                      ? SizeConfig.hori * 2
                      : SizeConfig.hori * 4),
            ),
          ),
        );
      },
    );
  }
}
