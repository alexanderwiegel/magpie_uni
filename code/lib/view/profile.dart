import 'package:flutter/material.dart';

import '../view/nest.creation.dart';
import '../widgets/magpie.bottom.navigation.bar.dart';
import '../constants.dart' as constants;

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      bottomNavigationBar: const MagpieBottomNavigationBar(),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}