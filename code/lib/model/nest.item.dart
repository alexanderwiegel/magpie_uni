import 'package:flutter/material.dart';

import 'package:magpie_uni/model/nest.or.nest.item.dart';

class NestItem extends NestOrNestItem {
  NestItem({Key? key}) : super(key: key);

  @override
  _NestItemState createState() => _NestItemState();
}

class _NestItemState extends NestOrNestItemState<NestItem> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}