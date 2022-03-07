import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grey_wall/audio.dart';
import 'package:grey_wall/logic/favorite_bloc/favorite_bloc.dart';
import 'package:grey_wall/logic/notify_bloc/notify_bloc.dart';
import 'package:grey_wall/main.dart';
import 'package:grey_wall/screens/player_screen.dart';

import 'package:grey_wall/tab_view.dart';

import 'package:grey_wall/temp.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';

import '../screens/home_screen.dart';

class SongWidget extends StatelessWidget {
  SongWidget({
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
    this.removeFav,
    this.removeSong,
    required this.audioList,
  }) : super(key: key);

  final QueryArtworkWidget? qrwdgt;
  final String songName;
  final String artistName;

  final SongModel song;
  final bool isPlaylist;
  final bool isfav;
  final bool isInFav;
  final int index;
  final List<FavoritesEntity>? favorites;
  final List<Audio> audioList;
  final VoidCallback? removeFav;
  final VoidCallback? removeSong;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
          BlocBuilder<NotifyBloc, bool>(
            builder: (context, state) {
              return GestureDetector(
                onTap: () async {
print("898 the notification is $state");
                  audioplayer1
                      .open(
                          Playlist(
                            audios: audioList,
                            startIndex: index,
                          ),
                          autoStart: true,
                          notificationSettings: const NotificationSettings(
                            stopEnabled: false,
                            seekBarEnabled: true,
                          ),
                          showNotification: state)
                      .then((value) {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PlayerScreen()));
                  });
                  print("the index of music playing should be ");
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
                      child: qrwdgt ?? const Icon(Icons.music_note),
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
                          height: 18,
                          child: Text(
                            songName,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Container(
                          width: 200,
                          height: 18,
                          child: Text(
                            artistName,
                            style: const TextStyle(fontWeight: FontWeight.w400),
                          ),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                                child: Column(
                              children: [
                                TextButton(
                                  onPressed: () {
                                    isfav ? removeFav!() : addFav(context);

                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                      isfav
                                          ? "remove from favorite"
                                          : "add to favorite",
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500,
                                          color:
                                              Theme.of(context).primaryColor)),
                                ),
                                const Divider(
                                  color: Colors.black,
                                  thickness: 2,
                                ),
                                TextButton(
                                  onPressed: () {
                                    // _askedToLead();
                                    isPlaylist
                                        ? removeSong!()
                                        : showInformationDialog4(
                                            context, songName);
                                    // Navigator.of(context).pop();
                                  },
                                  child: Text(
                                      isPlaylist
                                          ? "remove from the playlist"
                                          : "add to playlist",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color:
                                              Theme.of(context).primaryColor)),
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
              );
            },
          ),
        ],
      ),
    );
  }

  removeFromPlaylist() {}

  addFav(BuildContext context) {
    audioRoom1.addTo(
      RoomType.FAVORITES,
      song.getMap.toFavoritesEntity(),
      ignoreDuplicate: false,
    );
    hiveCtrl.initializeFavorite();
    BlocProvider.of<FavoriteBloc>(context).add(FavoriteEvent.load());
  }

  addSong() {
    // audioRoom1.addTo(
    //   RoomType.PLAYLIST,
    // song.getMap.toFavoritesEntity(),
    //   ignoreDuplicate: false,
    //   playlistKey: widget.,
    // );
    HomeScreen();
  }
}
