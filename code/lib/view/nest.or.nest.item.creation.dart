import 'dart:collection';
import 'package:http_parser/http_parser.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  dynamic _photo;
  String? _name;
  String _description = "";
  int? _worth;
  bool _public = false;
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
    _nameEditingController = TextEditingController(text: _name);
    _descriptionEditingController = TextEditingController(text: _description);
    _worthEditingController =
        TextEditingController(text: _worth != null ? "$_worth" : "");
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
                if (_photo != null)
                  addNestOrNestItem(context);
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
        createdAt: _createdAt,
        changeImage: _changeImage,
        setPublic: _setPublic,
      ),
    );
  }

  void _changeImage(dynamic image) {
    if (_photo != image) setState(() => _photo = image);
  }

  void _setPublic(value) {
    if (_public != value) setState(() => _public = value);
  }

  Future<bool> addNestOrNestItem(BuildContext context) async {
    String url = "http://10.0.2.2:3000/nest/addNest";
    dynamic nestOrNestItem;
    if (context.toString().contains("NestItem")) {
      url += "Item";
      nestOrNestItem = NestItem();
      nestOrNestItem.worth = _worthEditingController.text.isEmpty
          ? 0
          : int.parse(_worthEditingController.text);
    } else {
      nestOrNestItem = Nest();
    }
    nestOrNestItem.photo = _photo;
    nestOrNestItem.name = _nameEditingController.text;
    nestOrNestItem.description = _descriptionEditingController.text;
    nestOrNestItem.public = _public;
    nestOrNestItem.createdAt = DateTime.now();
    // nestOrNestItem = nestOrNestItem.toMap();

    String token =
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoxLCJpYXQiOjE2NDQwNzA4NzYsImV4cCI6MTY0NDA3NDQ3Nn0.JvlRQCLTH2bUAcx1RJVNW10_KQMccWAnlyNapW-9kfM";
    Map<String, String> headers = new HashMap();
    headers['Accept'] = 'application/json';
    headers['Content-type'] = 'application/json';
    headers['Authorization'] = "Bearer " + token;
    var req = http.MultipartRequest('POST', Uri.parse(url));
    headers.forEach((key, value) {
      req.headers[key] = value;
    });
    // nestOrNestItem.forEach((key, value) {
    //   req.fields[key] = value;
    // });
    req.fields["user_id"] = "1";
    req.fields["title"] = "Vinyl";
    req.fields["description"] = "";
    req.files.add(await http.MultipartFile.fromPath('image', _photo.path,
        contentType: MediaType('image', 'jpg')
        // contentType: MediaType('application', 'x-tar')
        ));
    print(_photo.path);
    var response = await req.send();
    print(response);
    return (response.statusCode == 200) ? true : false;
    // final response =
    //     await http.post(Uri.parse(url), headers: headers, body: nestOrNestItem);
    // return response.statusCode == 200 ? json.decode(response.body) : null;
  }
}
