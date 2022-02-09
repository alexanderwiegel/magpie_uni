import 'package:flutter/material.dart';

import 'package:magpie_uni/widgets/magpie.icon.button.dart';
import 'package:magpie_uni/Constants.dart' as Constants;
import 'package:magpie_uni/sort.mode.dart';
import 'package:magpie_uni/size.config.dart';

class MagpieBottomNavigationBar extends StatelessWidget {
  final Function switchSortOrder;
  final VoidCallback showFavorites;
  final VoidCallback searchPressed;
  final SortMode sortMode;
  final bool asc;
  final bool onlyFavored;
  final Icon searchIcon;
  final Widget searchTitle;
  final Color color = Constants.textColor;

  MagpieBottomNavigationBar({
    required this.searchPressed,
    required this.showFavorites,
    required this.switchSortOrder,
    required this.sortMode,
    required this.asc,
    required this.onlyFavored,
    required this.searchIcon,
    required this.searchTitle,
  });

  final iconSize = 30.0;
      // SizeConfig.isTablet ? SizeConfig.vert * 3 : SizeConfig.hori * 6;
  // final textSize =
      // SizeConfig.isTablet ? SizeConfig.vert * 2 : SizeConfig.hori * 4;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: BottomAppBar(
        clipBehavior: Clip.antiAlias,
        color: Constants.mainColor,
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            PopupMenuButton<SortMode>(
              icon: Icon(
                Icons.sort_by_alpha,
                color: color,
                size: iconSize,
              ),
              tooltip: "Select sort mode",
              onSelected: (SortMode result) {
                switchSortOrder(result);
              },
              initialValue: sortMode,
              itemBuilder: (BuildContext context) => <PopupMenuEntry<SortMode>>[
                menuItem(SortMode.SortById, "Sort by date"),
                menuItem(SortMode.SortByName, "Sort by name"),
                menuItem(SortMode.SortByWorth, "Sort by worth"),
                menuItem(SortMode.SortByFavored, "Sort by favorites"),
              ],
            ),
            MagpieIconButton(
              tooltip: onlyFavored ? "Show all" : "Show favorites only",
              icon: onlyFavored
                  ? Icons.favorite
                  : Icons.favorite_border,
              onPressed: showFavorites,
            ),
            IconButton(
              color: color,
              // TODO: change this according to nest/nestitem
              tooltip: "Search",
              padding: const EdgeInsets.only(left: 12.0),
              alignment: Alignment.centerLeft,
              icon: searchIcon,
              iconSize: iconSize,
              onPressed: searchPressed,
            ),
            Expanded(child: searchTitle),
          ],
        ),
      ),
    );
  }

  PopupMenuEntry<SortMode> menuItem(SortMode value, String txt) {
    return PopupMenuItem<SortMode>(
      value: value,
      child: Row(
        children: <Widget>[
          sortMode == value
              ? Icon(asc ? Icons.arrow_upward : Icons.arrow_downward,
              color: Colors.teal, size: iconSize)
              : Icon(null),
          Padding(
            padding: const EdgeInsets.only(left: 2.0),
          ),
          Text(txt)
        ],
      ),
    );
  }
}
