import 'package:flutter/material.dart';
import 'package:magpie_uni/services/apiEndpoints.dart';

import 'package:magpie_uni/size.config.dart';
import 'package:magpie_uni/constants.dart' as Constants;

class MagpieDeleteDialog {
  void displayDeleteDialog(BuildContext context, bool isNest, int id) async {
    await _deleteDialogBox(context, isNest, id);
  }

  void _delete(BuildContext context, bool isNest, int id) async {
    await _actuallyDelete(context, isNest, id);
  }

  Future<void> _actuallyDelete(BuildContext context, bool isNest, int id) async {
    await apiEndpoints.deleteNestOrNestItem(isNest, id);
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  Future<void> _deleteDialogBox(BuildContext context, bool isNest, int id) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  isNest
                      ? "Delete this nest forever?"
                      : "Delete this nest item forever?",
                  style: TextStyle(
                      color: Colors.red,
                      fontSize: SizeConfig.isTablet
                          ? SizeConfig.hori * 2
                          : SizeConfig.hori * 4),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
                option(() => _delete(context, isNest, id), Icons.delete_forever,
                    "Yes, I'm sure."),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
                option(() => Navigator.of(context).pop(), Icons.cancel,
                    "No, I've changed my mind.")
              ],
            ),
          ),
        );
      },
    );
  }

  Widget option(VoidCallback onTap, IconData icon, String text) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            size:
            SizeConfig.isTablet ? SizeConfig.hori * 3 : SizeConfig.hori * 4,
            color: Constants.accentColor,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
          ),
          Text(
            text,
            style: TextStyle(
                fontSize: SizeConfig.isTablet
                    ? SizeConfig.hori * 2
                    : SizeConfig.hori * 4),
          ),
        ],
      ),
    );
  }
}
