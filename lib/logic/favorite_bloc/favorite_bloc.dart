
import 'package:bloc/bloc.dart';
import 'package:grey_wall/logic/song_bloc/songbloc_bloc.dart';
import 'package:grey_wall/main.dart';
import 'package:meta/meta.dart';
import 'package:on_audio_room/details/rooms/favorites/favorites_entity.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, List<FavoritesEntity>> {
  FavoriteBloc() : super(<FavoritesEntity>[]) {
    on<FavoriteEvent>((event, emit) {
      if (event.type == EventType.load) {
        List<FavoritesEntity> favlist = hiveCtrl.returnFav();
        emit(favlist);
      }
      
    });
  }
}
