import 'package:flutter/material.dart';

import 'magpie.icon.button.dart';
import '../Constants.dart' as Constants;

class MagpieBottomNavigationBar extends StatelessWidget {
  const MagpieBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: BottomAppBar(
        color: Constants.mainColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            MagpieIconButton(
              icon: Icons.menu,
              tooltip: "Open menu",
              onPressed: () => {},
            ),
            MagpieIconButton(
              icon: Icons.home,
              tooltip: "Show feed",
              onPressed: () => {},
            ),
            MagpieIconButton(
              icon: Icons.chat,
              tooltip: "Show chat",
              onPressed: () => {},
            ),
            MagpieIconButton(
              icon: Icons.person_pin,
              tooltip: "Show profile",
              onPressed: () => {},
            ),
          ],
        ),
      ),
    );
  }
}