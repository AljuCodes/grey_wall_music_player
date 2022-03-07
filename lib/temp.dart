import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:grey_wall/common.dart';
import 'package:grey_wall/logic/playlist_bloc/playlist_bloc.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';

Future<void> showInformationDialog4(BuildContext context, String title) async {
  return await showDialog(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(builder: (context, _) {
          return SimpleDialog(
            children: [
              SimpleDialogOption(
                onPressed: () {
                  // Navigator.pop(context);
                  createPlaylist(ctx, context,);
                },
                child: Text('New Playlist'),
              ),
              SimpleDialogOption(
                  child: SizedBox(
                height: 120,
                width: 200,
                child: FutureBuilder<List<SongModel>>(
                    future: OnAudioQuery().querySongs(),
                    builder: (contex, lsSongModel) {
                      if (lsSongModel.data == null)
                        return Center(child: Text("No data found"));
                      if (lsSongModel.data!.isEmpty) {
                        return const CircularProgressIndicator();
                      }

                      List<SongModel> songmodel = lsSongModel.data!;
                      SongModel sM = SongModel({});
                      for (var song in songmodel) {
                        if (song.title == title) {
                          sM = song;
                        }
                      }

                      return BlocBuilder<PlaylistBloc, List<PlaylistEntity>>(
                          builder: (context, item) {
                        //final x = item.data[0].id
                        if (item == null)
                          return Center(
                            child: Text('Nothing Found'),
                          );

                        return ListView.separated(
                          shrinkWrap: true,
                          itemCount: item.length,
                          itemBuilder: (ctx, index) => GestureDetector(
                              onTap: () async {
                                await OnAudioRoom()
                                    .addTo(RoomType.PLAYLIST,
                                        sM.getMap.toFavoritesEntity(),
                                        playlistKey: item[index].key,
                                        ignoreDuplicate: false)
                                    .then((value) {
                                
                                  if (value != 0) {}
                                });

                                Navigator.pop(ctx);
                       
                              },
                              child: Text(
                                item[index].playlistName,
                              )),
                          separatorBuilder: (ctx, index) => SizedBox(
                            height: 18,
                          ),
                        );
                      });
                    }),
              ))
            ],
          );
        });
      });
}
