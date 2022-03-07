import 'package:bloc/bloc.dart';
import 'package:grey_wall/logic/song_bloc/songbloc_bloc.dart';
import 'package:grey_wall/main.dart';
import 'package:meta/meta.dart';

part 'notify_event.dart';
part 'notify_state.dart';

class NotifyBloc extends Bloc<NotifyEvent, bool> {
  NotifyBloc() : super(true) {
    on<NotifyEvent>((event, emit) {
      if (event.type == EventType.load) {
        bool notification = permissionCtrl.getNotification();
        emit(notification);
      }
    });
  }
}
