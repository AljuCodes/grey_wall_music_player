import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:grey_wall/screens/playlist_screen.dart';
import 'package:grey_wall/tab_view.dart';
import 'package:grey_wall/widgets/song_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';

class PlaylistDetailScreen extends StatefulWidget {
  final String ArtistName;
  final int playlistKey;
  VoidCallback setstate;
  PlaylistDetailScreen(this.ArtistName, this.playlistKey, this.setstate);

  @override
  State<PlaylistDetailScreen> createState() => _PlaylistDetailScreenState();
}

class _PlaylistDetailScreenState extends State<PlaylistDetailScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context5) {
    SongModel ll = SongModel({});
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
              onPressed: () {
                fn189(context5);
              },
              icon: Icon(
                Icons.arrow_back,
                size: 32,
              )),
          title: Row(
            children: [
              Text("Playlist songs"),
            ],
          ),
          actions: [
            PopupMenuButton<int>(
              padding: const EdgeInsets.all(0),
              enableFeedback: true,
              shape: const RoundedRectangleBorder(
                  borderRadius:
                      const BorderRadius.all(const Radius.circular(15))),
              itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: () {},
                  child: Column(
                    children: [
                      TextButton(
                        onPressed: () {
                          showInformationDialog(
                            context,
                            () {
                              // setState(() {});
                            },
                          );
                          // Navigator.of(context).pop();
                        },
                        child: Text("edit playlist Name",
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
        body: FutureBuilder<List<SongEntity>>(
            future: OnAudioRoom().queryAllFromPlaylist(widget.playlistKey),
            builder: (context, item) {
              if (item.data == null) return Center(child: Text("no songs "));
              if (item.data!.isEmpty)
                return Center(child: Text("no songs added yet"));
              final listOfSongs = item.data;
              List<Audio> ls = [];

              for (var song in listOfSongs!) {
                ls.add(Audio.file(song.lastData,
                    metas: Metas(
                      title: song.title,
                      artist: song.artist,
                      album: song.album,
                    )));
              }
              return FutureBuilder<List<SongModel>>(
                future: OnAudioQuery().querySongs(),
                builder: (context, ListOfSongModel) {
                  if (ListOfSongModel.data == null)
                    return Center(child: Text("no songs "));
                  ListOfSongModel.data!.isEmpty
                      ? CircularProgressIndicator()
                      : null;
                  List<SongModel> listOfSongModels = ListOfSongModel.data!;
                  return Center(
                    child: ListView.builder(
                      itemBuilder: ((context, index) {
                        return songwidget(
                          index: index,
                          audioList: ls,
                          isPlaylist: true,
                          removeSong: () {
                            print("868 it wokerd ");
                            OnAudioRoom().deleteFrom(
                              RoomType.PLAYLIST,
                              listOfSongs[index].id,
                              playlistKey: widget.playlistKey,
                            );
                            // widget.setstate();

                            setState(() {});
                            Navigator.of(context).pop();
                          },
                          song: ListOfSongModel.data![index],
                          artistName: ls[index].metas.artist!,
                          songName: ls[index].metas.title!,
                        );
                      }),
                      itemCount: ls.length,
                    ),
                  );
                },
              );
            }));
  }

  Future<void> showInformationDialog(
    BuildContext context,
    VoidCallback fn,
  ) async {
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
              title: const Text(' Rename Playlist '),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      OnAudioRoom().renamePlaylist(
                          widget.playlistKey, _textEditingController.text);

                      // fn();
                      // widget.setstate;
                      // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>TabContainerBottom(index1: 1,)));
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text('OK   '),
                ),
              ],
            );
          });
        });
  }

  void fn189(BuildContext context2) {
    Navigator.of(context2).pushReplacement(MaterialPageRoute(
        builder: (context2) => TabContainerBottom(
              index1: 1,
            )));
  }
}
