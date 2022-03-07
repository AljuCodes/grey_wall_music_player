import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grey_wall/logic/playlist_bloc/playlist_bloc.dart';
import 'package:grey_wall/main.dart';
import 'package:grey_wall/widgets/song_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';

import '../../logic/playlist_song_bloc/playlistsong_bloc.dart';

class PlaylistDetailScreen extends StatelessWidget {
  final String ArtistName;
  final int playlistKey;

  PlaylistDetailScreen(
    this.ArtistName,
    this.playlistKey,
  );

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
                Navigator.pop(context5);
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
                          );
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
        body: BlocBuilder<PlaylistsongBloc, List<SongEntity>>(
            builder: (context, item) {
          if (item.isEmpty) return Center(child: Text("no songs added yet"));
          final listOfSongs = item;
          List<Audio> ls = [];

          for (var song in listOfSongs) {
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
                    SongModel songModel = SongModel({});
                    for (var song in listOfSongModels) {
                      if (song.title == listOfSongModels[index].title) {
                        songModel = listOfSongModels[index];
                      }
                    }
                    return SongWidget(
                      index: index,
                      audioList: ls,
                      isPlaylist: true,
                      removeSong: () async {
                        print("868 it wokerd ");
                        await OnAudioRoom().deleteFrom(
                          RoomType.PLAYLIST,
                          listOfSongs[index].id,
                          playlistKey: playlistKey,
                        );
                        await hiveCtrl.intializePlaylistSongs(playlistKey);
                        BlocProvider.of<PlaylistsongBloc>(context)
                            .add(PlaylistsongEvent.load());
                        await hiveCtrl.intializePlaylist();
                        BlocProvider.of<PlaylistBloc>(context)
                            .add(PlaylistEvent.load());
                        Navigator.of(context).pop();
                      },
                      song: songModel,
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
  ) async {
    return await showDialog(
        context: context,
        builder: (context) {
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
              title: const Text(' Rename Playlist '),
              actions: <Widget>[
                TextButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (_textEditingController.text.isNotEmpty) {
                        OnAudioRoom().renamePlaylist(
                            playlistKey, _textEditingController.text);
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
}
