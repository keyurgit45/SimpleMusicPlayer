import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:musicui/constants/recents.dart';

import 'mymusicplayer.dart';

class MusicTracks extends StatefulWidget {
  const MusicTracks({Key? key}) : super(key: key);

  @override
  _MusicTracksState createState() => _MusicTracksState();
}

class _MusicTracksState extends State<MusicTracks> {
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  List<SongInfo> songs = [];
  int currentIndex = 0;

  void getTracks() async {
    songs = await audioQuery.getSongs();
    setState(() {
      songs = songs;
    });
  }

  void initState() {
    super.initState();
    getTracks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text("Your Music"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            ListView.builder(
                shrinkWrap: true,
                itemCount: songs.length,
                itemBuilder: (context, e) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, right: 10.0, bottom: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        currentIndex = e;
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => MyMusicPlayer(
                                  songs: songs,

                                  // changeTrack: changeTrack,
                                  // songInfo: songs[currentIndex],
                                  key: UniqueKey(), currentIndex: currentIndex,
                                )));
                      },
                      child: Container(
                        height: 60,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  if (songs[e].albumArtwork != null)
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image(
                                        height: 55,
                                        width: 55,
                                        fit: BoxFit.fill,
                                        image: FileImage(
                                            File(songs[e].albumArtwork)),
                                      ),
                                    )
                                  else
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        RecentlyPlayed()
                                            .recents[e % 2]['imgurl']
                                            .toString(),
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
                                      Text(songs[e].title.toString()),
                                      // SizedBox(
                                      //   height: 5,
                                      // ),
                                      Text(songs[e].artist.toString())
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            // Row(
                            //   children: [
                            //     Text("3"),
                            //     Icon(
                            //       Icons.star,
                            //       color: Colors.yellow,
                            //     ),
                            //     SizedBox(
                            //       width: 20,
                            //     ),
                            //     Icon(
                            //       Icons.drag_indicator,
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
