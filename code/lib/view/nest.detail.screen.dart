import 'package:flutter/material.dart';

import 'package:magpie_uni/model/nest.dart';
import 'package:magpie_uni/services/apiEndpoints.dart';
import 'package:magpie_uni/view/nest.or.nest.item.form.screen.dart';

class NestDetailScreen extends NestOrNestItemFormScreen {
  Nest nest;

  NestDetailScreen({required this.nest}) : super();

  @override
  _NestDetailScreenState createState() => _NestDetailScreenState();
}

class _NestDetailScreenState
    extends NestOrNestItemFormScreenState<NestDetailScreen> {
  @override
  int getIdOfNestOrNestItem() => widget.nest.id!;

  @override
  Future<void> uploadNestOrNestItem() async {
    print("Specify that it is a nest");
    super.nestOrNestItem = Nest();
    print("Call super method to set attributes");
    super.uploadNestOrNestItem();
    print("Call api endpoint to edit a nest");
    var response =
    await apiEndpoints.uploadNestOrNestItem(nestOrNestItem, true, false);
    print(response);
  }
}