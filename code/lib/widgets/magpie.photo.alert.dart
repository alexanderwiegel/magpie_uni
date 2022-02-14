import 'package:flutter/material.dart';

import 'package:magpie_uni/size.config.dart';

class MagpiePhotoAlert {
  static void displayPhotoAlert(BuildContext context, String title, String text,
          List<String> actionNames, List<dynamic> actionFunctions,
          {List<String>? similarPhotoPaths}) async =>
      await _photoAlert(context, title, text, actionNames, actionFunctions,
          similarPhotoPaths);

  static Future<void> _photoAlert(
      BuildContext context,
      String title,
      String text,
      List<String> actionNames,
      List<dynamic> actionFunctions,
      List<String>? similarPhotoPaths) {
    List<Widget> similarPhotos = List.generate(
      similarPhotoPaths!.length,
      (index) => Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        clipBehavior: Clip.antiAlias,
        child: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Image.network(
            similarPhotoPaths[index],
            fit: BoxFit.cover,
            width: SizeConfig.screenWidth * 0.7,
            height: SizeConfig.screenHeight * 0.3,
          ),
        ),
      ),
    );

    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Center(child: Text(title)),
          content: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: similarPhotos),
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
