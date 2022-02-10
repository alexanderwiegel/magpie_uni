import 'package:flutter/material.dart';

import 'package:magpie_uni/model/nest.or.nest.item.dart';

// ignore: must_be_immutable
class MagpieGridView extends StatelessWidget {
  List<NestOrNestItem> filteredNames;
  final bool isNest;
  final String searchText;

  MagpieGridView({
    Key? key,
    required this.filteredNames,
    required this.isNest,
    required this.searchText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      padding: const EdgeInsets.all(8),
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
      crossAxisCount: 2,
      childAspectRatio: 1.05,
      children: _filterList(),
    );
  }

  List<NestOrNestItem> _filterList() {
    List<NestOrNestItem> tempList = [];
    if (searchText.isNotEmpty) {
      for (int i = 0; i < filteredNames.length; i++) {
        if (filteredNames[i]
            .name
            .toLowerCase()
            .contains(searchText.toLowerCase())) {
          tempList.add(filteredNames[i]);
        }
      }
      filteredNames = tempList;
    }
    return filteredNames;
  }
}
