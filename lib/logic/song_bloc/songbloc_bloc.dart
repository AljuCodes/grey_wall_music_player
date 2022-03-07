import 'package:bloc/bloc.dart';
import 'package:grey_wall/main.dart';
import 'package:meta/meta.dart';
import 'package:on_audio_query/on_audio_query.dart';

part 'songbloc_event.dart';
part 'songbloc_state.dart';

class SongBloc extends Bloc<SongEvent, List<SongModel>> {
  SongBloc() : super(<SongModel>[]) {
    on<SongEvent>((event, emit) {
      if (event.type == EventType.load) {
        emit(hiveCtrl.returnSongs());
      }
      if (event.type == EventType.search) {
        List<SongModel> songs = hiveCtrl.returnSongs();
        List<SongModel> filteredSongs = songs
            .where((songs) =>
                songs.title.toLowerCase().contains(event.query!.toLowerCase()))
            .toList();
        emit(filteredSongs);
      }
    });
  }
}
