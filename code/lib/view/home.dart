import 'package:flutter/material.dart';
import 'package:magpie_uni/services/apiEndpoints.dart';

import 'package:magpie_uni/view/home.or.nest.items.screen.dart';

class Home extends HomeOrNestItemsScreen {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends HomeOrNestItemsScreenState<Home> {
  @override
  void setTitle(String title) => super.setTitle(title);

  @override
  Future<List> getNestsOrNestItems() async => await apiEndpoints.getNests();

  @override
  void initState() {
    setTitle("Home");
    super.initState();
  }
}
