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
  Widget build(BuildContext context) {
    // TODO: find a way to add the delete button
    return super.build(context);
  }

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