import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'magpie.form.field.dart';
import 'magpie.image.selector.dart';
import '../constants.dart' as constants;

class MagpieForm extends StatelessWidget {
  //final GlobalKey? formKey;
  final dynamic photo;
  final int worth;
  late final bool? public;
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
            MagpieImageSelector(photo: photo ),
            MagpieFormField(
              icon: Icons.title,
              labelText: "Name *",
              // TODO: display respective thing
              hintText: "Give your XXX a name",
              controller: nameEditingController,
              onChanged: () => {},
              validate: (value) => value.isEmpty ? "Please give your XXX a name" : null,
            ),
            MagpieFormField(
              icon: Icons.speaker_notes,
              labelText: "Description (optional)",
              border: const OutlineInputBorder(),
              controller: descriptionEditingController,
              onChanged: (value) => {},
            ),
            Visibility(
              // TODO: use bool worthVisible
              visible: true,
              child: MagpieFormField(
                // TODO: use bool isNest or do something else
                enabled: true,
                icon: Icons.euro_symbol,
                // TODO: make labelText depend on bool isNest
                labelText: "Worth (optional)",
                // initialValue: ,
                controller: worthEditingController,
                inputFormatter: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow("\d+")
                ],
                keyboardType: TextInputType.number,
                onChanged: (value) => {},
              )
            ),
            /*CheckboxListTile(
              value: public,
              onChanged: (value) => {},
              title: const Icon(Icons.public, color: constants.mainColor),
            ),*/
            MagpieFormField(
              enabled: false,
              icon: Icons.date_range,
              labelText: "Created at",
              initialValue: formatter.format(createdAt!),
            ),
          ],
        ),
      ),
    );
  }
}
