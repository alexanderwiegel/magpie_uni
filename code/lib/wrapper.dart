import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:magpie_uni/view/home.dart';

import 'size.config.dart';
import 'view/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    SizeConfig.isTablet
        ? SystemChrome.setPreferredOrientations(
            [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight])
        : SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return HomeScreen();
  }
}
