import 'package:flutter/material.dart';

import 'package:magpie_uni/model/nest.item.dart';
import 'package:magpie_uni/services/apiEndpoints.dart';
import 'package:magpie_uni/view/nest.or.nest.item.form.screen.dart';

class NestItemCreation extends NestOrNestItemFormScreen {
  const NestItemCreation({Key? key}) : super(key: key);

  @override
  _NestItemCreationState createState() => _NestItemCreationState();
}

class _NestItemCreationState
    extends NestOrNestItemFormScreenState<NestItemCreation> {
  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }

  @override
  Future<void> uploadNestOrNestItem() async {
    print("Specify that it is a nest item");
    super.nestOrNestItem = NestItem();
    print("Call super method to set attributes");
    super.uploadNestOrNestItem();
    print("Call api endpoint to create a new nest item");
    var response =
        await apiEndpoints.uploadNestOrNestItem(nestOrNestItem, false, true);
    print(response);
  }
}
