part of 'songbloc_bloc.dart';

enum EventType { search,load }

class SongEvent {
   EventType type=EventType.search;
   String? query;


  SongEvent.search({required this.query}) {
    type = EventType.search;
   this.query = query;
  }
  SongEvent.load(){
    this.type=EventType.load;
  }
}
