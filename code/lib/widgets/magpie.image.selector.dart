import 'package:flutter/material.dart';

class MagpieImageSelector extends StatelessWidget {
  final dynamic photo;

  const MagpieImageSelector({
    Key? key,
    @required this.photo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {},
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Material(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          child: Image.asset(
            "pics/placeholder.jpg",
            fit: BoxFit.cover,
            width: 400,
            height: 250,
          ),
        ),
      ),
    );
  }
}
