import 'package:flutter/material.dart';

import 'package:magpie_uni/model/nest.dart';
import 'package:magpie_uni/services/apiEndpoints.dart';
import 'package:magpie_uni/view/nest.or.nest.item.form.screen.dart';

class NestCreation extends NestOrNestItemFormScreen {
  const NestCreation({Key? key}) : super(key: key);

  @override
  _NestCreationState createState() => _NestCreationState();
}

class _NestCreationState extends NestOrNestItemFormScreenState<NestCreation> {
  @override
  Widget build(BuildContext context) {
    return super.build(context);
  }

  @override
  Future<void> uploadNestOrNestItem() async {
    print("Specify that it is a nest");
    super.nestOrNestItem = Nest();
    print("Call super method to set attributes");
    super.uploadNestOrNestItem();
    print("Call api endpoint to create a new nest");
    var response =
        await apiEndpoints.uploadNestOrNestItem(nestOrNestItem, true, true);
    print(response);
  }
}
