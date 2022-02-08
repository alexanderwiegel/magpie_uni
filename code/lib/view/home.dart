import 'package:flutter/material.dart';

import 'package:magpie_uni/model/nest.dart';
import 'package:magpie_uni/sort.mode.dart';
import 'package:magpie_uni/widgets/magpie.drawer.dart';
import 'package:magpie_uni/Constants.dart' as Constants;
import 'package:magpie_uni/view/nest.creation.dart';
import 'package:magpie_uni/widgets/magpie.bottom.navigation.bar.dart';
import 'package:magpie_uni/widgets/magpie.grid.view.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SortMode _sortMode = SortMode.SortById;
  bool _asc = true;
  bool _onlyFavored = false;

  final TextEditingController _filter = TextEditingController();
  List<Nest> _names = [];
  List<Nest> _filteredNames = [];
  Icon _searchIcon = Icon(Icons.search, color: Colors.white);
  Widget _searchTitle = Text("");
  String _searchText = "";

  bool hasData = false;

  _HomeState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          _filteredNames = _names;
        });
      } else
        setState(() => _searchText = _filter.text);
    });
  }

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
          : MagpieGridView(
              filteredNames: _filteredNames,
              isNest: true,
              searchText: _searchText,
            ),
      bottomNavigationBar: MagpieBottomNavigationBar(
        searchPressed: _searchPressed,
        showFavorites: _showFavorites,
        switchSortOrder: _switchSortOrder,
        sortMode: _sortMode,
        asc: _asc,
        onlyFavored: _onlyFavored,
        searchIcon: _searchIcon,
        searchTitle: _searchTitle,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        tooltip: "Create new nest",
        backgroundColor: Constants.mainColor,
        child: const Icon(Icons.add),
        onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const NestCreation())),
      ),
    );
  }

  void _switchSortOrder(SortMode result) {
    if (_sortMode != result) {
      setState(() {
        _asc = true;
        _sortMode = result;
      });
    } else
      setState(() => _asc ^= true);
    // TODO: call update home(?) API
    // DatabaseHelper.instance
    //     .updateHome(_asc, _onlyFavored, _sortMode, _getUserId());
  }

  void _showFavorites() {
    setState(() => _onlyFavored ^= true);
    // TODO: call update nest API
    // DatabaseHelper.instance
    //     .updateHome(_asc, _onlyFavored, _sortMode, _getUserId());
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = Icon(Icons.close, color: Colors.white);
        this._searchTitle = TextField(
            style: TextStyle(color: Constants.textColor),
            controller: _filter,
            decoration: InputDecoration(
              hintText: 'Search...',
              hintStyle: TextStyle(color: Colors.white),
            ));
      } else {
        this._searchIcon = Icon(Icons.search, color: Colors.white);
        this._searchTitle = Text('');
        _filteredNames = _names;
        _filter.clear();
      }
    });
  }
}
