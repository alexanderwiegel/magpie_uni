import 'package:flutter/material.dart';

import 'package:magpie_uni/model/nest.dart';
import 'package:magpie_uni/services/api.endpoints.dart';
import 'package:magpie_uni/view/nest.or.nest.item.form.screen.dart';

//ignore: must_be_immutable
class NestDetailScreen extends NestOrNestItemFormScreen {
  final Nest nest;

  NestDetailScreen({Key? key, required this.nest})
      : super(key: key, nestOrNestItem: nest);

  @override
  _NestDetailScreenState createState() => _NestDetailScreenState();
}

class _NestDetailScreenState
    extends NestOrNestItemFormScreenState<NestDetailScreen> {
  @override
  int getIdOfNestOrNestItem() => widget.nest.id!;

  @override
  Future<void> uploadNestOrNestItem() async {
    //print("Specify that it is a nest");
    // TODO: see if I can use widget.nest
    super.widget.nestOrNestItem = Nest();
    super.widget.nestOrNestItem.id = widget.nest.id;
    //print("Call super method to set attributes");
    super.uploadNestOrNestItem();
    //print("Call api endpoint to edit a nest");
    // TODO: see if I can use widget.nest
    await ApiEndpoints.uploadNestOrNestItem(
      super.widget.nestOrNestItem,
      true,
      false,
    ).then(onChange);
  }
}
