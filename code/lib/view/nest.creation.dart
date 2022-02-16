import 'package:flutter/material.dart';

import 'package:magpie_uni/model/nest.dart';
import 'package:magpie_uni/network/user_api_manager.dart';
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
    super.widget.nestOrNestItem = Nest();
    super.widget.nestOrNestItem.userId = UserAPIManager.currentUserId;
    super.uploadNestOrNestItem();
    await ApiEndpoints.uploadNestOrNestItem(
      super.widget.nestOrNestItem,
      true,
      true,
    ).then(onChange);
  }
}
