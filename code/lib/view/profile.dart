import 'package:flutter/material.dart';

import '../constants.dart' as constants;
import '../view/nest.creation.dart';
import '../widgets/magpie.bottom.navigation.bar.dart';
import '../widgets/magpie.grid.view.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool hasData = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: hasData ? Center(
    child: Column(
    mainAxisSize: MainAxisSize.min,
      children: const <Widget>[
        Text("You don't have any nests."),
        Text("Click on the button"),
        Text("to create your first nest."),
      ],
    ))
          : const MagpieGridView(),
      bottomNavigationBar: const MagpieBottomNavigationBar(),
      floatingActionButton: FloatingActionButton(
        tooltip: "Create new nest",
        backgroundColor: constants.mainColor,
        child: const Icon(Icons.add),
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => const NestCreation())),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}