import 'package:flutter/material.dart';

import 'package:magpie_uni/model/nest.item.dart';
import 'package:magpie_uni/services/apiEndpoints.dart';
import 'package:magpie_uni/view/nest.or.nest.item.form.screen.dart';

class NestItemCreation extends NestOrNestItemFormScreen {
  late final int? nestId;

  NestItemCreation({Key? key, required this.nestId})
      : super(key: key, nestOrNestItem: NestItem(nestId: nestId));

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
    // TODO: see if I can use widget.nestItem
    super.widget.nestOrNestItem = NestItem(nestId: widget.nestId);
    print("Call super method to set attributes");
    super.uploadNestOrNestItem();
    print("Call api endpoint to create a new nest item");
    var response =
        // TODO: see if I can use widget.nestItem
        await ApiEndpoints.uploadNestOrNestItem(
            super.widget.nestOrNestItem, false, true);
    print(response);
  }
}
