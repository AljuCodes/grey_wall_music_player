import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:grey_wall/audio.dart';
import 'package:grey_wall/main.dart';
import 'package:grey_wall/screens/more_screen.dart';
import 'package:grey_wall/screens/player_screen.dart';
import 'package:grey_wall/screens/search_songs_screen.dart';
import 'package:grey_wall/widgets/song_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomeScreen extends StatelessWidget {
  QueryArtworkWidget? qrwdgt;

  String? songName;

  String? artistName;

  @override
  Widget build(BuildContext context) {
    hiveCtrl.intializePlaylist();
    hiveCtrl.initializeFavorite();
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return FutureBuilder<bool>(
        future: OnAudioQuery().permissionsStatus(),
        builder: (contxt, gotpermission) {
          if (gotpermission.data == null) return Text("waiting");
          if (gotpermission.data == false) {
            OnAudioQuery().permissionsRequest();
          }
          return Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: audioplayer1.builderRealtimePlayingInfos(
                builder: (context, RealtimePlayingInfos? currentinfo) {
              // var x = currentinfo!.current!.index;
              if (currentinfo == null) {
                return Container();
              }
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey.shade700,
                    border: Border.all(color: Colors.black)),
                width: width * .9,
                height: 80,
                child: Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              top: 7, left: 20, bottom: 7),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // song container
                              Container(
                                child: Center(
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  PlayerScreen()));
                                    },
                                    child: Container(
                                      // margin: EdgeInsets.only(left: 10),
                                      height: 60,
                                      width: 60,
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: const BorderRadius.all(
                                              const Radius.circular(18))),
                                      child: const Icon(Icons.music_note),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 30,
                              ),

                              Container(
                                  // margin: EdgeInsets.only(left:),
                                  height: 60,
                                  width: 60,
                                  child: Center(
                                      child: IconButton(
                                    onPressed: () {
                                      print("pressed  prev");
                                      audioplayer1.previous();
                                    },
                                    icon: const Icon(
                                      Icons.skip_previous,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ))),
                              // play pause
                              Container(
                                height: 60,
                                width: 60,
                                child: fn2(context),
                              ),

                              //  skip next
                              SizedBox(
                                  height: 60,
                                  width: 60,
                                  child: Center(
                                      child: IconButton(
                                    onPressed: () {
                                      print("printed next");
                                      audioplayer1.next();
                                    },
                                    icon: const Icon(
                                      Icons.skip_next,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  ))),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),
            appBar: AppBar(
              title: const Text("Home"),
              actions: [
                // serach songs and more
                PopupMenuButton<int>(
                  padding: const EdgeInsets.all(0),
                  enableFeedback: true,
                  shape: const RoundedRectangleBorder(
                      borderRadius:
                          const BorderRadius.all(const Radius.circular(15))),
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      child: Column(
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SearchScreen()));
                            },
                            child: Text("search songs",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).primaryColor)),
                          ),
                          const Divider(
                            color: Colors.black,
                            thickness: 2,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const MoreScreen()));
                            },
                            child: Text("more",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Theme.of(context).primaryColor)),
                          ),
                        ],
                      ),
                    )
                  ],
                  color: Colors.white,
                  iconSize: 30,
                )
              ],
            ),
            body: Scaffold(
              backgroundColor: const Color(0xfff1f3f4),
              body: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  height: 700,
                  child: FutureBuilder<List<SongModel>>(
                    // Default values:
                    future: hiveCtrl.fetchAllsongs(),
                    builder: (context, item) {
                      // Loading content
                      if (item.data == null)
                        return const CircularProgressIndicator();
                      if (item.data!.isEmpty)
                        return const Text("Nothing found!");
                      List<SongModel> SongModelList = item.data!;
                      List<Audio> audioList = toAudio(SongModelList);
                      return ListView.builder(
                        itemCount: audioList.length,
                        itemBuilder: (context, index) {
                          print("11 ${audioList[index]}");
                          return SongWidget(
                            audioList: audioList,
                            song: item.data![index],
                            artistName: item.data![index].artist!,
                            index: index,
                            songName: item.data![index].title,
                          );
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        });
  }
}

Widget fn2(BuildContext ctx) {
  return PlayerBuilder.isPlaying(
      player: audioplayer1,
      builder: (ctx, isPlaying1) {
        return InkWell(
          onTap: () {
            print("working");
            audioplayer1.playOrPause();
            print(isPlaying1);
          },
          child: Icon(
            isPlaying1 ? Icons.pause : Icons.play_arrow,
            size: 50,
            color: Colors.white,
          ),
        );
      });
}
