import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'magpie.checkbox.dart';
import 'magpie.form.field.dart';
import 'magpie.image.selector.dart';
import 'magpie.switch.dart';

class MagpieForm extends StatelessWidget {
  //final GlobalKey? formKey;
  dynamic photo;
  int worth;
  late bool? public;
  final DateTime? createdAt;
  final TextEditingController? nameEditingController;
  final TextEditingController? descriptionEditingController;
  final TextEditingController? worthEditingController;
  final Function? changePhoto;

  MagpieForm({
    Key? key,
    //@required this.formKey,
    @required this.photo,
    this.worth = 0,
    this.public = false,
    @required this.createdAt,
    @required this.nameEditingController,
    @required this.descriptionEditingController,
    this.worthEditingController,
    @required this.changePhoto,
  }) : super(key: key);

  static final DateFormat formatter = DateFormat("dd.MM.yyyy");

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        //key: formKey,
        child: Column(
          children: <Widget>[
            MagpieImageSelector(photo: photo),
            // MagpieTextFormField(
            //   leadingIcon: Icons.title,
            //   labelText: "Name *",
            //   // TODO: display respective thing
            //   hintText: "Give your XXX a name",
            //   controller: nameEditingController,
            //   onChanged: (name) => {},
            //   validate: (value) =>
            //       value.isEmpty ? "Please give your XXX a name" : null,
            // ),
            // MagpieTextFormField(
            //   leadingIcon: Icons.speaker_notes,
            //   labelText: "Description (optional)",
            //   border: const OutlineInputBorder(),
            //   controller: descriptionEditingController,
            //   onChanged: (value) => {},
            // ),
            // Visibility(
            //     // TODO: use bool worthVisible
            //     visible: true,
            //     child: MagpieTextFormField(
            //       // TODO: use bool isNest or do something else
            //       enabled: true,
            //       leadingIcon: Icons.euro_symbol,
            //       // TODO: make labelText depend on bool isNest
            //       labelText: "Worth (optional)",
            //       // initialValue: ,
            //       controller: worthEditingController,
            //       // TODO: fix this
            //       inputFormatter: [FilteringTextInputFormatter.digitsOnly],
            //       keyboardType: TextInputType.number,
            //       onChanged: (value) => {},
            //     )),
            MagpieCheckbox(public: public),
            MagpieSwitch(public: public),
            // MagpieTextFormField(
            //   enabled: false,
            //   leadingIcon: Icons.date_range,
            //   labelText: "Created at",
            //   onChanged: (value) => {},
            //   initialValue: formatter.format(createdAt!),
            // ),
          ],
        ),
      ),
    );
  }
}
