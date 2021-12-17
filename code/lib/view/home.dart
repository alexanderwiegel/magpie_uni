import 'package:flutter/material.dart';

import 'package:magpie_uni/widgets/magpie.bottom.navigation.bar.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Overview"),
      ),
      bottomNavigationBar: MagpieBottomNavigationBar(),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}