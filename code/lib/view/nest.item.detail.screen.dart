import 'package:flutter/material.dart';

import 'package:magpie_uni/model/nest.item.dart';
import 'package:magpie_uni/services/apiEndpoints.dart';
import 'package:magpie_uni/view/nest.or.nest.item.form.screen.dart';

class NestItemDetailScreen extends NestOrNestItemFormScreen {
  NestItem nestItem;

  NestItemDetailScreen({required this.nestItem}) : super();

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
    super.nestOrNestItem = NestItem();
    print("Call super method to set attributes");
    super.uploadNestOrNestItem();
    print("Call api endpoint to edit a nest item");
    var response =
    await apiEndpoints.uploadNestOrNestItem(nestOrNestItem, false, false);
    print(response);
  }
}