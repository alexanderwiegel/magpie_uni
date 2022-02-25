import 'dart:async';
import 'package:flutter/material.dart';

import 'package:magpie_uni/model/feeds.model.dart';
import 'package:magpie_uni/network/user_api_manager.dart';
import 'package:magpie_uni/services/api.endpoints.dart';
import 'package:magpie_uni/size.config.dart';
import 'package:magpie_uni/widgets/feed.list.item.dart';
import 'package:magpie_uni/widgets/magpie.drawer.dart';

class FeedList extends StatefulWidget {
  const FeedList({Key? key}) : super(key: key);

  @override
  _FeedListState createState() => _FeedListState();
}

class _FeedListState extends State<FeedList> {
  late Future<FeedResponse> fetchFeed;

  @override
  void initState() {
    super.initState();
    fetchFeed = ApiEndpoints.fetchFeeds(UserAPIManager.currentUserId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      drawer: const MagpieDrawer(),
      appBar: AppBar(
        title: Text(
          "Feeds",
          style: TextStyle(fontSize: SizeConfig.iconSize / 1.75),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FutureBuilder<FeedResponse>(
              future: fetchFeed,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.feeds.isNotEmpty) {
                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: SizeConfig.isTablet ? 3 : 1,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 8,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) =>
                          FeedListItem(feed: snapshot.data!.feeds[index]),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.feeds.length,
                    );
                  } else {
                    return Container(
                      padding: const EdgeInsets.only(top: 20),
                      child: Center(
                        child: Text(
                          "No feeds available.",
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: SizeConfig.iconSize / 1.75,
                          ),
                        ),
                      ),
                    );
                  }
                } else if (snapshot.hasError) {
                  return Text('${snapshot.error}');
                }
                // By default, show a loading spinner.
                return Container(
                  padding: const EdgeInsets.only(top: 20),
                  child: const Center(child: CircularProgressIndicator()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
