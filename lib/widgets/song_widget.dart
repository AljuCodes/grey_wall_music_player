

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grey_wall/audio.dart';
import 'package:grey_wall/main.dart';
import 'package:grey_wall/models/boxmodels.dart';
import 'package:grey_wall/screens/details_screen/albums_details_screen.dart';
import 'package:grey_wall/screens/favorites_screen.dart';
import 'package:grey_wall/screens/home_screen.dart';
import 'package:grey_wall/screens/player_screen.dart';
import 'package:grey_wall/screens/playlist_screen.dart';
import 'package:grey_wall/tab_view.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';

class songwidget extends StatefulWidget {
  songwidget({
    Key? key,
    this.qrwdgt,
    this.songName = "Lonely",
    this.artistName = "justin Bieber",
    this.isInFav = false,
    this.isPlaylist = false,
    this.isfav = false,
    this.index = 0,
    this.favorites,
     required this.song,
  }) : super(key: key);

  final QueryArtworkWidget? qrwdgt;
  final String songName;
  final String artistName;
  final List<FavoritesEntity>? favorites;
   final SongModel song;
  final bool isPlaylist;
  final bool isfav;
  final bool isInFav;
  final int index;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _textEditingController = TextEditingController();
  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _textEditingController,
                        validator: (value) {
                          return value!.isNotEmpty ? null : "Enter any text";
                        },
                        decoration:
                            const InputDecoration(hintText: "playlist Name"),
                      ),
                    ],
                  )),
              title: const Text('Create new playlist'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Do something like updating SharedPreferences or User Settings etc.
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => TabContainerBottom(
                                index1: 1,
                              )));
                    }
                  },
                  child: const Text('OK   '),
                ),
              ],
            );
          });
        });
  }

  ssss() {}
  @override
  State<songwidget> createState() => _songwidgetState();
}

class _songwidgetState extends State<songwidget> {
  @override
  Widget build(BuildContext context) {
    Future<void> _askedToLead() async {
      await showDialog(
          context: context,
          builder: (BuildContext context) {
            return SimpleDialog(
              title: const Text('Select a Playlist'),
              children: <Widget>[
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Tamil'),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('South'),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Rock'),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('pop'),
                ),
                SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Create new playlist'),
                ),
              ],
            );
          });
    }

    final width = MediaQuery.of(context).size.width;

    return Container(
      padding: const EdgeInsets.all(1),
      margin: const EdgeInsets.only(left: 10, right: 10, bottom: 20, top: 10),
      height: 100,
      decoration: const BoxDecoration(
          color: Color(0xffc4c5c5),
          borderRadius: BorderRadius.all(Radius.circular(20))),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              print("999");
              audioplayer1.playlistPlayAtIndex(widget.index);
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PlayerScreen()));
            },
            child: Row(
              children: [
                // the container of image of song
                Container(
                  margin: const EdgeInsets.only(left: 10),
                  height: 77,
                  width: 80,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(18))),
                  child: widget.qrwdgt ?? const Icon(Icons.music_note),
                ),

                SizedBox(
                  width: 20,
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 23,
                    ),
                    Container(
                      width: 200,
                      height: 25,
                      child: Text(
                        widget.songName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      widget.artistName,
                      style: const TextStyle(fontWeight: FontWeight.w300),
                    ),
                  ],
                ),

                Column(
                  children: [
                    const SizedBox(
                      height: 18,
                    ),
                    PopupMenuButton<int>(
                      padding: const EdgeInsets.all(0),
                      enableFeedback: true,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      itemBuilder: (context) => [
                        PopupMenuItem(
                            child: Column(
                          children: [
                            TextButton(
                              onPressed: () {
                                // setState(() {
                                //   widget.isfav == !widget.isfav;
                                // });
                                widget.isfav
                                    ? onPressedIsFav()
                                    : onPressedIsNotFav();

                                 Navigator.pop(context);
                              },
                              child: Text(
                                  widget.isfav
                                      ? "remove from favorite"
                                      : "add to favorite",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).primaryColor)),
                            ),
                            const Divider(
                              color: Colors.black,
                              thickness: 2,
                            ),
                            TextButton(
                              onPressed: () {
                                _askedToLead();
                                // Navigator.of(context).pop();
                              },
                              child: Text(
                                  widget.isPlaylist
                                      ? "remove from the playlist"
                                      : "add to playlist",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      color: Theme.of(context).primaryColor)),
                            ),
                          ],
                        ))
                      ],
                      color: Colors.white,
                      iconSize: 30,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  removeFromPlaylist() {}

  onPressedIsFav() {
    audioRoom1.deleteFrom(
      RoomType.FAVORITES,
      widget.favorites![widget.index].key,
    );

    FavoritesScreen();

    Navigator.of(context).pop();
  }

  onPressedIsNotFav() {
    audioRoom1.addTo(
      RoomType.FAVORITES,
      widget.song.getMap.toFavoritesEntity(),
      ignoreDuplicate: false,
    );
    HomeScreen();

    Navigator.of(context).pop();
  }
}