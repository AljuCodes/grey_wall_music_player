import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grey_wall/common.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';

// void main(List<String> args) {
//   runApp(new MaterialApp(
//     title: "My App",
//     home: new StatefulDialog(),
//   ));
// }

// class StatefulDialog extends StatefulWidget {
//   StatefulDialog(this.context,this.title);
//   BuildContext context;
//   String title;
//   @override
//   _StatefulDialogState createState() => _StatefulDialogState();
// }

// class _StatefulDialogState extends State<StatefulDialog> {
//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   final TextEditingController _textEditingController = TextEditingController();

Future<void> showInformationDialog(BuildContext context, String title) async {
  return await showDialog(
      context: context,
      builder: (ctx) {
        bool isChecked = false;
        return StatefulBuilder(builder: (context, setState) {
          return SimpleDialog(
            children: [
              SimpleDialogOption(
                onPressed: () {
                  // Navigator.pop(context);
                  createPlaylist(ctx, context, setState);
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
                      return FutureBuilder<List<PlaylistEntity>>(
                          future: OnAudioRoom().queryPlaylists(),
                          builder: (context, item) {
                            //final x = item.data[0].id
                            if (item.data == null)
                              return Center(
                                child: Text('Nothing Found'),
                              );

                            return ListView.separated(
                              shrinkWrap: true,
                              itemCount: item.data!.length,
                              itemBuilder: (ctx, index) => GestureDetector(
                                  onTap: () async {
                                    await OnAudioRoom().addTo(RoomType.PLAYLIST,
                                        sM.getMap.toFavoritesEntity(),
                                        playlistKey: item.data![index].key,
                                        ignoreDuplicate: false).then((value) {
                                          // Get.snackbar("music added", "succesfully");
                                          if(value!=0){
                                       
                                        }});
                                        
                                    Navigator.pop(ctx);
                                    //print(item.data![index].dateAdded);
                                    // final x = _audioQuery.addToPlaylist(
                                    //     item.data![index].id, id);
                                    // print(x);
                                    //_audioQuery.queryAudiosFrom();
                                  },
                                  child: Text(
                                    item.data![index].playlistName,
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
