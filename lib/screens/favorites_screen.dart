import 'package:flutter/material.dart';
import 'package:grey_wall/audio.dart';
import 'package:grey_wall/widgets/song_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({Key? key}) : super(key: key);
  final List<Map> myProduct = List.generate(15, (index) => {});
  @override
  Widget build(BuildContext context) {

    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Albums'),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            height: height * 0.83,
            child: 
            FutureBuilder<List<FavoritesEntity>>(future: OnAudioRoom().queryFavorites(
              limit: 50,
              sortType: null,
              
            ),
            
            builder: (context,item){
              if(item.data==null) return CircularProgressIndicator();
              if(item.data!.isEmpty) return Text("No data found");
              List<FavoritesEntity> favorites = item.data!;
              return  ListView.builder(
              itemCount: myProduct.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(),
                  child: songwidget(
                    song: [] as SongModel,
                    favorites: favorites,
                    songName: favorites[index].title,
                    artistName: favorites[index].artist!,
                    index: index,
                    isInFav: true,
                   isfav: true,
                  ),
                );
              },
            );
            },
            
            ),
           
          ),
        ],
      )),
    );
  }
}
