import 'package:flutter/material.dart';

import 'package:magpie_uni/model/nest.dart';
import 'package:magpie_uni/services/apiEndpoints.dart';
import 'package:magpie_uni/view/nest.or.nest.item.creation.dart';

class NestCreation extends NestOrNestItemCreation {
  const NestCreation({Key? key}) : super(key: key);

  @override
  _NestCreationState createState() => _NestCreationState();
}

class _NestCreationState extends NestOrNestItemCreationState<NestCreation> {
  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }

  @override
  Future<void> addNestOrNestItem() async {
    print("Make it a nest");
    super.nestOrNestItem = Nest();
    print("Call super method to set attributes");
    super.addNestOrNestItem();
    print("Call api endpoint");
    var response = await apiEndpoints.addNestOrNestItem(nestOrNestItem, true);
    print(response);
  }
}
