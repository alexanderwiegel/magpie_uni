import 'package:flutter/material.dart';

import 'package:magpie_uni/model/nest_or_nest_item.dart';

class NestItem extends NestOrNestItem {
  NestItem() : super();

  @override
  _NestItemState createState() => _NestItemState();
}

class _NestItemState extends NestOrNestItemState<NestItem> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}