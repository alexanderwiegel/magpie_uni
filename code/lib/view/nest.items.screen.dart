import 'package:flutter/material.dart';

import 'package:magpie_uni/model/nest.dart';
import 'package:magpie_uni/services/api.endpoints.dart';
import 'package:magpie_uni/view/home.or.nest.items.screen.dart';
import 'package:magpie_uni/view/nest.detail.screen.dart';
import 'package:magpie_uni/view/nest.item.creation.dart';
import 'package:magpie_uni/view/nest.or.nest.item.form.screen.dart';

class NestItemsScreen extends HomeOrNestItemsScreen {
  final Nest nest;

  const NestItemsScreen({Key? key, required this.nest}) : super(key: key);

  @override
  _NestItemsScreenState createState() => _NestItemsScreenState();
}

class _NestItemsScreenState
    extends HomeOrNestItemsScreenState<NestItemsScreen> {
  @override
  void setTitle(String title) => super.setTitle(title);

  @override
  Future<List> getNestsOrNestItems() async =>
      await ApiEndpoints.getNestItems(widget.nest.id!);

  @override
  Widget editButton() => IconButton(
        icon: const Icon(Icons.edit),
        tooltip: "Edit nest",
        onPressed: () async => await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NestDetailScreen(nest: widget.nest),
          ),
        ).then(onChange),
      );

  @override
  void initState() {
    setTitle(widget.nest.name);
    super.initState();
  }

  @override
  NestOrNestItemFormScreen openCreationScreen() =>
      NestItemCreation(nestId: widget.nest.id);
}
