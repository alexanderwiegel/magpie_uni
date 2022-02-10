import 'dart:async';
// import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:magpie_uni/model/feedsModel.dart';
import 'package:magpie_uni/network/user_api_manager.dart';
import 'package:magpie_uni/services/apiEndpoints.dart';
import 'package:magpie_uni/widgets/feedListItem.dart';
// import 'package:http/http.dart' as http;

// Future<FeedResponse> fetchFeeds(int loggedUserId) async {
//   var headers = UserAPIManager().getAPIHeader();
//   print(
//     Uri.parse(ApiEndpoints.urlPrefix + 'feed/getFeeds?userId=$loggedUserId'),
//   );
//   final response = await http.get(
//       Uri.parse(ApiEndpoints.urlPrefix + 'feed/getFeeds?userId=$loggedUserId'),
//       headers: headers);

//   if (response.statusCode == 200) {
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     print(response.body);
//     return FeedResponse.fromJson(jsonDecode(response.body));
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load Feeds');
//   }
// }

class FeedList extends StatefulWidget {
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
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const <Widget>[
                Text(
                  "Feeds",
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
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
                    return ListView.builder(
                      itemCount: snapshot.data!.feeds.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 10),
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return FeedListItem(
                          feed: snapshot.data!.feeds[index],
                        );
                      },
                    );
                  } else {
                    return Container(
                      padding: EdgeInsets.only(top: 20),
                      child: Center(
                        child: Text(
                          "No Feeds Available.",
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
                  padding: EdgeInsets.only(top: 20),
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
