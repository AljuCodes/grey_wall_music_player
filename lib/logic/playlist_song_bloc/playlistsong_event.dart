part of 'playlistsong_bloc.dart';

 class PlaylistsongEvent {
   EventType type=EventType.load;
    
    PlaylistsongEvent.load(){
      this.type=EventType.load;
    }


 }
