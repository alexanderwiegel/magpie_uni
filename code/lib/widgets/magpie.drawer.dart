import 'package:flutter/material.dart';

import 'package:magpie_uni/constants.dart' as Constants;
import 'package:magpie_uni/size.config.dart';

class MagpieDrawer extends StatelessWidget {
  final Color iconColor = Constants.mainColor;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Padding(
              padding: const EdgeInsets.only(top: 43.0, left: 7.0),
              child: Text(
                'Magpie',
                textAlign: TextAlign.center,
                style: TextStyle(color: Constants.textColor, fontSize: 20),
              ),
            ),
            decoration: BoxDecoration(
              color: Constants.mainColor,
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
            Icons.home,
            "Feed",
            () => Navigator.of(context).pop(),
          ),
          option(
            Icons.chat,
            "Chat",
            () => Navigator.of(context).pop(),
          ),
          option(
            Icons.insert_chart, "Statistics",
            //() => Navigator.of(context).pop(),),
            () => navigate(context, "/statistic"),
          ),
          // option(
          //   Icons.settings,
          //   "Settings",
          //   () => Navigator.of(context).pop(),
          // ),
          option(
            Icons.exit_to_app,
            "Logout",
            () async {
              Navigator.of(context).pop();
              // navigate(context, "/");
              // TODO: call sign-out function from auth
              // await _auth.signOut();
            },
          )
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
      // TODO: pass userId
      Navigator.pushReplacementNamed(context, routeName);
    }
  }
}
