import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grey_wall/logic/playlist_bloc/playlist_bloc.dart';
import 'package:grey_wall/main.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';

final OnAudioQuery _audioQuery = OnAudioQuery();

final OnAudioRoom _audioRoom = OnAudioRoom();

void createPlaylist(
  BuildContext ctx,
  BuildContext context,
) {
  final playlistNameController = TextEditingController();
  showDialog(
      barrierDismissible: false,
      context: ctx,
      builder: (ctx1) => AlertDialog(
            content: TextField(
                controller: playlistNameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintStyle: TextStyle(color: Colors.grey[600]),
                  hintText: 'Playlist Name',
                )),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(ctx);
                  },
                  child: Text('Cancel')),
              TextButton(
                  onPressed: () async {
                    await createNewPlaylist(playlistNameController.text);
                    await hiveCtrl.intializePlaylist();
                    BlocProvider.of<PlaylistBloc>(context)
                        .add(PlaylistEvent.load());

                    Navigator.pop(context);
            
                  },
                  child: Text('Ok'))
            ],
          ));
}

Future<void> createNewPlaylist(String name) async {
  final x = _audioRoom.createPlaylist(name);
  print(x);
}
