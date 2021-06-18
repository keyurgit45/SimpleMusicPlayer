import 'dart:io';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_circular_slider/flutter_circular_slider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicui/constants/constants.dart';
import 'package:musicui/widgets/modalbottomsheet.dart';

class MyMusicPlayer extends StatefulWidget {
  // SongInfo songInfo;
  int currentIndex;
  List<SongInfo> songs;
  UniqueKey key;
  MyMusicPlayer(
      {required this.currentIndex, required this.songs, required this.key})
      : super(key: key);

  @override
  MyMusicPlayerState createState() => MyMusicPlayerState(currentIndex, songs);
}

class MyMusicPlayerState extends State<MyMusicPlayer> {
  MyMusicPlayerState(this.currentIndex, this.songs);

  late int currentIndex;
  late List<SongInfo> songs;
  double minimumValue = 0.0, maximumValue = 1.0, currentValue = 0.0;
  String currentTime = '', endTime = '';
  bool isPlaying = false;
  late int currentVolume;
  bool isRepeatOn = false;
  final AudioPlayer player = AudioPlayer();

  void setSong(SongInfo songInfo) async {
    // widget.songs[widget.currentIndex] = songInfo;
    currentVolume = player.volume.toInt() * 10;
    print(currentVolume);
    await player.setUrl(songInfo.uri);
    currentValue = minimumValue;
    maximumValue = player.duration!.inMilliseconds.toDouble();
    setState(() {
      currentTime = getDuration(currentValue);
      endTime = getDuration(maximumValue);
    });
    isPlaying = false;
    changeStatus();
    // player.setLoopMode(LoopMode.one);
    // player.setLoopMode(LoopMode.off);

    player.positionStream.listen((duration) async {
      currentValue = duration.inMilliseconds.toDouble();
      if (currentValue >= maximumValue) {
        currentValue = 0.0;
        await player.stop();

        changeTrack(true, currentIndex);
      }
      if (mounted) {
        setState(() {
          currentTime = getDuration(currentValue);
        });
      }
    });
  }

  String getDuration(double value) {
    Duration duration = Duration(milliseconds: value.round());

    return [duration.inMinutes, duration.inSeconds]
        .map((element) => element.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }

  void changeStatus() {
    setState(() {
      isPlaying = !isPlaying;
    });
    if (isPlaying) {
      player.play();
    } else {
      player.pause();
    }
  }

  void changeTrack(bool isNext, int index) {
    if (isNext) {
      if (index != songs.length - 1) {
        currentIndex++;
      } else if (index == songs.length - 1) {
        currentIndex = 0;
      }
    } else {
      if (index != 0) {
        currentIndex--;
      }
    }

    setSong(songs[currentIndex]);
    print("total" + songs.length.toString());
    print("current index after changing song" + currentIndex.toString());
    setState(() {});
    // await player.setVolume(1.0);
    // key.currentState!.setSong(songs[currentIndex]);
  }

  void initState() {
    super.initState();
    setSong(songs[currentIndex]);
  }

  void dispose() {
    super.dispose();
    player.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print("current index " + currentIndex.toString());
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        centerTitle: true,
        title: Text("Music"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // CircleAvatar(
            //   backgroundImage: NetworkImage(
            //       RecentlyPlayed().recents[currentIndex]['imgurl'].toString()),
            //   radius: 130,
            // ),

            SingleCircularSlider(
              10,
              player.volume.toInt() * 10,
              selectionColor: Colors.red,
              baseColor: Colors.black,
              handlerColor: Colors.red,
              showHandlerOutter: false,
              handlerOutterRadius: 0,
              sliderStrokeWidth: 1.5,
              shouldCountLaps: false,
              onSelectionChange: (a, b, c) {
                // print(b);
                player.setVolume(b / 10);
              },
              child: CircleAvatar(
                radius: 130,
                backgroundImage:
                    AssetImage(Constants().images[currentIndex % 7]),
              ),
            ),

            SizedBox(
              height: 40,
            ),
            Center(
              child: AutoSizeText(
                songs[currentIndex].title,
                maxLines: 3,
                maxFontSize: 30,
                textAlign: TextAlign.center,
                style: GoogleFonts.lato(fontSize: 30),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Center(
              child: AutoSizeText(songs[currentIndex].artist,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  maxFontSize: 15,
                  style: GoogleFonts.openSans(fontSize: 18)),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(currentTime),
                Slider(
                    min: minimumValue,
                    max: maximumValue,
                    activeColor: Colors.white,
                    inactiveColor: Colors.grey,
                    value: currentValue,
                    onChanged: (newval) {
                      setState(() {
                        currentValue = newval;
                        player
                            .seek(Duration(milliseconds: currentValue.round()));
                      });
                    }),
                Text(endTime.toString())
              ],
            ),
            SizedBox(
              height: 30,
            ),
            bottomControls(),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              child: Icon(Icons.music_note_outlined),
              onTap: () =>
                  // print("Enjoy")
                  MyBottomSheet().mybottomsheet(context, currentIndex, songs),
            )
          ],
        ),
      ),
    );
  }

  Widget bottomControls() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(Icons.shuffle),
        InkWell(
          onTap: () => changeTrack(false, currentIndex),
          child: Icon(
            Icons.arrow_back,
            color: Colors.red,
            size: 35,
          ),
        ),
        InkWell(
          child: Icon(
              isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
              color: Colors.red,
              size: 50),
          onTap: changeStatus,
        ),
        InkWell(
          onTap: () => changeTrack(true, currentIndex),
          child: Icon(
            Icons.arrow_forward,
            color: Colors.red,
            size: 35,
          ),
        ),
        InkWell(
            child: Icon(
              Icons.repeat,
              color: isRepeatOn ? Colors.red[800] : Colors.white,
            ),
            onTap: () {
              isRepeatOn = !isRepeatOn;
              setState(() {});
              print("hey");
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: Duration(seconds: 1),
                  content:
                      Text(isRepeatOn ? "Repeat Mode On" : "Repeat Mode Off")));
            }),
      ],
    );
  }
}
