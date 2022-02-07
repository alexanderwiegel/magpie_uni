import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

// import 'magpie.checkbox.dart';
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
    String thing = isNest ? "nest" : "nest item";
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          children: <Widget>[
            MagpieImageSelector(
              photo: photo,
              changeImage: changeImage,
              context: context,
            ),
            // MagpieFormField.name(
            //     labelText: "Name *",
            //     validator: (value) =>
            //     value!.isEmpty ? "Please give your $thing a name" : null,
            //     name: thing,
            //     onChanged: (name) => {},
            //     hintText: "Give your $thing a name"
            // ),
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
              visible: !isNest,
              child: MagpieFormField(
                enabled: true,
                icon: Icons.euro_symbol,
                labelText: "Worth (optional)",
                // initialValue: ,
                controller: worthEditingController,
                inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                keyboardType: TextInputType.number,
              ),
            ),
            // MagpieCheckbox(public: public),
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
    );
  }
}
