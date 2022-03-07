import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grey_wall/logic/favorite_bloc/favorite_bloc.dart';
import 'package:grey_wall/main.dart';
import 'package:grey_wall/widgets/song_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<FavoriteBloc>(context).add(FavoriteEvent.load());
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
     
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            height: height * 0.83,
            child: BlocBuilder<FavoriteBloc, List<FavoritesEntity>>(
              builder: (context, List<FavoritesEntity> item) {
                if (item == null) return CircularProgressIndicator();
                if (item.isEmpty) return Center(child: Text("No data found"));
                List<FavoritesEntity> favorites = item;
                List<Audio> audioList = [];
                for (var favorite in favorites) {
                  audioList.add(Audio.file(favorite.lastData,
                      metas: Metas(
                          artist: favorite.artist,
                          title: favorite.title,
                          id: favorite.id.toString())));
                }
                SongModel ll = SongModel({});
                return ListView.builder(
                  itemCount: favorites.length,
                  itemBuilder: (context, index) {
                    return SongWidget(
                      removeFav: () {
                        audioRoom1.deleteFrom(
                          RoomType.FAVORITES,
                          favorites[index].key,
                        );
                        hiveCtrl.initializeFavorite();
                        BlocProvider.of<FavoriteBloc>(context)
                            .add(FavoriteEvent.load());
                      },
                      audioList: audioList,
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
