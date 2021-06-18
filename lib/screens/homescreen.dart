import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:musicui/screens/mymusicplayer.dart';
import 'package:musicui/screens/tracks copy.dart';
import 'package:musicui/widgets/listviewwidget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          body: Container(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      child: Image.asset(
                        "assets/background.jpeg",
                        fit: BoxFit.cover,
                      ),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.vertical(
                              bottom: Radius.circular(19))),
                    ),
                    Positioned(
                      child: Text("Your Weekly\nMusic Mix",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold)),
                      left: 20,
                      bottom: 70,
                    ),
                    Positioned(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.deepOrange,
                          elevation: 1.0,
                          primary: Colors.white,
                        ),
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MusicTracks())),
                        child: Text("Listen"),
                      ),
                      left: 20,
                      bottom: 10,
                    )
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(top: 15.0, left: 15, bottom: 15),
                  child: Text(
                    "Recently Played",
                    style: GoogleFonts.openSans(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(child: ListViewWidget())
              ],
            ),
          )),
    );
  }
}
