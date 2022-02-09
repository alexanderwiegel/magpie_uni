import 'package:flutter/material.dart';
import 'package:magpie_uni/model/nest.dart';
import 'package:magpie_uni/services/apiEndpoints.dart';
import 'package:magpie_uni/view/home.or.nest.items.screen.dart';
import 'package:magpie_uni/view/nest.detail.screen.dart';

class NestItemsScreen extends HomeOrNestItemsScreen {
  final Nest nest;

  NestItemsScreen({required this.nest});

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
        icon: Icon(Icons.edit),
        tooltip: "Edit nest",
        onPressed: () async => await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NestDetailScreen(nest: widget.nest),
          ),
        ),
      );

  @override
  void initState() {
    setTitle(widget.nest.name);
    super.initState();
  }
}
