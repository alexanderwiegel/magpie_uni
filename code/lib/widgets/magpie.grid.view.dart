import 'package:flutter/material.dart';

import '../model/nest.dart';
import '../model/nest.or.nest.item.dart';

class MagpieGridView extends StatelessWidget {
  const MagpieGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<NestOrNestItem> nests = List.empty(growable: true);

    nests.add(NestOrNestItem(
      name: "Vinyl",
      createdAt: DateTime.now(),
    ));

    Nest nest = Nest();
    nest.name = "Bottle caps";
    nest.createdAt = DateTime.now();
    //print(nest.toMap());
    nests.add(nest);

    print(nests);

    return GridView.count(
        padding: const EdgeInsets.all(8),
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        crossAxisCount: 2,
        childAspectRatio: 1.05,
        children: nests);
  }
}
