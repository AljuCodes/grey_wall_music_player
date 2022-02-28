import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:grey_wall/main.dart';
import 'package:grey_wall/widgets/song_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';

class FavoritesScreen extends StatefulWidget {
  FavoritesScreen({Key? key}) : super(key: key);

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  final List<Map> myProduct = List.generate(15, (index) => {});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        actions: [IconButton(onPressed: (){
          setState(() {
            
          });
        }, icon: Icon(Icons.refresh))],
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            height: height * 0.83,
            child: FutureBuilder<List<FavoritesEntity>>(
              future: OnAudioRoom().queryFavorites(
                limit: 50,
                sortType: null,
              ),
              builder: (context, item) {
                if (item.data == null) return CircularProgressIndicator();
                if (item.data!.isEmpty) return Center(child: Text("No data found"));
                List<FavoritesEntity> favorites = item.data!;
                List<Audio> audioList = [];
                for(var favorite in favorites ){
                 audioList.add(Audio.file(favorite.lastData,metas: Metas(artist:
                  favorite.artist,title: favorite.title,id: favorite.id.toString()))); 
                }
                SongModel ll = SongModel({});
                return ListView.builder(
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    return songwidget(
                      removeFav: () {
                        
                        setState(() {
                          audioRoom1.deleteFrom(
                            RoomType.FAVORITES,
                            favorites[index].key,
                          );
                        });
                      },
                      audioList:audioList ,
                      song: ll,
                      favorites: favorites,
                      songName: favorites[index].title,
                      artistName: favorites[index].artist!,
                      index: index,
                      isInFav: true,
                      isfav: true,
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
