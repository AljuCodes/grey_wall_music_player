
import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:grey_wall/models/boxmodels.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HiveBoxController extends GetxController {
  Box<SongBoxModel> getSongBox() => Hive.box<SongBoxModel>('songs');
  Future<void> boxInitiliaser() async {
    await Hive.initFlutter();
    print("SUCESS: Hive initialised successfully.");
    adaperRegistrar();
    await boxesOpener();
    print("SUCESS: All Hive Boxes opened succesfully");
  }

  void adaperRegistrar() async {

    Hive.registerAdapter(SongBoxModelAdapter());
    
    print("All boxes are opened successfully.");
  }

  Future<void> boxesOpener() async {
    await Hive.openBox<SongBoxModel>('songs');
    print("All boxes are opened successfully");
  }

  Future<void> fetchAllsongs() async {
    List<SongModel> fetchedSongs = await OnAudioQuery().querySongs(
      sortType: SongSortType.DISPLAY_NAME,
      orderType: OrderType.ASC_OR_SMALLER,
    );
    for (SongModel song in fetchedSongs) {
      if (song.fileExtension == 'mp3' ||
          song.fileExtension == 'opus' &&
              await File(song.data).exists() &&
              !song.title.contains("AUD-")) {
        if (!getSongBox().containsKey(song.id)) {
          Uint8List? art =
              await OnAudioQuery().queryArtwork(song.id, ArtworkType.AUDIO);
              
          getSongBox().put(
              song.id,
              SongBoxModel(
                  songTitle: song.title,
                  songUrl: song.data,
                  songArtists: song.artist,
                  songId: song.id,
                  albumArt: art));
        }
      }
    }
  }
}
