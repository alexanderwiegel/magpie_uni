import 'package:flutter/material.dart';
import 'package:magpie_uni/widgets/magpie.icon.button.dart';

import '../constants.dart' as constants;

class MagpieBottomNavigationBar extends StatelessWidget {
  const MagpieBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: BottomAppBar(
        color: constants.mainColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              MagpieIconButton(
                  icon: Icons.menu,
                  onPressed: () => {},
                  tooltip: "Open menu"
              ),
              MagpieIconButton(
                  icon: Icons.home,
                  onPressed: () => {},
                  tooltip: "Show feed"
              ),
              MagpieIconButton(
                  icon: Icons.chat,
                  onPressed: () => {},
                  tooltip: "Show chat"
              ),
              MagpieIconButton(
                  icon: Icons.person_pin,
                  onPressed: () => {},
                  tooltip: "Show profile"
              ),
            ]
        )
      )
    );
  }
}
