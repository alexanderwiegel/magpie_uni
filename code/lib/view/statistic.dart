import 'package:flutter/material.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'package:magpie_uni/model/feed.user.profile.model.dart';
import 'package:magpie_uni/network/user_api_manager.dart';
import 'package:magpie_uni/services/api.endpoints.dart';
import 'package:magpie_uni/widgets/magpie.drawer.dart';
import 'package:magpie_uni/size.config.dart';
import 'package:magpie_uni/constants.dart';

//ignore: must_be_immutable
class Statistic extends StatelessWidget {
  //#region fields
  Statistic({Key? key}) : super(key: key);

  late double smallTitleSize = 0;
  late double bigTitleSize = 0;
  late double radius = 0;

  final List<Color> colors = [
    Colors.blue,
    Colors.yellow,
    Colors.red,
    Colors.green,
    Colors.orange,
  ];

  late FeedUserProfileResponse user;
  late List<TimeSeriesData> timeSeries;
  late List<CircularSegmentEntry> entries;
  late List<Widget> descriptions;
  late List<CircularStackEntry> circularData;

  //#endregion

  void initEntries() {
    user = UserAPIManager.currentUserProfile;

    //#region Time series chart
    timeSeries = [];
    List<Stats>? stats = user.profile.stats!;
    double sum = 0;
    for (int i = stats.length - 1; i >= 0; i--) {
      sum += stats[i].count;
      timeSeries.add(TimeSeriesData(sum, stats[i].date));
    }
    //#endregion

    //#region Nest shares
    final nests = user.nests;
    final nestItems = user.nestItems;

    // Fill the dictionary with the nests and the amount of nest items
    Map<String, int> dict = {};
    for (var nest in nests) {
      dict[nest.title] = 0;
      for (var item in nestItems) {
        if (item.nestId == nest.id) {
          dict[nest.title] = dict[nest.title]! + 1;
        }
      }
    }

    // Sort the dictionary from biggest to smallest nests
    var sortedKeys = dict.keys.toList(growable: false)
      ..sort((k1, k2) => dict[k2]!.compareTo(dict[k1]!));

    Map<String, int> sortedDict = {};
    int othersCount = 0;
    for (var key in sortedKeys) {
      if (sortedDict.keys.length < 4) {
        sortedDict[key] = dict[key]!;
      } else {
        othersCount += dict[key]!;
      }
    }
    if (sortedKeys.length > 4) {
      sortedDict["Others"] = othersCount;
    }

    entries = [];
    int count = 0;
    for (var key in sortedDict.keys) {
      if (sortedDict[key]! > 0) {
        entries.add(CircularSegmentEntry(
          sortedDict[key]!.toDouble(),
          colors[count++],
          rankKey: key,
        ));
      }
    }

    descriptions = [];
    for (int i = 0; i < entries.length; i++) {
      // TODO: remove the "%5" after summing up the rest in "Others"
      descriptions.add(description(i % 5));
    }
    //#endregion

    //#region Size config
    if (SizeConfig.isTablet) {
      smallTitleSize = SizeConfig.hori * 2;
      bigTitleSize = SizeConfig.hori * 3;
      radius = SizeConfig.vert * 15;
    } else {
      smallTitleSize = SizeConfig.hori * 4;
      bigTitleSize = SizeConfig.hori * 5;
      radius = SizeConfig.hori * 30;
    }
    //#endregion
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MagpieDrawer(),
      appBar: AppBar(
        title: const Text("Statistic"),
      ),
      body: FutureBuilder(
        future: ApiEndpoints.getUserProfile(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            initEntries();
            return Container(
              color: textColor,
              child: StaggeredGrid.count(
                crossAxisCount: 8,
                children: <Widget>[
                  StaggeredGridTile.extent(
                    crossAxisCellCount: 8,
                    mainAxisExtent:
                        SizeConfig.vert * (SizeConfig.isTablet ? 50 : 40),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: nestsOverTimeChart(
                          "since the beginning", "collected items"),
                    ),
                  ),
                  if (user.profile.nestItemCount > 0)
                    StaggeredGridTile.extent(
                      crossAxisCellCount: SizeConfig.isTablet ? 5 : 8,
                      mainAxisExtent:
                          SizeConfig.vert * (SizeConfig.isTablet ? 40 : 30),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: nestShares("Items", "per nest"),
                      ),
                    ),
                  StaggeredGridTile.extent(
                    crossAxisCellCount: SizeConfig.isTablet ? 3 : 4,
                    mainAxisExtent:
                        SizeConfig.vert * (SizeConfig.isTablet ? 20 : 15),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: total("Nests"),
                    ),
                  ),
                  StaggeredGridTile.extent(
                    crossAxisCellCount: SizeConfig.isTablet ? 3 : 4,
                    mainAxisExtent:
                        SizeConfig.vert * (SizeConfig.isTablet ? 20 : 15),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: total("Nest items"),
                    ),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Material nestsOverTimeChart(String title, String subtitle) {
    return Material(
      color: textColor,
      elevation: 14,
      borderRadius: BorderRadius.circular(24),
      shadowColor: mainColor,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: smallTitleSize, color: mainColor),
            ),
            Text(
              subtitle,
              style: TextStyle(fontSize: bigTitleSize),
            ),
            const Padding(padding: EdgeInsets.symmetric(vertical: 8)),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: charts.TimeSeriesChart(
                  [
                    charts.Series<TimeSeriesData, DateTime>(
                      id: "",
                      data: timeSeries,
                      domainFn: (TimeSeriesData tsd, _) => tsd.date!,
                      measureFn: (TimeSeriesData tsd, _) => tsd.count,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Material nestShares(String title, String subtitle) {
    return Material(
      color: textColor,
      elevation: 14,
      borderRadius: BorderRadius.circular(24),
      shadowColor: mainColor,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(fontSize: smallTitleSize, color: mainColor),
                ),
                Text(
                  subtitle,
                  style: TextStyle(fontSize: bigTitleSize),
                ),
                AnimatedCircularChart(
                  size: SizeConfig.isTablet
                      ? Size(radius * 1.75, radius * 1.75)
                      : Size(radius, radius),
                  initialChartData: <CircularStackEntry>[
                    CircularStackEntry(entries, rankKey: "Nest shares"),
                  ],
                  chartType: CircularChartType.Pie,
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: descriptions,
              mainAxisAlignment: MainAxisAlignment.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget description(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            radius: 9,
            backgroundColor: colors[index],
          ),
          const Padding(padding: EdgeInsets.symmetric(horizontal: 5)),
          Text(
            entries[index].rankKey,
            style: const TextStyle(fontSize: 17),
          )
        ],
      ),
    );
  }

  Material total(String title) {
    return Material(
      color: textColor,
      elevation: 14,
      borderRadius: BorderRadius.circular(24),
      shadowColor: mainColor,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(fontSize: smallTitleSize, color: mainColor),
            ),
            Text(
              title == "Nests"
                  ? user.profile.nestCount.toString()
                  : user.profile.nestItemCount.toString(),
              style: TextStyle(fontSize: bigTitleSize),
            ),
          ],
        ),
      ),
    );
  }
}

class TimeSeriesData {
  final double? count;
  final DateTime? date;

  TimeSeriesData(this.count, this.date);
}
