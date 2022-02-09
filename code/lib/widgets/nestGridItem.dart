import 'package:flutter/material.dart';
import 'package:magpie_uni/model/feedUserProfileModel.dart';
import 'package:magpie_uni/view/feeds/feedItemDetailPage.dart';

class NestGridItem extends StatefulWidget {
  FeedNest? nest;
  NestItem? nestItem;
  NestGridItem({
    required this.nest,
    required this.nestItem,
  });
  @override
  _NestGridItemState createState() => _NestGridItemState();
}

class _NestGridItemState extends State<NestGridItem> {
  var photo =
      "https://www.froben11.de/wp-content/uploads/2016/10/orionthemes-placeholder-image.png";
  @override
  void initState() {
    super.initState();
    photo = this.widget.nest != null
        ? this.widget.nest!.getImage()
        : this.widget.nestItem!.getImage();
    this.setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 2.0,
      child: Container(
        child: Stack(
          fit: StackFit.expand,
          children: [
            GestureDetector(
              onTap: () {
                print("Item Tapped");
                if (this.widget.nest != null) {
                } else {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return FeedItemDetail(
                      feed: null,
                      nestItem: this.widget.nestItem!,
                    );
                  }));
                }
              },
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  borderRadius: BorderRadius.circular(10.0),
                  image: DecorationImage(
                    fit: BoxFit.fitHeight,
                    image: NetworkImage(this.photo),
                  ),
                ),
              ),
            ),
            //
            Padding(
              padding: const EdgeInsets.fromLTRB(2, 0, 2, 5),
              child: Container(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    this.widget.nest != null
                        ? this.widget.nest!.title
                        : this.widget.nestItem!.title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
