import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter_circular_chart/flutter_circular_chart.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:magpie_uni/services/apiEndpoints.dart';

import 'package:magpie_uni/widgets/magpie.drawer.dart';
import 'package:magpie_uni/size.config.dart';
import 'package:magpie_uni/Constants.dart' as Constants;

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

  late List<CircularSegmentEntry> entries;
  late List<Widget> descriptions;
  late List<CircularStackEntry> circularData;

  //#endregion

  void initEntries() {
    entries = [
      CircularSegmentEntry(20, colors[0], rankKey: "Vinyl"),
      CircularSegmentEntry(10, colors[1], rankKey: "Bottle caps"),
      CircularSegmentEntry(8, colors[2], rankKey: "Stamps"),
      CircularSegmentEntry(7, colors[3], rankKey: "City magnets"),
      CircularSegmentEntry(5, colors[4], rankKey: "Others"),
    ];
    descriptions = [];
    for (int i = 0; i < 5; i++)
      descriptions.add(
        description(i),
      );
    if (SizeConfig.isTablet) {
      smallTitleSize = SizeConfig.hori * 2;
      bigTitleSize = SizeConfig.hori * 3;
      radius = SizeConfig.vert * 15;
    } else {
      smallTitleSize = SizeConfig.hori * 4;
      bigTitleSize = SizeConfig.hori * 5;
      radius = SizeConfig.hori * 30;
    }
  }

  @override
  Widget build(BuildContext context) {
    initEntries();
    return Scaffold(
      drawer: MagpieDrawer(),
      appBar: AppBar(
        title: Text("Statistic"),
      ),
      body: Container(
        color: Constants.textColor,
        child: StaggeredGrid.count(
          crossAxisCount: 8,
          children: <Widget>[
            StaggeredGridTile.extent(
              crossAxisCellCount: 8,
              mainAxisExtent: SizeConfig.vert * (SizeConfig.isTablet ? 50 : 40),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: nestsOverTimeChart(
                    "since the beginning", "collected items"),
              ),
            ),
            StaggeredGridTile.extent(
              crossAxisCellCount: SizeConfig.isTablet ? 5 : 8,
              mainAxisExtent: SizeConfig.vert * (SizeConfig.isTablet ? 40 : 30),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: nestShares("Items", "per nest"),
              ),
            ),
            StaggeredGridTile.extent(
              crossAxisCellCount: SizeConfig.isTablet ? 3 : 4,
              mainAxisExtent: SizeConfig.vert * (SizeConfig.isTablet ? 20 : 15),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: total("Nests"),
              ),
            ),
            StaggeredGridTile.extent(
              crossAxisCellCount: SizeConfig.isTablet ? 3 : 4,
              mainAxisExtent: SizeConfig.vert * (SizeConfig.isTablet ? 20 : 15),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: total("Items"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Material nestsOverTimeChart(String title, String subtitle) {
    return Material(
      color: Constants.textColor,
      elevation: 14,
      borderRadius: BorderRadius.circular(24),
      shadowColor: Constants.mainColor,
      child: Padding(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                  fontSize: smallTitleSize, color: Constants.mainColor),
            ),
            Text(
              subtitle,
              style: TextStyle(fontSize: bigTitleSize),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: charts.TimeSeriesChart(
                  [
                    charts.Series<TimeSeriesData, DateTime>(
                        id: "",
                        data: [
                          TimeSeriesData(
                            count: 5,
                            date: DateTime(2022, 1, 15),
                          ),
                          TimeSeriesData(
                            count: 12,
                            date: DateTime(2022, 1, 20),
                          ),
                          TimeSeriesData(
                            count: 20,
                            date: DateTime(2022, 1, 25),
                          ),
                          TimeSeriesData(
                            count: 30,
                            date: DateTime(2022, 1, 29),
                          ),
                          TimeSeriesData(
                            count: 50,
                            date: DateTime(2022, 2, 3),
                          ),
                        ],
                        domainFn: (TimeSeriesData tsd, _) => tsd.date!,
                        measureFn: (TimeSeriesData tsd, _) => tsd.count),
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
      color: Constants.textColor,
      elevation: 14,
      borderRadius: BorderRadius.circular(24),
      shadowColor: Constants.mainColor,
      child: Row(
        children: <Widget>[
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  title,
                  style: TextStyle(
                      fontSize: smallTitleSize, color: Constants.mainColor),
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
                    chartType: CircularChartType.Pie),
              ],
            ),
          ),
          Expanded(
            child: Column(
                children: descriptions,
                mainAxisAlignment: MainAxisAlignment.center),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
          ),
          Text(
            entries[index].rankKey,
            style: TextStyle(fontSize: 15),
          )
        ],
      ),
    );
  }

  Material total(String title) {
    return Material(
      color: Constants.textColor,
      elevation: 14,
      borderRadius: BorderRadius.circular(24),
      shadowColor: Constants.mainColor,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                  fontSize: smallTitleSize, color: Constants.mainColor),
            ),
            FutureBuilder(
              future: ApiEndpoints.getUserProfile(),
              builder: (context, snapshot) {
                List counts = snapshot.data as List;
                return Text(
                  snapshot.hasData
                      ? title == "Nests"
                          ? counts[0].toString()
                          : counts[1].toString()
                      : "?",
                  style: TextStyle(fontSize: bigTitleSize),
                );
              },
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

  TimeSeriesData({this.count, this.date});
}
