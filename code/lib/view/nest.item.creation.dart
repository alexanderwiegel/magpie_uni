import 'package:flutter/material.dart';

import 'package:magpie_uni/model/nest.item.dart';
import 'package:magpie_uni/services/apiEndpoints.dart';
import 'package:magpie_uni/view/nest.or.nest.item.creation.dart';

class NestItemCreation extends NestOrNestItemCreation {
  const NestItemCreation({Key? key}) : super(key: key);

  @override
  _NestItemCreationState createState() => _NestItemCreationState();
}

class _NestItemCreationState
    extends NestOrNestItemCreationState<NestItemCreation> {
  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }

  @override
  Future<void> addNestOrNestItem() async {
    print("Make it a nest item");
    super.nestOrNestItem = NestItem();
    print("Call super method to set attributes");
    super.addNestOrNestItem();
    print("Call api endpoint");
    var response = await apiEndpoints.addNestOrNestItem(nestOrNestItem, false);
    print(response);
  }
}
