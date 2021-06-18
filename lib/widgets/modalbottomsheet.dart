import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_audio_query/flutter_audio_query.dart';

import 'package:musicui/constants/constants.dart';
import 'package:musicui/screens/mymusicplayer.dart';

class MyBottomSheet {
  ScrollController _controller = ScrollController();
  mybottomsheet(context, int currentIndex, List<SongInfo> songs) {
    return showModalBottomSheet(
        backgroundColor: Colors.black,
        context: context,
        builder: (context) {
          return Scrollbar(
            controller: _controller,
            child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: songs.length,
                itemBuilder: (context, e) {
                  return Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 10.0, bottom: 20.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          // Navigator.pop(context);
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MyMusicPlayer(
                                        songs: songs,
                                        key: UniqueKey(),
                                        currentIndex: e,
                                      )));
                          // currentIndex = e;
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => MyMusicPlayer(
                          //           songs: songs,
                          //           key: UniqueKey(),
                          //           currentIndex: e,
                          //         )));
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (context) => MyMusicPlayer(
                          //           songs: songs,
                          //           key: UniqueKey(),
                          //           currentIndex: e,
                          //         )));
                        },
                        child: Container(
                          height: 60,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.asset(
                                        Constants().images[e % 7].toString(),
                                        height: 55,
                                        width: 55,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(songs[e].title.toString().length >
                                                60
                                            ? songs[e]
                                                .title
                                                .toString()
                                                .substring(0, 60)
                                            : songs[e].title.toString()),
                                        // SizedBox(
                                        //   height: 5,
                                        // ),
                                        Text(songs[e].artist.toString())
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ));
                }),
          );
        });
  }
}
