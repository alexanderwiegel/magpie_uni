import 'package:flutter/material.dart';

import 'package:magpie_uni/model/nest.dart';
import 'package:magpie_uni/services/api.endpoints.dart';
import 'package:magpie_uni/view/nest.or.nest.item.form.screen.dart';

//ignore: must_be_immutable
class NestCreation extends NestOrNestItemFormScreen {
  NestCreation({Key? key}) : super(key: key, nestOrNestItem: Nest());

  @override
  _NestCreationState createState() => _NestCreationState();
}

class _NestCreationState extends NestOrNestItemFormScreenState<NestCreation> {
  @override
  Future<void> uploadNestOrNestItem() async {
    //print("Specify that it is a nest");
    super.widget.nestOrNestItem = Nest();
    //print("Call super method to set attributes");
    super.uploadNestOrNestItem();
    //print("Call api endpoint to create a new nest");
    //print(super.widget.nestOrNestItem.photo);
    await ApiEndpoints.uploadNestOrNestItem(
      super.widget.nestOrNestItem,
      true,
      true,
    ).then(onChange);
  }
}
