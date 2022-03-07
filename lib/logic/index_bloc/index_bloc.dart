import 'package:bloc/bloc.dart';
import 'package:grey_wall/logic/song_bloc/songbloc_bloc.dart';
import 'package:grey_wall/main.dart';
import 'package:meta/meta.dart';

part 'index_event.dart';
part 'index_state.dart';

class IndexBloc extends Bloc<IndexEvent, int> {
  IndexBloc() : super(0) {
    on<IndexEvent>((event, emit) {
      if (event.type == EventType.load) {
        int index = hiveCtrl.returnIndex();
        emit(index);
      }
    });
  }
}
