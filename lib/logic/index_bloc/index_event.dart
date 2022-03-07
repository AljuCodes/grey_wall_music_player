part of 'index_bloc.dart';

class IndexEvent {
  EventType type = EventType.load;
  IndexEvent.load() {
    type = EventType.load;
  }
}
