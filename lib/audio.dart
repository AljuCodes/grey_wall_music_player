import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:on_audio_query/on_audio_query.dart';

AssetsAudioPlayer audioplayer1 = AssetsAudioPlayer();

List<Audio> toAudio(List<SongModel> sM) {
  print("11 ${sM.toString()}");
  List<Audio> audioList = [];
  for (var songModel in sM) {
    audioList.add(Audio.file(songModel.data,
        metas: Metas(
          title: songModel.title,
          artist: songModel.artist,
          id: songModel.id.toString(),
        )));
  }
  print("11 ${audioList.toString()}");
  return audioList;
}
