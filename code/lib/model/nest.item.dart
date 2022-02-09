import 'package:flutter/material.dart';

import 'package:magpie_uni/model/nest.or.nest.item.dart';

class NestItem extends NestOrNestItem {
  late int? nestId;

  NestItem({Key? key, required this.nestId}) : super(key: key);

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> nestItem = super.toMap();
    nestItem.addAll({
      'nest_id': nestId,
    });
    return nestItem;
  }

  @override
  NestItem.fromMap(dynamic obj, {Key? key}) : super.fromMap(obj, key: key);

  @override
  _NestItemState createState() => _NestItemState();
}

class _NestItemState extends NestOrNestItemState<NestItem> {
  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }
}