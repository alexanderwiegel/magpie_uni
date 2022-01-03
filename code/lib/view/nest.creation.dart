import 'package:flutter/material.dart';

import '../view/nest.or.nest.item.creation.dart';

class NestCreation extends NestOrNestItemCreation {
  const NestCreation({Key? key}) : super(key: key);

  @override
  _NestCreationState createState() => _NestCreationState();
}

class _NestCreationState extends NestOrNestItemCreationState<NestCreation> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
