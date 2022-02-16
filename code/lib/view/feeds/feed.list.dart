import 'dart:async';
import 'package:flutter/material.dart';

import 'package:magpie_uni/model/feeds.model.dart';
import 'package:magpie_uni/network/user_api_manager.dart';
import 'package:magpie_uni/services/api.endpoints.dart';
import 'package:magpie_uni/widgets/feed.list.item.dart';

import '../../widgets/magpie.drawer.dart';

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
        title: const Text("Feeds"),
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
                    return ListView.builder(
                      itemCount: snapshot.data!.feeds.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.only(top: 10),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return FeedListItem(
                          feed: snapshot.data!.feeds[index],
                        );
                      },
                    );
                  } else {
                    return Container(
                      padding: const EdgeInsets.only(top: 20),
                      child: const Center(
                        child: Text(
                          "No feeds available.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15.0,
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
