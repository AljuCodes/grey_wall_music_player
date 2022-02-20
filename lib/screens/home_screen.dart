import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:grey_wall/audio.dart';
import 'package:grey_wall/main.dart';
import 'package:grey_wall/models/boxmodels.dart';
import 'package:grey_wall/screens/more_screen.dart';
import 'package:grey_wall/screens/player_screen.dart';
import 'package:grey_wall/screens/search_songs_screen.dart';
import 'package:grey_wall/widgets/song_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  QueryArtworkWidget? qrwdgt;

  String? songName;

  String? artistName;

  // void lll() async {
  //   print("lll is working");
  //   List<SongModel> fetchedSongs = await OnAudioQuery().querySongs(
  //     sortType: SongSortType.DISPLAY_NAME,
  //     orderType: OrderType.ASC_OR_SMALLER,
  //   );
  //   print("fetched song is ${fetchedSongs.toList()}");
  //   for (SongModel song in fetchedSongs) {
  //     print(
  //         "song title is ${song.title} song artist is ${song.artist} song id is ${song.id} ");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    //  fn();
    // lll();

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;


    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        // padding: EdgeInsets.all(25),
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
                  margin: const EdgeInsets.only(top: 7, left: 20, bottom: 7),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // song container
                      Container(
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => PlayerScreen()));
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
                      // skip previous
                      // SizedBox(width: 20,),
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
                      const SizedBox(
                        height: 60,
                        width: 60,
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
                // play
                Positioned(
                  bottom: 11,
                  child: Container(
                    //  decoration: BoxDecoration(color: Colors.black),
                    margin: EdgeInsets.only(
                      left: width * .465,
                    ),
                    height: 50,
                    width: 50,
                    child: fn2(context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
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
                            builder: (context) => const SearchScreen()));
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
            padding: const EdgeInsets.only(bottom: 50),
            child: Container(
              height: 700,
              child: ValueListenableBuilder<Box<SongBoxModel>>(
                  valueListenable: hiveCtrl.getSongBox().listenable(),
                  builder: (context, box, _) {
                    final songs = box.values.toList().cast<SongBoxModel>();
                    // print("songs to play in ");
                    // print("song is empty ${songs.isEmpty}");
                    if (songs.isEmpty) {
                      return const Center(
                        child: Text("NO SONGS FOUND"),
                      );
                    } else {
                      return FutureBuilder<List<SongModel>>(
                        // Default values:
                        future: OnAudioQuery().querySongs(
                          sortType: SongSortType.DISPLAY_NAME,
                          orderType: OrderType.ASC_OR_SMALLER,
                        ),
                        builder: (context, item) {
                          // Loading content
                          if (item.data == null)
                            return const CircularProgressIndicator();

                          // When you try "query" without asking for [READ] or [Library] permission
                          // the plugin will return a [Empty] list.
                          if (item.data!.isEmpty)
                            return const Text("Nothing found!");
                          List<Audio> audioList = [];
                          List<SongModel> SongModelList = item.data!;
                          for (var song in SongModelList) {
                            audioList.add(Audio.file(song.data,
                                metas: Metas(
                                    title: song.title,
                                    artist: song.artist,
                                    id: song.id.toString())));
                          }

                          // You can use [item.data!] direct or you can create a:
                          // List<SongModel> songs = item.data!;
                          return ListView.builder(
                            itemCount: item.data!.length,
                            itemBuilder: (context, index) {
                              return songwidget(

                                audioList: audioList,
                                song: item.data![index],
                                artistName: item.data![index].artist!,
                                index: index,
                                songName: item.data![index].title,
                              );
                            },
                          );
                        },
                      );
                      //  Container(
                      //     child: RefreshIndicator(
                      //   onRefresh: hiveCtrl.fetchAllsongs,
                      //   child: ListView.builder(
                      //     itemCount: songs.length,
                      //     itemBuilder: (context, index) {
                      //     return songwidget(
                      //       song: [] as SongModel ,
                      //       index: index,
                      //         artistName: songs[index].songArtists!,
                      //         songName: songs[index].songTitle);
                      //   }),
                      // ),
                      // );
                    }
                  }),
            ),
          )),
    );
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
