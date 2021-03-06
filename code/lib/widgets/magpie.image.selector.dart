import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import 'package:magpie_uni/constants.dart';
import 'package:magpie_uni/size.config.dart';

class MagpieImageSelector extends StatelessWidget {
  //#region fields and constructor
  final dynamic photo;
  final Function changeImage;
  final BuildContext? context;

  MagpieImageSelector({
    Key? key,
    required this.photo,
    required this.changeImage,
    required this.context,
  }) : super(key: key);

  final Color color = mainColor;
  final double imageW = min(SizeConfig.screenWidth, 600);
  final double imageH = min(SizeConfig.screenWidth, 600) / 1.6;

  //#endregion

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _displayOptionsDialog(),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          child: photo != null
              ? photo.toString().startsWith("http")
                  ? Image.network(
                      photo,
                      fit: BoxFit.cover,
                      width: imageW,
                      height: imageH,
                    )
                  : Image.file(
                      File(photo),
                      fit: BoxFit.cover,
                      width: imageW,
                      height: imageH,
                    )
              : Image.asset(
                  "pics/placeholder.jpg",
                  fit: BoxFit.cover,
                  width: imageW,
                  height: imageH,
                ),
        ),
      ),
    );
  }

  void _displayOptionsDialog() async => await _optionsDialogBox();

  Future<void> _optionsDialogBox() {
    return showDialog(
      context: context!,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          contentPadding: const EdgeInsets.all(0),
          content: Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: color, width: SizeConfig.vert / 2),
            ),
            child: SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  option(
                    _imageSelectorCamera,
                    Icons.photo_camera,
                    ["Take a picture", "with your", "Camera"],
                  ),
                  line(),
                  option(
                    _imageSelectorGallery,
                    Icons.image,
                    ["Use a picture", "from your", "Gallery"],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget line() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: SizeConfig.hori),
      child: Container(
        height: SizeConfig.vert * 20,
        width: 1,
        color: Colors.grey,
      ),
    );
  }

  Widget option(VoidCallback onTap, IconData icon, List texts) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: GestureDetector(
          onTap: onTap,
          child: Column(
            children: [
              Icon(
                icon,
                color: color,
                size: SizeConfig.isTablet
                    ? SizeConfig.vert * 13
                    : SizeConfig.hori * 15,
              ),
              Column(
                children: <Widget>[
                  text(texts[0], 0),
                  text(texts[1], 1),
                  text(texts[2], 2),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Text text(String text, int index) {
    return Text(
      text,
      style: TextStyle(
        fontWeight: index == 2 ? FontWeight.bold : FontWeight.normal,
        fontSize:
            SizeConfig.isTablet ? SizeConfig.vert * 3 : SizeConfig.hori * 4,
      ),
    );
  }

  void _imageSelectorCamera() async => _imageSelector(ImageSource.camera);

  void _imageSelectorGallery() async => _imageSelector(ImageSource.gallery);

  void _imageSelector(ImageSource source) async {
    Navigator.pop(context!);
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile != null) {
      File? file = File(pickedFile.path);
      final targetDirectory = await getExternalStorageDirectory();
      var targetPath = targetDirectory.toString();
      targetPath =
          targetPath.substring(targetPath.indexOf("/"), targetPath.length - 1) +
              "/" +
              DateTime.now().toString() +
              ".jpg";
      file = await compressFile(file, targetPath);
      changeImage(file?.path);
    }
  }

  Future<File?> compressFile(File file, String targetPath) async {
    return await FlutterImageCompress.compressAndGetFile(
      file.path,
      targetPath,
      minWidth: 400,
      minHeight: 250,
      quality: 100,
    );
  }
}
