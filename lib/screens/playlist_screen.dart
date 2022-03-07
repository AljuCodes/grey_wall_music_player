import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grey_wall/logic/playlist_bloc/playlist_bloc.dart';
import 'package:grey_wall/logic/playlist_song_bloc/playlistsong_bloc.dart';
import 'package:grey_wall/main.dart';

import 'package:grey_wall/screens/details_screen/playlist_detail_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';

final OnAudioQuery1 = OnAudioQuery();

class playlistScreen extends StatelessWidget {
  playlistScreen({Key? key}) : super(key: key);

  List<PlaylistEntity> myProduct = [];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _textEditingController = TextEditingController();

  Future<void> showInformationDialog(
    BuildContext context,
  ) async {
    return await showDialog(
        context: context,
        builder: (context) {
          bool isChecked = false;
          return StatefulBuilder(builder: (context, _) {
            return AlertDialog(
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _textEditingController,
                        validator: (value1) {
                          String? s;
                          if (value1 == null || value1.isEmpty) {
                            s = "Enter a name";
                          }

                          return s;
                        },
                        decoration:
                            const InputDecoration(hintText: "playlist Name"),
                      ),
                    ],
                  )),
              title: const Text('Create new playlist'),
              actions: <Widget>[
                TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      // Do something like updating SharedPreferences or User Settings etc.
                      if (_textEditingController.text.isNotEmpty) {
                        OnAudioRoom().createPlaylist(
                            _textEditingController.text,
                            ignoreDuplicate: false);
                        _textEditingController.clear();
                        await hiveCtrl.intializePlaylist();
                        BlocProvider.of<PlaylistBloc>(context)
                            .add(PlaylistEvent.load());
                        Navigator.of(context).pop();
                      }
                    }
                  },
                  child: const Text('OK   '),
                ),
              ],
            );
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<PlaylistBloc>(context).add(PlaylistEvent.load());
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
        appBar: AppBar(
          title: Text('Playlists'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 5.0),
              child: InkWell(
                onTap: () async {
                  await showInformationDialog(
                    context,
                  );
                },
                child: Stack(children: [
                  Container(
                      margin: const EdgeInsets.all(8),
                      width: 79,
                      height: 35,
                      // padding: EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(28))),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 4),
                              child: const Text(
                                "New",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),
                            ),
                            const Icon(
                              Icons.add_circle,
                              size: 35,
                              color: Colors.black,
                            ),
                          ])),
                ]),
              ),
            ),
          ],
        ),
        body: BlocBuilder<PlaylistBloc, List<PlaylistEntity>>(
            builder: ((context, state) {
          if (state == null) return CircularProgressIndicator();
          if (state.isEmpty)
            return Center(
              child: Text("No Playlist"),
            );
          final myProduct = state;
          print("868 is ${myProduct.toString()}");
          // OnAudioRoom().deletePlaylist(77153148);
          return Stack(
            children: [
              Container(
                height: height * .81,
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 280,
                    childAspectRatio: 1 / 1.4,
                    crossAxisSpacing: 27,
                  ),
                  itemCount: myProduct.length,
                  itemBuilder: (BuildContext ctx, index) {
                    return InkWell(
                      onTap: () async {
                        await hiveCtrl
                            .intializePlaylistSongs(myProduct[index].key);
                        BlocProvider.of<PlaylistsongBloc>(context)
                            .add(PlaylistsongEvent.load());
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => PlaylistDetailScreen(
                                myProduct[index].playlistName,
                                myProduct[index].key),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            height: height * .21,
                            width: height * .21,
                            decoration: const BoxDecoration(
                                color: const Color(0xffc4c5c5),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(18))),
                            child: const Icon(
                              Icons.music_note,
                              size: 50,
                            ),
                          ),
                          // The Text
                          Container(
                            margin: const EdgeInsets.only(left: 13),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 20,
                                      child: Text(
                                        myProduct[index].playlistName,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      "Total ${myProduct[index].playlistSongs.length} songs",
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  ],
                                ),
                                IconButton(
                                    onPressed: () {
                                      showInformationDialog1(
                                          context, myProduct[index].key);
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      size: 20,
                                      color: Color.fromARGB(255, 145, 145, 145),
                                    ))
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        })));
  }
}

final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

final TextEditingController _textEditingController = TextEditingController();

Future<void> showInformationDialog1(BuildContext context, int key) async {
  return await showDialog(
      context: context,
      builder: (context) {
        bool isChecked = false;
        return StatefulBuilder(builder: (context, _) {
          return AlertDialog(
            content: Text("Do you really want to delete this playlist"),
            actions: <Widget>[
              InkWell(
                child: Text(
                  'YES',
                  style: TextStyle(color: Colors.redAccent),
                ),
                onTap: () async {
                  OnAudioRoom().deletePlaylist(key);
                  await hiveCtrl.intializePlaylist();
                  BlocProvider.of<PlaylistBloc>(context)
                      .add(PlaylistEvent.load());
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(
                width: 20,
              ),
              InkWell(
                child: Text('NO'),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
              SizedBox(
                width: 5,
              )
            ],
          );
        });
      });
}
