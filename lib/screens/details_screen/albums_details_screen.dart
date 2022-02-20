import 'package:flutter/material.dart';
import 'package:grey_wall/widgets/song_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AlbumDetailScreen extends StatelessWidget {
  final  String ArtistName;

  const AlbumDetailScreen(this.ArtistName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ArtistName),
      ),
      body: Center(
        child: ListView.builder(itemBuilder: ((context, index) => songwidget(song: [] as SongModel,audioList: [],)),itemCount: 15,),
      ),
    );
    
  }
}