import 'package:flutter/material.dart';
import 'package:magpie_uni/model/nest.item.dart';
import 'package:magpie_uni/services/apiEndpoints.dart';
import 'package:magpie_uni/view/nest.or.nest.item.form.screen.dart';

class NestItemDetailScreen extends NestOrNestItemFormScreen {
  NestItem nestItem;

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
    print("Specify that it is a nest item");
    // TODO: see if I can use widget.nestItem
    super.widget.nestOrNestItem = NestItem(nestId: widget.nestItem.nestId);
    super.widget.nestOrNestItem.id = widget.nestItem.id;
    print("Call super method to set attributes");
    super.uploadNestOrNestItem();
    print("Call api endpoint to edit a nest item");
    // TODO: see if I can use widget.nestItem
    await ApiEndpoints.uploadNestOrNestItem(
            super.widget.nestOrNestItem, false, false).then(onChange);
  }
}
