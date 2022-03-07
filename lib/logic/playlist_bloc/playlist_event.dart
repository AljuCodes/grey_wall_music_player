part of 'playlist_bloc.dart';

class PlaylistEvent {
  EventType type = EventType.load;
  PlaylistEvent.load() {
    type = EventType.load;
  }
}
