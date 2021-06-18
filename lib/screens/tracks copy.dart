import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:musicui/constants/constants.dart';

import 'mymusicplayer.dart';

class MusicTracks extends StatefulWidget {
  const MusicTracks({Key? key}) : super(key: key);

  @override
  _MusicTracksState createState() => _MusicTracksState();
}

class _MusicTracksState extends State<MusicTracks> {
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  bool isLoading = true;
  int currentIndex = 0;
  List<SongInfo> songs = [];
  List<SongInfo> songslist = [];
  final ScrollController _scrollController = ScrollController();

  void getTracks() async {
    songs = await audioQuery.getSongs();
    songslist = songs;
    print(songs.length);
    songs.removeWhere((element) =>
        (element.title.contains('+') | element.title.contains('@')));

    print(songs.length);

    setState(() {
      isLoading = false;
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
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: Colors.red,
                ),
              )
            : BuildListView(
                scrollController: _scrollController,
                songs: songs,
                currentIndex: currentIndex));
  }
}

class BuildListView extends StatelessWidget {
  const BuildListView({
    Key? key,
    required ScrollController scrollController,
    required this.songs,
    required this.currentIndex,
  })  : _scrollController = scrollController,
        super(key: key);

  final ScrollController _scrollController;
  final List<SongInfo> songs;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      controller: _scrollController,
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
                    // currentIndex = e;
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => MyMusicPlayer(
                              songs: songs,
                              key: UniqueKey(),
                              currentIndex: e,
                            )));
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(songs[e].title.toString().length > 60
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
  }
}
