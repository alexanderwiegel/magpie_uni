import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

import 'package:magpie_uni/size.config.dart';
import 'package:magpie_uni/widgets/magpie.form.field.dart';
import 'package:magpie_uni/widgets/magpie.image.selector.dart';
import 'package:magpie_uni/widgets/magpie.switch.dart';

class MagpieForm extends StatelessWidget {
  //#region fields and constructor
  final GlobalKey? formKey;
  final bool isNew;
  final bool isNest;
  final dynamic photo;
  final Function changeImage;
  final Function setPublic;
  final int worth;
  final bool public;
  final DateTime? createdAt;
  final TextEditingController nameEditingController;
  final TextEditingController descriptionEditingController;
  final TextEditingController worthEditingController;

  const MagpieForm({
    Key? key,
    required this.formKey,
    required this.isNew,
    required this.isNest,
    required this.photo,
    required this.changeImage,
    required this.setPublic,
    this.worth = 0,
    required this.public,
    required this.createdAt,
    required this.nameEditingController,
    required this.descriptionEditingController,
    required this.worthEditingController,
  }) : super(key: key);

  static final DateFormat formatter = DateFormat("dd.MM.yyyy");

  //#endregion

  @override
  Widget build(BuildContext context) {
    String thing = isNest ? "nest" : "nest item";
    return Center(
      child: SizedBox(
        width: min(SizeConfig.screenWidth, 600),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                MagpieImageSelector(
                  photo: photo,
                  changeImage: changeImage,
                  context: context,
                ),
                MagpieFormField(
                  icon: Icons.title,
                  labelText: "Name *",
                  hintText: "Give your $thing a name",
                  controller: nameEditingController,
                  validate: (value) =>
                      value.isEmpty ? "Please give your $thing a name" : null,
                ),
                MagpieFormField(
                  icon: Icons.speaker_notes,
                  labelText: "Description (optional)",
                  border: const OutlineInputBorder(),
                  controller: descriptionEditingController,
                ),
                Visibility(
                  // if it is a nest, only show the worth if it is not new,
                  // if it is a nest item, always show it
                  visible: isNest ? !isNew : true,
                  child: MagpieFormField(
                    enabled: !isNest,
                    icon: Icons.euro_symbol,
                    labelText: "Worth (optional)",
                    // initialValue: ,
                    controller: worthEditingController,
                    inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                    keyboardType: TextInputType.number,
                  ),
                ),
                MagpieSwitch(public: public, setPublic: setPublic),
                MagpieFormField(
                  enabled: false,
                  icon: Icons.date_range,
                  labelText: "Created at",
                  initialValue: formatter.format(createdAt!),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
