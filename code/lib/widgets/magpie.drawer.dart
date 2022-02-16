import 'package:flutter/material.dart';

import 'package:magpie_uni/constants.dart';
import 'package:magpie_uni/size.config.dart';
import 'package:magpie_uni/wrapper.dart';

class MagpieDrawer extends StatelessWidget {
  final Color iconColor = mainColor;

  const MagpieDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            child: Padding(
              padding: EdgeInsets.only(top: 43.0, left: 7.0),
              child: Text(
                'Magpie',
                textAlign: TextAlign.center,
                style: TextStyle(color: textColor, fontSize: 20),
              ),
            ),
            decoration: BoxDecoration(
              color: mainColor,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('pics/placeholder.jpg'),
              ),
            ),
          ),
          option(
            Icons.account_circle,
            "My account",
            () => navigate(context, "/home"),
          ),
          option(
            Icons.insert_chart,
            "Statistics",
            () => navigate(context, "/statistic"),
          ),
          option(
            Icons.settings,
            "Settings",
            () => Navigator.of(context).pop(),
          ),
          option(
            Icons.question_answer,
            "FAQ",
            () => Navigator.of(context).pop(),
          ),
          option(
            Icons.help,
            "Help",
            () => Navigator.of(context).pop(),
          ),
          option(
            Icons.exit_to_app,
            "Logout",
            () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (BuildContext context) => const Wrapper(),
                ),
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget option(IconData icon, String title, VoidCallback onTap) {
    return Padding(
      padding: EdgeInsets.only(bottom: SizeConfig.hori),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(
              icon,
              color: iconColor,
              size: SizeConfig.isTablet
                  ? SizeConfig.vert * 4
                  : SizeConfig.hori * 6,
            ),
            title: Text(
              title,
              style: TextStyle(
                fontSize: SizeConfig.isTablet
                    ? SizeConfig.vert * 2.5
                    : SizeConfig.hori * 4,
              ),
            ),
            onTap: onTap,
          ),
          Container(
            height: 1,
            width: SizeConfig.hori * 100,
            color: Colors.grey[200],
          )
        ],
      ),
    );
  }

  void navigate(context, String routeName) {
    bool isNewRouteSameAsCurrent = false;

    Navigator.popUntil(
      context,
      (route) {
        if (route.settings.name == routeName ||
            route.settings.name == "/" && routeName == "/home") {
          Navigator.pop(context);
          isNewRouteSameAsCurrent = true;
        }
        return true;
      },
    );

    if (!isNewRouteSameAsCurrent) {
      Navigator.pushReplacementNamed(context, routeName);
    }
  }
}
