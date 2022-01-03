import 'package:flutter/material.dart';

abstract class NestOrNestItemCreation extends StatefulWidget {
  const NestOrNestItemCreation({Key? key}) : super(key: key);

  @override
  NestOrNestItemCreationState createState() => NestOrNestItemCreationState();
}

class NestOrNestItemCreationState<T extends NestOrNestItemCreation> extends State<T> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}