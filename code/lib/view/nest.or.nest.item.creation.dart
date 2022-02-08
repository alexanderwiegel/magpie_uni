import 'package:flutter/material.dart';

import 'package:magpie_uni/model/nest.or.nest.item.dart';
import 'package:magpie_uni/widgets/magpie.photo.alert.dart';
import 'package:magpie_uni/model/nest.dart';
import 'package:magpie_uni/model/nest.item.dart';
import 'package:magpie_uni/widgets/magpie.form.dart';
import 'package:magpie_uni/widgets/magpie.icon.button.dart';

abstract class NestOrNestItemCreation extends StatefulWidget {
  const NestOrNestItemCreation({Key? key}) : super(key: key);

  @override
  NestOrNestItemCreationState createState() => NestOrNestItemCreationState();
}

class NestOrNestItemCreationState<T extends NestOrNestItemCreation>
    extends State<T> {
  //#region fields
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late NestOrNestItem nestOrNestItem;
  dynamic photo;
  String? name;
  String description = "";
  int? worth;
  bool public = false;
  final DateTime _createdAt = DateTime.now();

  late TextEditingController _nameEditingController;
  late TextEditingController _descriptionEditingController;
  late TextEditingController _worthEditingController;

  //#endregion

  @override
  void dispose() {
    _nameEditingController.dispose();
    _descriptionEditingController.dispose();
    _worthEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _nameEditingController = TextEditingController(text: name);
    _descriptionEditingController = TextEditingController(text: description);
    _worthEditingController =
        TextEditingController(text: worth != null ? "$worth" : "");
  }

  @override
  Widget build(BuildContext context) {
    bool _isNest = !context.toString().contains("NestItem");
    String name = _isNest ? "nest" : "nest item";
    return Scaffold(
      appBar: AppBar(
        title: Text("New " + name),
        actions: [
          MagpieIconButton(
            icon: Icons.save,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (photo != null)
                  addNestOrNestItem();
                else
                  MagpiePhotoAlert.displayPhotoAlert(context);
              }
            },
            tooltip: "Save",
          ),
        ],
      ),
      body: MagpieForm(
        formKey: _formKey,
        isNest: _isNest,
        photo: photo,
        nameEditingController: _nameEditingController,
        descriptionEditingController: _descriptionEditingController,
        worthEditingController: _worthEditingController,
        public: public,
        createdAt: _createdAt,
        changeImage: _changeImage,
        setPublic: _setPublic,
      ),
    );
  }

  void _changeImage(dynamic image) {
    if (photo != image) setState(() => photo = image);
  }

  void _setPublic(value) {
    if (public != value) setState(() => public = value);
  }

  Future<void> addNestOrNestItem() async {
    nestOrNestItem.photo = photo;
    nestOrNestItem.name = _nameEditingController.text;
    nestOrNestItem.description = _descriptionEditingController.text;
    nestOrNestItem.worth = _worthEditingController.text.isEmpty
        ? 0
        : int.parse(_worthEditingController.text);
    nestOrNestItem.public = public;
    nestOrNestItem.createdAt = DateTime.now();
    print("Successfully set attributes");
  }
}
