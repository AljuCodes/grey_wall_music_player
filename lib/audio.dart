import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:on_audio_room/on_audio_room.dart';

List<Audio> plList=[
Audio("assets/audios/country.mp3",metas: Metas(
  
            title:  "Country",
            artist: "Florent Champigny",
            album: "CountryAlbum",
             
            image: MetasImage.asset("assets/images/country.jpg"), //can be MetasImage.network
          ),
          
          ),

Audio("assets/audios/electronic.mp3",metas: Metas(
            title:  "electronic",
            artist: "Florent Champigny",
            album: "CountryAlbum",
            image: MetasImage.asset("assets/images/country.jpg"), //can be MetasImage.network
          ),
          
          ),
          
Audio("assets/audios/hiphop.mp3",metas: Metas(
            title:  "hiphop",
            artist: "Florent Champigny",
            album: "CountryAlbum",
            image: MetasImage.asset("assets/images/country.jpg"), //can be MetasImage.network
          ),
          
          ),
          
Audio("assets/audios/pop.mp3",metas: Metas(
            title:  "pop",
            artist: "Florent Champigny",
            album: "CountryAlbum",
            image: MetasImage.asset("assets/images/country.jpg"), //can be MetasImage.network
          ),
          
          ),
          
Audio("assets/audios/water.mp3",metas: Metas(
            title:  "water",
            artist: "Florent Champigny",
            album: "CountryAlbum",
            image: MetasImage.asset("assets/images/country.jpg"), //can be MetasImage.network
          ),
          
          ),

];
AssetsAudioPlayer audioplayer1 = AssetsAudioPlayer();

