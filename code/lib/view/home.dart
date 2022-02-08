import 'package:flutter/material.dart';
import 'package:magpie_uni/widgets/magpie.drawer.dart';

import '../Constants.dart' as Constants;
import '../view/nest.creation.dart';
import '../widgets/magpie.bottom.navigation.bar.dart';
import '../widgets/magpie.grid.view.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool hasData = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MagpieDrawer(),
      appBar: AppBar(
        title: const Text("Home"),
      ),
      body: hasData
          ? Center(
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
        backgroundColor: Constants.mainColor,
        child: const Icon(Icons.add),
        onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const NestCreation())),
      ),
    );
  }
}
