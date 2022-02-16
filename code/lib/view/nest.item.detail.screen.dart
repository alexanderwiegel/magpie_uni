import 'package:flutter/material.dart';

import 'package:magpie_uni/model/nest.item.dart';
import 'package:magpie_uni/services/api.endpoints.dart';
import 'package:magpie_uni/view/nest.or.nest.item.form.screen.dart';

//ignore: must_be_immutable
class NestItemDetailScreen extends NestOrNestItemFormScreen {
  final NestItem nestItem;

  NestItemDetailScreen({Key? key, required this.nestItem})
      : super(key: key, nestOrNestItem: nestItem);

  @override
  _NestDetailScreenState createState() => _NestDetailScreenState();
}

class _NestDetailScreenState
    extends NestOrNestItemFormScreenState<NestItemDetailScreen> {
  @override
  int getIdOfNestOrNestItem() => widget.nestItem.id!;

  @override
  Future<void> uploadNestOrNestItem() async {
    super.widget.nestOrNestItem = NestItem(nestId: widget.nestItem.nestId);
    super.widget.nestOrNestItem.id = widget.nestItem.id;
    super.uploadNestOrNestItem();
    await ApiEndpoints.uploadNestOrNestItem(
      super.widget.nestOrNestItem,
      false,
      false,
    ).then(onChange);
  }
}
