import 'package:flutter/material.dart';
import 'package:grey_wall/main.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';

final OnAudioQuery _audioQuery = OnAudioQuery();

final OnAudioRoom _audioRoom = OnAudioRoom();

// void dialogBox(
//   BuildContext context,
//   String title,
// ) {
//   showDialog(
//       context: context,
//       builder: (ctx) => SimpleDialog(
//             children: [
//               SimpleDialogOption(
//                 onPressed: () {
//                   Navigator.pop(context);
//                   createPlaylist(ctx, context,title);
//                 },
//                 child: Text('New Playlist'),
//               ),
//               SimpleDialogOption(
//                   child: SizedBox(
//                 height: 120,
//                 width: 200,
//                 child: FutureBuilder<List<SongModel>>(
//                     future: OnAudioQuery().querySongs(),
//                     builder: (contex, lsSongModel) {
//                       if (lsSongModel.data == null)
//                         return Center(child: Text("No data found"));
//                       if (lsSongModel.data!.isEmpty) {
//                         return const CircularProgressIndicator();
//                       }

//                       List<SongModel> songmodel = lsSongModel.data!;
//                       SongModel sM = SongModel({});
//                       for (var song in songmodel) {
//                         if (song.title == title) {
//                           sM = song;
//                         }
//                       }
//                       return FutureBuilder<List<PlaylistEntity>>(
//                           future: _audioRoom.queryPlaylists(),
//                           builder: (context, item) {
//                             //final x = item.data[0].id
//                             if (item.data == null)
//                               return Center(
//                                 child: Text('Nothing Found'),
//                               );

//                             return ListView.separated(
//                               shrinkWrap: true,
//                               itemCount: item.data!.length,
//                               itemBuilder: (ctx, index) => GestureDetector(
//                                   onTap: () async {
//                                     OnAudioRoom().addTo(RoomType.PLAYLIST,
//                                         sM.getMap.toFavoritesEntity(),
//                                         playlistKey: item.data![index].key,
//                                         ignoreDuplicate: false);
//                                     Navigator.pop(ctx);
//                                     //print(item.data![index].dateAdded);
//                                     // final x = _audioQuery.addToPlaylist(
//                                     //     item.data![index].id, id);
//                                     // print(x);
//                                     //_audioQuery.queryAudiosFrom();
//                                   },
//                                   child: Text(item.data![index].playlistName)),
//                               separatorBuilder: (ctx, index) => SizedBox(
//                                 height: 18,
//                               ),
//                             );
//                           });
//                     }),
//               ))
//             ],
//           ));
// }

void createPlaylist(BuildContext ctx, BuildContext context,
    void Function(void Function()) setState) {
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
                  //filled: true,
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
                  onPressed: () {
                    createNewPlaylist(playlistNameController.text);
                    setState(() {});
                    Navigator.pop(context);
                    // dialogBox(context);
                  },
                  child: Text('Ok'))
            ],
          ));
}



void createNewPlaylist(String name) {
  final x = _audioRoom.createPlaylist(name);
  print(x);
}
