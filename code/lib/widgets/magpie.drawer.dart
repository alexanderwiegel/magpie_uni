import 'package:flutter/material.dart';

import 'package:magpie_uni/constants.dart';
import 'package:magpie_uni/size.config.dart';
import 'package:magpie_uni/wrapper.dart';

class MagpieDrawer extends StatelessWidget {
  const MagpieDrawer({Key? key}) : super(key: key);

  final Color iconColor = mainColor;

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
          Padding(padding: EdgeInsets.only(bottom: SizeConfig.vert)),
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
      padding: EdgeInsets.only(bottom: SizeConfig.vert),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(
              icon,
              color: iconColor,
              size: SizeConfig.iconSize,
            ),
            title: Text(
              title,
              style: TextStyle(
                fontSize: SizeConfig.iconSize / 1.75,
              ),
            ),
            onTap: onTap,
          ),
          Padding(padding: EdgeInsets.only(bottom: SizeConfig.vert)),
          Container(
            height: 1,
            width: SizeConfig.screenWidth,
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
