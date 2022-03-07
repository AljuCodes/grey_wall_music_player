import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:grey_wall/models/boxmodels.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:on_audio_room/on_audio_room.dart';

class HiveBoxController extends GetxController {
  List<SongEntity> allPlaylistSongs = [];
  List<SongModel> allSongsinitial = [];
  List<PlaylistEntity> allPlaylistsinitial = [];
  List<FavoritesEntity> allFavoritesinitial = [];
  int tabIndex = 0;
  Box<SongBoxModel> getSongBox() => Hive.box<SongBoxModel>('songs');
  // Future<void> boxInitiliaser() async {
  //   await Hive.initFlutter();
  //   print("SUCESS: Hive initialised successfully.");
  //   adaperRegistrar();
  //   await boxesOpener();
  //   print("SUCESS: All Hive Boxes opened succesfully");
  // }

  // void adaperRegistrar() async {
  //   Hive.registerAdapter(SongBoxModelAdapter());

  //   print("All boxes are opened successfully.");
  // }

  // Future<void> boxesOpener() async {
  //   await Hive.openBox<SongBoxModel>('songs');
  //   print("All boxes are opened successfully");
  // }

  Future<List<SongModel>> fetchAllsongs() async {
    List<SongModel> fetchedSongs = await OnAudioQuery()
        .querySongs(
      sortType: SongSortType.DISPLAY_NAME,
      orderType: OrderType.ASC_OR_SMALLER,
    )
        .then((value) {
      allSongsinitial = value;
      return value;
    });

    // for (SongModel song in fetchedSongs) {
    //   if (song.fileExtension == 'mp3' ||
    //       song.fileExtension == 'opus' &&
    //           await File(song.data).exists() &&
    //           !song.title.contains("AUD-")) {
    //     if (!getSongBox().containsKey(song.id)) {
    //       Uint8List? art =
    //           await OnAudioQuery().queryArtwork(song.id, ArtworkType.AUDIO);

    //       getSongBox().put(
    //           song.id,
    //           SongBoxModel(
    //               songTitle: song.title,
    //               songUrl: song.data,
    //               songArtists: song.artist,
    //               songId: song.id,
    //               albumArt: art));
    //     }
    //   }
    // }
    return fetchedSongs;
  }

  Future<void>intializePlaylist() async {
    allPlaylistsinitial = [];
    allPlaylistsinitial = await OnAudioRoom().queryPlaylists();
  }
Future<void> intializePlaylistSongs(playlistKey)async{
allPlaylistSongs = [];
allPlaylistSongs = await  OnAudioRoom().queryAllFromPlaylist(playlistKey);
}
  initializeFavorite() async {
    allFavoritesinitial = [];
    allFavoritesinitial = await OnAudioRoom().queryFavorites(
      limit: 50,
      sortType: null,
    );
  }

  setIndex(int index) {
    tabIndex = index;
  }

  returnFav() {
    return allFavoritesinitial;
  }

  returnSongs() {
    return allSongsinitial;
  }

  returnIndex() {
    return tabIndex;
  }
returnPlaylistSongs(){
  return allPlaylistSongs;
}
  List<PlaylistEntity> returnPlaylist() {
    return allPlaylistsinitial;
  }
}
