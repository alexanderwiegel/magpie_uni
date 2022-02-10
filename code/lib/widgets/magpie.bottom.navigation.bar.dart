import 'package:flutter/material.dart';

import 'package:magpie_uni/widgets/magpie.icon.button.dart';
import 'package:magpie_uni/Constants.dart';
import 'package:magpie_uni/sort.mode.dart';
// import 'package:magpie_uni/size.config.dart';

class MagpieBottomNavigationBar extends StatelessWidget {
  final Function switchSortOrder;
  final VoidCallback showFavorites;
  final VoidCallback searchPressed;

  final SortMode sortMode;
  final bool asc;
  final bool onlyFavored;

  final Icon searchIcon;
  final Widget searchTitle;

  const MagpieBottomNavigationBar({
    Key? key,
    required this.searchPressed,
    required this.showFavorites,
    required this.switchSortOrder,
    required this.sortMode,
    required this.asc,
    required this.onlyFavored,
    required this.searchIcon,
    required this.searchTitle,
  }) : super(key: key);

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
        color: mainColor,
        shape: const CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            PopupMenuButton<SortMode>(
              icon: Icon(
                Icons.sort_by_alpha,
                color: textColor,
                size: iconSize,
              ),
              tooltip: "Select sort mode",
              onSelected: (SortMode result) => switchSortOrder(result),
              initialValue: sortMode,
              itemBuilder: (BuildContext context) => <PopupMenuEntry<SortMode>>[
                menuItem(SortMode.sortById, "Sort by date"),
                menuItem(SortMode.sortByName, "Sort by name"),
                menuItem(SortMode.sortByWorth, "Sort by worth"),
                menuItem(SortMode.sortByFavored, "Sort by favorites"),
              ],
            ),
            MagpieIconButton(
              tooltip: onlyFavored ? "Show all" : "Show favorites only",
              icon: onlyFavored ? Icons.favorite : Icons.favorite_border,
              onPressed: showFavorites,
            ),
            IconButton(
              color: textColor,
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
              ? Icon(
                  asc ? Icons.arrow_upward : Icons.arrow_downward,
                  color: Colors.teal,
                  size: iconSize,
                )
              : const Icon(null),
          const Padding(padding: EdgeInsets.only(left: 2.0)),
          Text(txt)
        ],
      ),
    );
  }
}
