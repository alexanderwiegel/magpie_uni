import 'package:flutter/material.dart';

import 'package:magpie_uni/size.config.dart';

class MagpiePhotoAlert {
  static void displayPhotoAlert(BuildContext context, String title, String text,
          List<String> actionNames, List<dynamic> actionFunctions) async =>
      await _photoAlert(context, title, text, actionNames, actionFunctions);

  static Future<void> _photoAlert(
      BuildContext context,
      String title,
      String text,
      List<String> actionNames,
      List<dynamic> actionFunctions) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text(title)),
          content: SingleChildScrollView(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: SizeConfig.hori * (SizeConfig.isTablet ? 2 : 4),
              ),
            ),
          ),
          actions: List.generate(
            actionNames.length,
            (index) => TextButton(
              onPressed: actionFunctions.length == actionNames.length
                  ? actionFunctions[index]
                  : () {},
              child: Text(actionNames[index]),
            ),
          ),
          elevation: 24.0,
        );
      },
    );
  }
}
