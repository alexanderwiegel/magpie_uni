import 'package:flutter/material.dart';

import 'package:magpie_uni/model/nest.dart';
import 'package:magpie_uni/model/nest.item.dart';
import 'package:magpie_uni/view/nest.item.creation.dart';
import 'package:magpie_uni/widgets/magpie.bottom.navigation.bar.dart';
import 'package:magpie_uni/widgets/magpie.grid.view.dart';

import 'nest.detail.screen.dart';

class NestItemsScreen extends StatefulWidget {
  Nest nest;

  NestItemsScreen({required this.nest});

  @override
  _NestItemsScreenState createState() => _NestItemsScreenState();
}

class _NestItemsScreenState extends State<NestItemsScreen> {
  Icon _searchIcon = Icon(
    Icons.search,
    color: Colors.white,
  );
  final TextEditingController _filter = new TextEditingController();
  String _searchText = "";
  List<NestItem> _names = [];
  List<NestItem> _filteredNames = [];
  Widget _searchTitle = Text("");

  @override
  initState() {
    super.initState();
    // _initiateNest();
    // _buildNestItemsScreen();
  }

  _NestItemsScreenState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          _filteredNames = _names;
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  // Future<void> _initiateNest() async {
  //   widget.nest = await DatabaseHelper.instance.getNest(widget.nest.id);
  // }

  void _fillList(snapshot) {
    _names =
        List.generate(snapshot.data.length, (index) => snapshot.data[index]);
    _filteredNames = _names;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.nest.name!),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            tooltip: "Bearbeiten",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NestDetailScreen(nest: widget.nest)),
              );
            },
          ),
        ],
      ),
      // TODO: call API here
      body:
          // FutureBuilder<List<NestItem>>(
          //   future: db.getNestItemsScreen(widget.nest),
          //   builder: (context, snapshot) {
          //     if (!snapshot.hasData)
          true == true
              ? Center(
                  child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("You don't have any nest items."),
                    Text("Click on the button"),
                    Text("to create your first nest item."),
                  ],
                ))
              // _fillList(snapshot);
              : MagpieGridView(
                  filteredNames: _filteredNames,
                  isNest: false,
                  searchText: _searchText,
                ),
      //   },
      // ),
      bottomNavigationBar: MagpieBottomNavigationBar(
        searchPressed: _searchPressed,
        showFavorites: _showFavorites,
        switchSortOrder: _switchSortOrder,
        sortMode: widget.nest.sortMode,
        asc: widget.nest.asc,
        onlyFavored: widget.nest.onlyFavored,
        searchIcon: _searchIcon,
        searchTitle: _searchTitle,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        tooltip: "Create new nest item",
        onPressed: () {
          _openNestCreator();
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void _switchSortOrder(result) async {
    if (widget.nest.sortMode != result) {
      setState(() {
        widget.nest.asc = true;
        widget.nest.sortMode = result;
      });
    } else {
      setState(() {
        widget.nest.asc = !widget.nest.asc;
      });
    }
    // TODO: call update nest API
    // DatabaseHelper.instance.update(widget.nest);
  }

  void _showFavorites() {
    setState(() {
      widget.nest.onlyFavored ^= true;
    });
    // TODO: call update nest API
    // DatabaseHelper.instance.update(widget.nest);
  }

  void _searchPressed() {
    setState(() {
      if (this._searchIcon.icon == Icons.search) {
        this._searchIcon = new Icon(Icons.close);
        this._searchTitle = new TextField(
            style: TextStyle(color: Colors.white),
            controller: _filter,
            decoration: new InputDecoration(
              hintText: 'Search...',
              hintStyle: TextStyle(color: Colors.white),
            ));
      } else {
        this._searchIcon = new Icon(Icons.search);
        this._searchTitle = new Text('');
        _filteredNames = _names;
        _filter.clear();
      }
    });
  }

  Future _openNestCreator() async {
    await Navigator.of(context).push(MaterialPageRoute<Nest>(
        builder: (BuildContext context) {
          return NestItemCreation();
        },
        fullscreenDialog: true));
    setState(() {});
  }

// Future<List<Future<NestItem>>> _buildNestItemsScreen() async {
//   return List.generate(
//       await DatabaseHelper.instance.getNestItemCount(widget.nest.id),
//           (int index) => DatabaseHelper.instance.getNestItem(index));
// }
}
