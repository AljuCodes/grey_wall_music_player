import 'package:bloc/bloc.dart';

import 'package:meta/meta.dart';
import 'package:on_audio_room/details/rooms/playlists/playlist_entity.dart';

import '../../main.dart';
import '../song_bloc/songbloc_bloc.dart';

part 'playlist_event.dart';
part 'playlist_state.dart';

class PlaylistBloc extends Bloc<PlaylistEvent, List<PlaylistEntity>> {
  PlaylistBloc() : super(<PlaylistEntity>[]) {
    on<PlaylistEvent>((event, emit) {
      if (event.type == EventType.load) {
        print(hiveCtrl.returnPlaylist());
        List<PlaylistEntity> playlists = hiveCtrl.returnPlaylist();
        emit(playlists);
      }
    });
  }
}
