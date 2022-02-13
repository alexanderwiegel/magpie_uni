import 'package:flutter/material.dart';

import 'package:magpie_uni/constants.dart';
import 'package:magpie_uni/model/nest.item.dart';
import 'package:magpie_uni/network/user_api_manager.dart';
import 'package:magpie_uni/services/api.endpoints.dart';
import 'package:magpie_uni/view/nest.or.nest.item.form.screen.dart';
import 'package:magpie_uni/widgets/magpie.photo.alert.dart';

//ignore: must_be_immutable
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
  Future<void> uploadNestOrNestItem() async {
    printInfo("Specify that it is a nest item");
    // TODO: see if I can use widget.nestItem
    super.widget.nestOrNestItem = NestItem(nestId: widget.nestId);
    super.widget.nestOrNestItem.userId = UserAPIManager.currentUserId;
    printInfo("Call super method to set attributes");
    super.uploadNestOrNestItem();
    printInfo("Call api endpoint to create a new nest item");
    // TODO: see if I can use widget.nestItem
    Map<String, dynamic> response = await ApiEndpoints.uploadNestOrNestItem(
      super.widget.nestOrNestItem,
      false,
      true,
    );
    printInfo("Similar items: ${response["items"]}");
    if (response.containsKey("items")) {
      MagpiePhotoAlert.displayPhotoAlert(
        context,
        "Similar item(s) found",
        "It seems like you could already have this item in one of your nests.",
        ["Cancel", "View similar", "Add anyways"],
        [cancel(), showSimilarItems(), callAddAnyways()],
      );
    } else {
      onChange("");
    }
  }

  VoidCallback cancel() => () => Navigator.of(context).pop();

  VoidCallback showSimilarItems() {
    return () => Navigator.of(context).pop();
  }

  VoidCallback callAddAnyways() {
    return () async => await _addAnyways().then(onChange);
  }

  Future<VoidCallback> _addAnyways() async {
    await ApiEndpoints.uploadNestOrNestItem(
            super.widget.nestOrNestItem, false, true,
            compare: false)
        .then(onChange);
    return () {};
  }
}
