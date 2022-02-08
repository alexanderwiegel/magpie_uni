import 'package:flutter/material.dart';

import 'package:magpie_uni/widgets/magpie.icon.button.dart';
import 'package:magpie_uni/Constants.dart' as Constants;

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