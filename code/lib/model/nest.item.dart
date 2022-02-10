import 'package:flutter/material.dart';

import 'package:magpie_uni/model/nest.or.nest.item.dart';
import 'package:magpie_uni/view/nest.item.detail.screen.dart';

class NestItem extends NestOrNestItem {
  late int? nestId;

  NestItem({required this.nestId}) : super();

  @override
  Map<String, dynamic> toMap() {
    Map<String, dynamic> nestItem = super.toMap();
    nestItem.addAll({
      'nest_id': nestId,
    });
    return nestItem;
  }

  @override
  NestItem.fromMap(dynamic obj, {Key? key}) : super.fromMap(obj, key: key) {
    nestId = obj["nest_id"];
    super.worth = obj["worth"].runtimeType == Null ? 0 : obj["worth"];
  }

  @override
  _NestItemState createState() => _NestItemState();
}

class _NestItemState extends NestOrNestItemState<NestItem> {
  @override
  void openNextScreen(BuildContext context) async {
    NestItem currentNestItem = NestItem(nestId: widget.nestId);
    currentNestItem.id = super.widget.id;
    currentNestItem.userId = super.widget.userId;
    currentNestItem.name = super.widget.name;
    currentNestItem.photo = super.widget.photo;
    currentNestItem.description = super.widget.description;
    currentNestItem.worth = super.widget.worth;
    currentNestItem.favored = super.widget.favored;
    currentNestItem.public = super.widget.public;
    currentNestItem.createdAt = super.widget.createdAt;
    
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NestItemDetailScreen(
          nestItem: currentNestItem,
        ),
      ),
    ).then(onChange);
  }
}
