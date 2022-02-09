import 'package:flutter/material.dart';

import 'package:magpie_uni/model/nest.or.nest.item.dart';
import 'package:magpie_uni/widgets/magpie.button.dart';
import 'package:magpie_uni/widgets/magpie.photo.alert.dart';
import 'package:magpie_uni/widgets/magpie.form.dart';
import 'package:magpie_uni/widgets/magpie.icon.button.dart';
import 'package:magpie_uni/widgets/magpie.delete.dialog.dart';

abstract class NestOrNestItemFormScreen extends StatefulWidget {
  NestOrNestItem nestOrNestItem;

  NestOrNestItemFormScreen({Key? key, required this.nestOrNestItem})
      : super(key: key);

  @override
  NestOrNestItemFormScreenState createState() =>
      NestOrNestItemFormScreenState();
}

class NestOrNestItemFormScreenState<T extends NestOrNestItemFormScreen>
    extends State<T> {
  //#region fields
  final MagpieDeleteDialog _magpieDeleteDialog = MagpieDeleteDialog();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late dynamic _photo;
  late String _name;
  late String _description;
  late int _worth;
  late bool _public;

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
    _photo = widget.nestOrNestItem.photo;
    _name = widget.nestOrNestItem.name;
    _description = widget.nestOrNestItem.description;
    _worth = widget.nestOrNestItem.worth;
    _public = widget.nestOrNestItem.public;
    _nameEditingController = TextEditingController(text: _name);
    _descriptionEditingController = TextEditingController(text: _description);
    _worthEditingController = TextEditingController(text: _worth.toString());
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
    String _thing = _isNest ? "nest" : "nest item";
    return Scaffold(
      appBar: AppBar(
        title: Text(_isNew ? "New " + _thing : _name),
        actions: [
          MagpieIconButton(
            icon: Icons.save,
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                if (_photo != null) {
                  await uploadNestOrNestItem();
                  print("Upload finished. Now pop screen.");
                  Navigator.of(context).pop();
                } else {
                  MagpiePhotoAlert.displayPhotoAlert(context);
                }
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
        createdAt: widget.nestOrNestItem.createdAt ?? DateTime.now(),
        changeImage: _changeImage,
        setPublic: _setPublic,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: getDeleteButton(_isNew, _thing),
    );
  }

  void _changeImage(dynamic image) {
    // TODO: will always be true because the timestamp will always change
    // print("Old photo: $_photo");
    if (_photo != image) setState(() => _photo = image);
  }

  void _setPublic(value) {
    if (_public != value) setState(() => _public = value);
  }

  Future<void> uploadNestOrNestItem() async {
    widget.nestOrNestItem.photo = _photo;
    widget.nestOrNestItem.name = _nameEditingController.text;
    widget.nestOrNestItem.description = _descriptionEditingController.text;
    widget.nestOrNestItem.worth = _worthEditingController.text.isEmpty
        ? 0
        : int.parse(_worthEditingController.text);
    widget.nestOrNestItem.public = _public;
    print("Successfully set attributes");
  }
}
