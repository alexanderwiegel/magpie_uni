import 'package:flutter/material.dart';

import 'package:magpie_uni/model/nest.or.nest.item.dart';
import 'package:magpie_uni/size.config.dart';
import 'package:magpie_uni/widgets/magpie.button.dart';
import 'package:magpie_uni/widgets/magpie.photo.alert.dart';
import 'package:magpie_uni/widgets/magpie.form.dart';
import 'package:magpie_uni/widgets/magpie.icon.button.dart';
import 'package:magpie_uni/widgets/magpie.delete.dialog.dart';

//ignore: must_be_immutable
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
  late int _worth = 0;
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
    _public = widget.nestOrNestItem.public ?? false;
    _nameEditingController = TextEditingController(text: _name);
    _descriptionEditingController = TextEditingController(text: _description);
    _worthEditingController = TextEditingController(text: _worth.toString());
  }

  // TODO: make this responsive
  Widget getDeleteButton(bool isNew, bool isNest, String thing) {
    return isNew
        ? Container()
        : MagpieButton(
            onPressed: () => _magpieDeleteDialog.displayDeleteDialog(
              context,
              isNest,
              getIdOfNestOrNestItem(),
            ),
            title: "Delete $thing",
            icon: Icons.delete,
          );
  }

  int getIdOfNestOrNestItem() => throw UnimplementedError();

  @override
  Widget build(BuildContext context) {
    String ctx = context.toString();
    bool _isNest = !ctx.contains("NestItem");
    bool _isNew = ctx.contains("Creation");
    String _thing = _isNest ? "nest" : "nest item";
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isNew ? "New " + _thing : _name,
          style: TextStyle(fontSize: SizeConfig.iconSize / 1.75),
        ),
        actions: [
          MagpieIconButton(
            icon: Icons.save,
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                _photo != null
                    ? await uploadNestOrNestItem()
                    : MagpiePhotoAlert.displayPhotoAlert(
                        context,
                        "No image provided",
                        "You must use your own image.",
                        ["OK"],
                        [() => Navigator.of(context).pop()],
                      );
              }
            },
            tooltip: "Save",
          ),
        ],
      ),
      body: MagpieForm(
        formKey: _formKey,
        isNew: _isNew,
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
      floatingActionButton: getDeleteButton(_isNew, _isNest, _thing),
    );
  }

  onChange(dynamic value) {
    setState(() {});
    Navigator.of(context).pop();
  }

  void _changeImage(dynamic image) {
    // TODO: will always be true because the timestamp will always change
    //print("Old photo: $_photo");
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
  }
}
