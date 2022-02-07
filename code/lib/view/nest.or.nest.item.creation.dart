import 'package:flutter/material.dart';

import '../widgets/magpie.form.dart';
import '../widgets/magpie.icon.button.dart';

abstract class NestOrNestItemCreation extends StatefulWidget {
  const NestOrNestItemCreation({Key? key}) : super(key: key);

  @override
  NestOrNestItemCreationState createState() => NestOrNestItemCreationState();
}

class NestOrNestItemCreationState<T extends NestOrNestItemCreation> extends State<T> {
  //final _formKey = GlobalKey<FormState>();

  dynamic _photo;
  String? _name;
  String? _description;
  bool? _public;
  final DateTime _createdAt = DateTime.now();

  late TextEditingController _nameEditingController;
  late TextEditingController _descriptionEditingController;

  @override
  void dispose() {
    _nameEditingController.dispose();
    _descriptionEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _nameEditingController = TextEditingController(text: _name);
    _descriptionEditingController = TextEditingController(text: _description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TODO: display respective thing
        title: const Text("New XXX"),
        actions: [
          MagpieIconButton(
              icon: Icons.save,
              onPressed: () => Navigator.of(context).pop(),
              tooltip: "Save")
        ],
      ),
      body: MagpieForm(
        //formKey: _formKey,
        photo: _photo,
        createdAt: _createdAt,
        nameEditingController: _nameEditingController,
        descriptionEditingController: _descriptionEditingController,
        changePhoto: () => {},
      ),
    );
  }
}