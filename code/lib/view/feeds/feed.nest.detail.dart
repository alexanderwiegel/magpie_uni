import 'package:flutter/material.dart';
import 'package:magpie_uni/network/user_api_manager.dart';
import 'package:magpie_uni/view/chat/chat.detail.page.dart';
import 'package:magpie_uni/model/chat.session.model.dart';
import 'package:magpie_uni/services/api.endpoints.dart';
import 'package:magpie_uni/constants.dart';

import '../../model/feed.user.nestitems.model.dart';
import '../../model/feed.user.profile.model.dart';
import '../../widgets/nest.grid.item.dart';

class FeedNestDetail extends StatefulWidget {
  final FeedNest nest;

  const FeedNestDetail({Key? key, required this.nest}) : super(key: key);

  @override
  _FeedNestDetailState createState() => _FeedNestDetailState();
}

class _FeedNestDetailState extends State<FeedNestDetail> {
  List<FeedNestItem> nestItems = [];

  @override
  void initState() {
    super.initState();
    fetchFeedUserNestItems();
  }

  Future<void> fetchFeedUserNestItems() async {
    FeedUserNestItemsResponse result =
    await ApiEndpoints.fetchFeedUserNestItems(widget.nest.id);
    setState(() {
      nestItems = result.nestItems!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 5, right: 16, top: 10, bottom: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                const Center(
                  child: Text(
                    "Nest Detail",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(0, 0, 0, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: NetworkImage(widget.nest.getImage()),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5),
            const Padding(
              padding: EdgeInsets.fromLTRB(8, 10, 8, 2),
              child: Text(
                "Title:",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 2, 8, 2),
              child: Text(
                widget.nest.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.fromLTRB(8, 5, 8, 2),
              child: Text(
                "Description:",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 2, 8, 15),
              child: Text(
                widget.nest.description,
                style:
                    const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(

              padding: const EdgeInsets.all(15.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15, vertical: 20),
                  child: Column(
                    children: [
                      const Text(
                        "Nest Items",
                        style: TextStyle(
                          color: mainColor,
                          fontSize: 25,
                        ),
                      ),
                      const Divider(thickness: 1.5),
                      Container(
                        padding:
                        const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: GridView.builder(
                          physics:
                          const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.0,
                            mainAxisSpacing: 5.0,
                            crossAxisSpacing: 5.0,
                          ),
                          itemCount: nestItems.length,
                          itemBuilder: (context, index) {
                            var nestItem = nestItems[index];
                            return NestGridItem(
                              nest: null,
                              nestItem: nestItem,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: mainColor,
        child: const Icon(Icons.chat_outlined),
        onPressed: () => floatingBtnPressed(),
      ),
    );
  }

  Future<void> floatingBtnPressed() async {
    NewChatSessionResponse response = await ApiEndpoints.fetchUserChatSession(
      UserAPIManager.currentUserId,
      widget.nest.userId,
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatDetailPage(
          chatSession: response.chat,
          onBackPressed: (value) => print(value),
        ),
      ),
    );
  }
}
