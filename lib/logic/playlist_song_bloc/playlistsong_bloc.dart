import 'package:bloc/bloc.dart';
import 'package:grey_wall/logic/song_bloc/songbloc_bloc.dart';
import 'package:grey_wall/main.dart';
import 'package:meta/meta.dart';
import 'package:on_audio_room/details/rooms/song_entity.dart';

part 'playlistsong_event.dart';
part 'playlistsong_state.dart';

class PlaylistsongBloc extends Bloc<PlaylistsongEvent, List<SongEntity>> {
  PlaylistsongBloc() : super(<SongEntity>[]) {
    on<PlaylistsongEvent>((event, emit) {
      if (event.type == EventType.load) {
        List<SongEntity> songs = hiveCtrl.returnPlaylistSongs();
        emit(songs);
      }
      // TODO: implement event handler
    });
  }
}
