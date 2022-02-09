import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:magpie_uni/size.config.dart';
import 'package:magpie_uni/view/auth/login/login.page.dart';
import 'package:magpie_uni/view/home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    SizeConfig.isTablet
        ? SystemChrome.setPreferredOrientations(
            [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight])
        : SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    // TODO: if already logged in, go to Home, if not, go to Login
    return Home();
  }
}
