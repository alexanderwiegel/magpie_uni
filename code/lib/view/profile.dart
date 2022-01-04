import 'package:flutter/material.dart';

import 'package:magpie_uni/widgets/magpie.bottom.navigation.bar.dart';

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