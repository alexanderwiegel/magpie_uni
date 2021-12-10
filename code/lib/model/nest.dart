import 'package:flutter/material.dart';

import 'nest_or_nest_item.dart';

class Nest extends NestOrNestItem {
  Nest() : super();

  @override
  _NestState createState() => _NestState();
}

class _NestState extends NestOrNestItemState<Nest> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
