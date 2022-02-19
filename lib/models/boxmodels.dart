import 'dart:typed_data';

import 'package:hive_flutter/adapters.dart';
part 'boxmodels.g.dart';
@HiveType(typeId: 32)
class SongBoxModel extends HiveObject {
    @HiveField(0)
  late String songTitle;
  @HiveField(1)
  late String? songArtists;
  @HiveField(2)
  late String songUrl;
  @HiveField(3)
  late int songId;
    @HiveField(4)
  late Uint8List? albumArt;

  SongBoxModel({
    required this.songTitle,
    required this.songUrl,
    required this.songArtists,
    required this.songId,
    required this.albumArt,
  });
}
