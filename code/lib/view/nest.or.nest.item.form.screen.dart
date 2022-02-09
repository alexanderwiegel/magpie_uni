import 'package:flutter/material.dart';

import 'package:magpie_uni/model/nest.or.nest.item.dart';
import 'package:magpie_uni/widgets/magpie.photo.alert.dart';
import 'package:magpie_uni/widgets/magpie.form.dart';
import 'package:magpie_uni/widgets/magpie.icon.button.dart';
import 'package:magpie_uni/widgets/magpie.delete.dialog.dart';

abstract class NestOrNestItemFormScreen extends StatefulWidget {
  const NestOrNestItemFormScreen({Key? key}) : super(key: key);

  @override
  NestOrNestItemFormScreenState createState() => NestOrNestItemFormScreenState();
}

class NestOrNestItemFormScreenState<T extends NestOrNestItemFormScreen>
    extends State<T> {
  //#region fields
  MagpieDeleteDialog _magpieDeleteDialog = MagpieDeleteDialog();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late NestOrNestItem nestOrNestItem;
  dynamic _photo;
  String? _name;
  String _description = "";
  int? _worth;
  bool _public = false;

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
    _nameEditingController = TextEditingController(text: _name);
    _descriptionEditingController = TextEditingController(text: _description);
    _worthEditingController =
        TextEditingController(text: _worth != null ? "$_worth" : "");
  }

  Widget getDeleteButton(bool isNew, String thing) => isNew
      ? Container()
      : MagpieButton(
          onPressed: () => _magpieDeleteDialog.displayDeleteDialog(
              context, true, getIdOfNestOrNestItem()),
          title: "Delete $thing",
          icon: Icons.delete,
        );

  int getIdOfNestOrNestItem() => -1;

  @override
  Widget build(BuildContext context) {
    bool _isNest = !context.toString().contains("NestItem");
    bool _isNew = context.toString().contains("Creation");
    String thing = _isNest ? "nest" : "nest item";
    return Scaffold(
      appBar: AppBar(
        // TODO: check if this works
        title: Text(_isNew ? "New " + thing : _name!),
        actions: [
          MagpieIconButton(
            icon: Icons.save,
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                if (_photo != null)
                  uploadNestOrNestItem();
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
        photo: _photo,
        nameEditingController: _nameEditingController,
        descriptionEditingController: _descriptionEditingController,
        worthEditingController: _worthEditingController,
        public: _public,
        createdAt: nestOrNestItem.createdAt ?? DateTime.now(),
        changeImage: _changeImage,
        setPublic: _setPublic,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: getDeleteButton(_isNew, _thing),
    );
  }

  void _changeImage(dynamic image) {
    if (_photo != image) setState(() => _photo = image);
  }

  void _setPublic(value) {
    if (_public != value) setState(() => _public = value);
  }

  Future<void> uploadNestOrNestItem() async {
    nestOrNestItem.photo = _photo;
    nestOrNestItem.name = _nameEditingController.text;
    nestOrNestItem.description = _descriptionEditingController.text;
    nestOrNestItem.worth = _worthEditingController.text.isEmpty
        ? 0
        : int.parse(_worthEditingController.text);
    nestOrNestItem.public = _public;
    print("Successfully set attributes");
  }
}
