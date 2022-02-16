import 'package:flutter/material.dart';

import 'package:magpie_uni/services/api.endpoints.dart';
import 'package:magpie_uni/size.config.dart';
import 'package:magpie_uni/constants.dart';

class MagpieDeleteDialog {
  Future<void> displayDeleteDialog(
          BuildContext context, bool isNest, int id) async =>
      await _deleteDialogBox(context, isNest, id);

  void _delete(BuildContext context, bool isNest, int id) async =>
      await _actuallyDelete(context, isNest, id);

  Future<void> _actuallyDelete(
      BuildContext context, bool isNest, int id) async {
    await ApiEndpoints.deleteNestOrNestItem(isNest, id);
    isNest
        ? Navigator.of(context).popUntil((route) => route.isFirst)
        : Navigator.of(context)
            .popUntil((route) => route.settings.name == "/nestItems");
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
                    fontSize: SizeConfig.hori * (SizeConfig.isTablet ? 2 : 4),
                  ),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                option(
                  () => _delete(context, isNest, id),
                  Icons.delete_forever,
                  "Yes, I'm sure.",
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
                option(
                  () => Navigator.of(context).pop(),
                  Icons.cancel,
                  "No, I've changed my mind.",
                )
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
            size: SizeConfig.hori * (SizeConfig.isTablet ? 3 : 4),
            color: accentColor,
          ),
          const Padding(padding: EdgeInsets.symmetric(horizontal: 4)),
          Text(
            text,
            style: TextStyle(
              fontSize: SizeConfig.hori * (SizeConfig.isTablet ? 2 : 4),
            ),
          ),
        ],
      ),
    );
  }
}
