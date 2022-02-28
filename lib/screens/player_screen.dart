import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grey_wall/audio.dart';
import 'package:grey_wall/main.dart';
import 'package:grey_wall/screens/home_screen.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:grey_wall/common.dart';
import 'package:grey_wall/temp.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';

class PlayerScreen extends StatefulWidget {
  PlayerScreen({this.index = 0, this.lsSongModlel});
  int index;
  List<SongModel>? lsSongModlel;
  bool isFav = false;
  bool jj(PlayingAudio playingAudio) {
    OnAudioRoom()
        .queryFavorites(
      limit: 50,
      sortType: null,
    )
        .then((value) async {
      for (var song in value) {
        if (song.title == playingAudio.audio.metas.title) {
          print(
              "match found ${song.title} == ${playingAudio.audio.metas.title}");
          isFav = await OnAudioRoom().checkIn(RoomType.FAVORITES, song.key);
        }
      }
    });
    return isFav;
  }

//int index;
  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music & You'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            audioplayer1.builderCurrent(builder: (context, Playing? playing) {
              if (playing == null) {
                return Text("sorry");
              }

              var myAudio = playing.audio;
              widget.isFav = widget.jj(myAudio);
              print("the isFav when building ${widget.isFav}");
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: Text(
                      "Now Playing",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * .06,
                  ),
                  // the song image or album art
                  Container(
                    padding: const EdgeInsets.all(1),
                    margin:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 30),
                    height: height * .35,
                    width: width * .7,
                    decoration: const BoxDecoration(
                        color: const Color(0xffc4c5c5),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20))),
                    child: const Icon(
                      Icons.music_note,
                      size: 100,
                    ),
                  ),
                  // Image(image: MetasImage(path:  myAudio.path, type: type)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      // SizedBox(width: 80,),
                      Container(
                        width: 150,
                        child: Center(
                          child: Text(
                            myAudio.audio.metas.title!,
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 24,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Row(
                        children: [
                          audioplayer1.builderRealtimePlayingInfos(builder:
                              (context, RealtimePlayingInfos? currentinfo) {
                            var x = currentinfo!.current!.index;
                            if (currentinfo == null) {
                              return Text("sorry");
                            }
                            var playingAudio = playing.audio;
                            return Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    showInformationDialog(context,
                                        playingAudio.audio.metas.title!);
                                  },
                                  icon: Icon(
                                    Icons.playlist_add,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () async {
                                    widget.isFav
                                        ? removeFav(playingAudio)
                                        : addFav(myAudio);
                                    print("onPress ${widget.isFav}");
                                    setState(() {});
                                    // ? removeFav()
                                    // :
                                  },
                                  icon: Icon(widget.isFav
                                      ? Icons.favorite
                                      : Icons.favorite_border),
                                ),
                              ],
                            );
                          }),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: 150,
                    child: Text(
                      myAudio.audio.metas.artist!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 21,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(1),
                        margin: const EdgeInsets.only(
                            left: 10, right: 10, bottom: 30),
                        height: height * .023,
                        width: width * .8,
                        decoration: const BoxDecoration(
                            color: const Color(0xffc4c5c5),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20))),
                      ),
                      Container(
                          // padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 30),
                          height: height * .023,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade700,
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                          child: audioplayer1.builderRealtimePlayingInfos(
                              builder:
                                  (context, RealtimePlayingInfos? currentinfo) {
                            if (currentinfo == null) {
                              return Text("sorry");
                            }
                            return ProgressBar(
                              baseBarColor: Color(0xffc4c5c5),
                              thumbRadius: .5,
                              thumbColor: Color(0xffc4c5c5),
                              barHeight: 18,
                              progressBarColor: Theme.of(context).primaryColor,
                              progress: currentinfo.currentPosition,
                              total: currentinfo.duration,
                              onSeek: (to) {
                                audioplayer1.seek(to);
                              },
                            );
                          })),
                    ],
                  ),
                  Container(
                    height: height * .1,
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              // // loop repeat
                              // SizedBox(
                              //     height: 60,
                              //     width: 60,
                              //     child: Center(
                              //         child: IconButton(
                              //       onPressed: () {
                              //         audioplayer1.setLoopMode(LoopMode.single);
                              //       },
                              //       icon: const Icon(
                              //         Icons.loop,
                              //         color: Colors.black54,
                              //       ),
                              //     ))),
                              // skip previous
                              SizedBox(
                                  height: 60,
                                  width: 60,
                                  child: Center(
                                      child: IconButton(
                                    onPressed: () {
                                      audioplayer1.previous();
                                    },
                                    icon: const Icon(
                                      Icons.skip_previous,
                                      size: 40,
                                    ),
                                  ))),
                              // play pause
                              // const SizedBox(
                              //   height: 60,
                              //   width: 60,
                              // ),

                              //  skip next
                              SizedBox(
                                  height: 60,
                                  width: 60,
                                  child: Center(
                                      child: IconButton(
                                    onPressed: () {
                                      audioplayer1.next();
                                    },
                                    icon: const Icon(
                                      Icons.skip_next,
                                      size: 40,
                                    ),
                                  ))),
                              // shuffle
                              // SizedBox(
                              //     height: 60,
                              //     width: 60,
                              //     child: Center(
                              //         child: IconButton(
                              //       onPressed: () {
                              //         audioplayer1.toggleShuffle();
                              //       },
                              //       icon: const Icon(
                              //         Icons.shuffle,
                              //       ),
                              //     ))),
                            ],
                          ),
                        ),
                        fn1(context),
                        // play
                        // Positioned(
                        //   left: width*.4,
                        //   child: IconButton(
                        //     onPressed: () {
                        //   print("working");
                        //   audioplayer1.playOrPause();
                        //     },
                        //     icon: const Icon(
                        //   Icons.play_circle_outline,
                        //   size: 80,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ],
              );
            })
          ],
        ),
      ),
    );
  }

  removeFav(dynamic playingAudio) {
    OnAudioRoom()
        .queryFavorites(
      limit: 50,
      sortType: null,
    )
        .then((value) {
      for (var song in value) {
        if (song.title == playingAudio.audio.metas.title) {
          print(
              "match found ${song.title} == ${playingAudio.audio.metas.title}");
          audioRoom1
              .deleteFrom(
            RoomType.FAVORITES,
            song.key,
          )
              .then((value) {
            print("song isremoved= $value from the favorites");
            setState(() {
              widget.isFav = false;
            });
          });
        }
      }
    });
  }

  addFav(PlayingAudio myAudio) async {
    await OnAudioQuery()
        .querySongs(
      sortType: SongSortType.DISPLAY_NAME,
      orderType: OrderType.ASC_OR_SMALLER,
    )
        .then((value) {
      SongModel songModel1 = value[0];
      for (var song in value) {
        if (song.title == myAudio.audio.metas.title) {
          // print("got it");
          songModel1 = song;
          audioRoom1
              .addTo(
            RoomType.FAVORITES,
            songModel1.getMap.toFavoritesEntity(),
            ignoreDuplicate: false,
          )
              .then((value) {
            print("the song added to favorite");
            setState(() {
              widget.isFav = true;
            });
          });
        }
      }
      return value;
    });
  }
}

Widget fn1(BuildContext ctx) {
  // PlayerBuilder.realtimePlayingInfos(player: player, builder: builder)
  return PlayerBuilder.isPlaying(
      player: audioplayer1,
      builder: (ctx, isPlaying1) {
        return Container(
          margin: EdgeInsets.only(left: 165, top: 6),
          child: InkWell(
              onTap: () {
                // print("working");
                audioplayer1.playOrPause();
                // print(isPlaying1);
              },
              child: Icon(
                isPlaying1
                    ? Icons.pause_circle_outline_outlined
                    : Icons.play_circle_outline,
                size: 80,
              )),
        );
      });
}
