import 'package:flutter/material.dart';

// import 'package:magpie_uni/model/user.dart';
// import 'package:magpie_uni/services/api.endpoints.dart';
// import 'package:magpie_uni/sort.mode.dart';
// import 'package:magpie_uni/widgets/magpie.bottom.navigation.bar.dart';
import 'package:magpie_uni/main.dart';
import 'package:magpie_uni/model/nest.or.nest.item.dart';
import 'package:magpie_uni/view/nest.or.nest.item.form.screen.dart';
import 'package:magpie_uni/widgets/magpie.drawer.dart';
import 'package:magpie_uni/constants.dart';
import 'package:magpie_uni/widgets/magpie.grid.view.dart';

abstract class HomeOrNestItemsScreen extends StatefulWidget {
  const HomeOrNestItemsScreen({Key? key}) : super(key: key);

  @override
  State<HomeOrNestItemsScreen> createState() => HomeOrNestItemsScreenState();
}

class HomeOrNestItemsScreenState<T extends HomeOrNestItemsScreen>
    extends State<T> with RouteAware {
  String title = "";

  // SortMode _sortMode = SortMode.sortById;
  // bool _asc = true;
  // bool _onlyFavored = false;

  List<NestOrNestItem> _names = [];
  List<NestOrNestItem> _filteredNames = [];
  final TextEditingController _filter = TextEditingController();
  Icon _searchIcon = const Icon(Icons.search, color: Colors.white);
  Widget searchText = const Text("");
  String _searchText = "";

  HomeOrNestItemsScreenState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          _filteredNames = _names;
        });
      } else {
        setState(() => _searchText = _filter.text);
      }
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      routeObserver.subscribe(this, ModalRoute.of(context)!);
    });
    // _initUser();
    super.initState();
  }

  @override
  void didPopNext() {
    printSuccess("In didPopNext()");
    setState(() {});
    super.didPopNext();
  }

  // Future<void> _initUser() async {
  //   User user = await ApiEndpoints.getHomeScreen();
  //   setState(() {
  //     _sortMode = user.sortMode;
  //     _asc = user.asc;
  //     _onlyFavored = user.onlyFavored;
  //   });
  // }

  void _fillList(snapshot) {
    _names =
        List.generate(snapshot.data.length, (index) => snapshot.data[index]);
    _filteredNames = _names;
  }

  void setTitle(String title) => this.title = title;

  Future<List> getNestsOrNestItems() async => throw UnimplementedError();

  Widget editButton() => Container();

  NestOrNestItemFormScreen openCreationScreen() => throw UnimplementedError();

  Widget searchBar() => IconButton(
        color: textColor,
        // TODO: change this according to nest/nestItem
        tooltip: "Search",
        padding: const EdgeInsets.only(left: 12.0),
        alignment: Alignment.centerLeft,
        icon: _searchIcon,
        iconSize: 30.0,
        onPressed: _searchPressed,
      );

  @override
  Widget build(BuildContext context) {
    bool isNest = context.toString().contains("Home");
    String thing = isNest ? "nest" : "nest item";
    return Scaffold(
      drawer: const MagpieDrawer(),
      appBar: AppBar(
        title: Text(title),
        actions: [
          _searchIcon.icon == Icons.search
              ? editButton()
              : Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 60.0),
                      child: searchText,
                    ),
                  ),
                ),
          searchBar(),
        ],
      ),
      body: FutureBuilder<List>(
        future: getNestsOrNestItems(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            _fillList(snapshot);
            return MagpieGridView(
              filteredNames: _filteredNames,
              isNest: isNest,
              searchText: _searchText,
            );
          } else {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("You don't have any " + thing + "s."),
                  const Text("Click on the button"),
                  const Text("to create your first nest."),
                ],
              ),
            );
          }
        },
      ),
      // bottomNavigationBar: MagpieBottomNavigationBar(
      //   searchPressed: _searchPressed,
      //   showFavorites: _showFavorites,
      //   switchSortOrder: _switchSortOrder,
      //   sortMode: _sortMode,
      //   asc: _asc,
      //   onlyFavored: _onlyFavored,
      //   searchIcon: _searchIcon,
      //   searchTitle: _searchTitle,
      // ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: FloatingActionButton(
          tooltip: "Create new $thing",
          backgroundColor: mainColor,
          child: const Icon(Icons.add),
          onPressed: () async => await Navigator.of(context)
              .push(
                  MaterialPageRoute(builder: (context) => openCreationScreen()))
              .then(onChange),
        ),
      ),
    );
  }

  onChange(dynamic value) => setState(() {});

  // void _switchSortOrder(SortMode result) async {
  //   if (_sortMode != result) {
  //     setState(() {
  //       _asc = true;
  //       _sortMode = result;
  //     });
  //   } else {
  //     setState(() => _asc ^= true);
  //   }
  //   // TODO: call setState() ?
  //   await ApiEndpoints.updateHomeScreen(_sortMode.name, _asc, _onlyFavored);
  // }
  //
  // void _showFavorites() async {
  //   setState(() => _onlyFavored ^= true);
  //   // TODO: call setState() ?
  //   await ApiEndpoints.updateHomeScreen(_sortMode.name, _asc, _onlyFavored);
  // }
  //
  void _searchPressed() {
    setState(() {
      if (_searchIcon.icon == Icons.search) {
        _searchIcon = const Icon(Icons.close, color: Colors.white);
        searchText = TextField(
          style: const TextStyle(color: textColor, fontSize: 20),
          controller: _filter,
          textAlignVertical: TextAlignVertical.center,
          decoration: const InputDecoration(
            hintText: 'Search...',
            hintStyle: TextStyle(color: Colors.white),
            border: InputBorder.none,
          ),
        );
      } else {
        _searchIcon = const Icon(Icons.search, color: Colors.white);
        searchText = const Text('');
        _filteredNames = _names;
        _filter.clear();
      }
    });
  }
}
