import 'package:flutter/material.dart';
import 'package:musicui/constants/recents.dart';

class ListViewWidget extends StatelessWidget {
  const ListViewWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: RecentlyPlayed().recents.length,
        itemBuilder: (context, e) {
          return Padding(
            padding:
                const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 20.0),
            child: Container(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          RecentlyPlayed().recents[e]['imgurl'].toString(),
                          height: 50,
                          width: 50,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(RecentlyPlayed().recents[e]['title'].toString()),
                          SizedBox(
                            height: 5,
                          ),
                          Text(RecentlyPlayed()
                              .recents[e]['subtitle']
                              .toString())
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      // Text(RecentlyPlayed().recents[e]['stars'].toString()),
                      // Icon(
                      //   Icons.star,
                      //   color: Colors.yellow,
                      // ),
                      SizedBox(
                        width: 20,
                      ),
                      Icon(
                        Icons.music_note,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
