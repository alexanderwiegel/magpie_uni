import 'package:flutter/material.dart';

import 'package:magpie_uni/services/api.endpoints.dart';
import 'package:magpie_uni/view/home.or.nest.items.screen.dart';
import 'package:magpie_uni/view/nest.creation.dart';
import 'package:magpie_uni/view/nest.or.nest.item.form.screen.dart';

class Home extends HomeOrNestItemsScreen {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends HomeOrNestItemsScreenState<Home> {
  @override
  void setTitle(String title) => super.setTitle(title);

  @override
  Future<List> getNestsOrNestItems() async => await ApiEndpoints.getNests();

  @override
  void initState() {
    setTitle("Home");
    super.initState();
  }

  @override
  NestOrNestItemFormScreen openCreationScreen() => NestCreation();
}
