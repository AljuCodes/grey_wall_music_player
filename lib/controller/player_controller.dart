// import 'package:assets_audio_player/assets_audio_player.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';
// import 'package:grey_wall/audio.dart';
// import 'package:grey_wall/main.dart';
// import 'package:grey_wall/models/boxmodels.dart';

// class PlayerController extends GetxController {
//   late bool? notificationEnabled;


//   Future<void> initializeInitialPlaylist() async {
//     List<SongBoxModel> allSongs = hiveCtrl.getSongBox().values.toList();
//     // allSongs.sort(((a, b) => a.songTitle.compareTo(b.songTitle)));
//     List<Audio> songToPlay = [];
//     for (SongBoxModel song in allSongs) {
 
//       songToPlay.add(Audio.file(song.songUrl,
//           metas: Metas(
//               title: song.songTitle,
//               artist: song.songArtists,
//               id: song.songId.toString())));
//     }
//     // print("song to play${songToPlay.toList()}");
//     // audioplayer1.open(Playlist(audios: songToPlay),
//     //     autoStart: false,
//     //     playInBackground: PlayInBackground.enabled,
//     //     showNotification: permissionCtrl.storage.read('notification') ?? true,
//     //     notificationSettings: const NotificationSettings(
//     //       stopEnabled: false,
//     //       seekBarEnabled: true,
//     //     ));
//   }
// }
