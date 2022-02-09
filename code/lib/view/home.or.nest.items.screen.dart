import 'package:flutter/material.dart';

import 'package:magpie_uni/model/nest.dart';
import 'package:magpie_uni/services/apiEndpoints.dart';
import 'package:magpie_uni/sort.mode.dart';
import 'package:magpie_uni/view/nest.item.creation.dart';
import 'package:magpie_uni/widgets/magpie.drawer.dart';
import 'package:magpie_uni/Constants.dart' as Constants;
import 'package:magpie_uni/view/nest.creation.dart';
import 'package:magpie_uni/widgets/magpie.bottom.navigation.bar.dart';
import 'package:magpie_uni/widgets/magpie.grid.view.dart';

abstract class HomeOrNestItemsScreen extends StatefulWidget {
  @override
  State<HomeOrNestItemsScreen> createState() => HomeOrNestItemsScreenState();
}

class HomeOrNestItemsScreenState<T extends HomeOrNestItemsScreen>
    extends State<T> {
  String title = "";

  SortMode _sortMode = SortMode.SortById;
  bool _asc = true;
  bool _onlyFavored = false;

  List<Nest> _names = [];
  List<Nest> _filteredNames = [];
  final TextEditingController _filter = TextEditingController();
  Icon _searchIcon = Icon(Icons.search, color: Colors.white);
  Widget _searchTitle = Text("");
  String _searchText = "";

  HomeOrNestItemsScreenState() {
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

  void _fillList(snapshot) {
    _names =
        List.generate(snapshot.data.length, (index) => snapshot.data[index]);
    _filteredNames = _names;
  }

  void setTitle(String title) {
    this.title = title;
  }

  Future<List> getNestsOrNestItems() async {
    return [];
  }

  Widget editButton() => Container();

  @override
  Widget build(BuildContext context) {
    bool isNest = context.toString().contains("Home");
    String thing = isNest ? "nest" : "nest item";
    return Scaffold(
      drawer: MagpieDrawer(),
      appBar: AppBar(
        title: Text(title),
        actions: [editButton()],
      ),
      body: FutureBuilder<List>(
        future: getNestsOrNestItems(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.length > 0) {
            _fillList(snapshot);
            return MagpieGridView(
              filteredNames: _filteredNames,
              isNest: isNest,
              searchText: _searchText,
            );
          } else
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("You don't have any " + thing + "s."),
                  Text("Click on the button"),
                  Text("to create your first nest."),
                ],
              ),
            );
        },
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
        tooltip: "Create new $thing",
        backgroundColor: Constants.mainColor,
        child: const Icon(Icons.add),
        onPressed: () async {
          await Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  isNest ? NestCreation() : NestItemCreation()));
          setState(() {});
        },
      ),
    );
  }

  void _switchSortOrder(SortMode result) {
    if (_sortMode != result)
      setState(() {
        _asc = true;
        _sortMode = result;
      });
    else
      setState(() => _asc ^= true);
    // TODO: call update home(?) API
    // DatabaseHelper.instance
    //     .updateHome(_asc, _onlyFavored, _sortMode, _getUserId());
  }

  void _showFavorites() {
    setState(() => _onlyFavored ^= true);
    // TODO: call update home(?) API
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
          ),
        );
      } else {
        this._searchIcon = Icon(Icons.search, color: Colors.white);
        this._searchTitle = Text('');
        _filteredNames = _names;
        _filter.clear();
      }
    });
  }
}
