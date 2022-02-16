import 'package:flutter/material.dart';

import 'package:magpie_uni/model/nest.dart';
import 'package:magpie_uni/services/api.endpoints.dart';
import 'package:magpie_uni/view/home.or.nest.items.screen.dart';
import 'package:magpie_uni/view/nest.detail.screen.dart';
import 'package:magpie_uni/view/nest.item.creation.dart';
import 'package:magpie_uni/view/nest.or.nest.item.form.screen.dart';

//ignore: must_be_immutable
class NestItemsScreen extends HomeOrNestItemsScreen {
  Nest nest;

  NestItemsScreen({Key? key, required this.nest}) : super(key: key);

  @override
  _NestItemsScreenState createState() => _NestItemsScreenState();
}

class _NestItemsScreenState
    extends HomeOrNestItemsScreenState<NestItemsScreen> {
  @override
  Widget build(BuildContext context) {
    widget.nest = ModalRoute.of(context)!.settings.arguments as Nest;
    setTitle(widget.nest.name);
    return super.build(context);
  }

  @override
  void setTitle(String title) => super.setTitle(title);

  @override
  Future<List> getNestsOrNestItems() async {
    return await ApiEndpoints.getNestItems(
      widget.nest.id!,
      super.sortMode,
      super.asc,
      super.onlyFavored,
    );
  }

  @override
  Widget editButton() {
    return IconButton(
      icon: const Icon(Icons.edit),
      tooltip: "Edit nest",
      onPressed: () async => await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => NestDetailScreen(nest: widget.nest),
        ),
      ).then(onChange),
    );
  }

  @override
  NestOrNestItemFormScreen openCreationScreen() {
    return NestItemCreation(nestId: widget.nest.id);
  }
}
