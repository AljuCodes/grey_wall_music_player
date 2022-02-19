import 'package:flutter/material.dart';
import 'package:grey_wall/widgets/song_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlaylistDetailScreen extends StatelessWidget {
  final String ArtistName;

  const PlaylistDetailScreen(this.ArtistName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(ArtistName),
        actions: [
          PopupMenuButton<int>(
            padding: const EdgeInsets.all(0),
            enableFeedback: true,
            shape: const RoundedRectangleBorder(
                borderRadius:
                    const BorderRadius.all(const Radius.circular(15))),
            itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () {},
                child: Column(
                  children: [
                    TextButton(
                      onPressed: () {
                        //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>StatefulDialog()));
                        Navigator.of(context).pop();
                      },
                      child: Text("edit playlist Name",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).primaryColor)),
                    ),
                    const Divider(
                      color: Colors.black,
                      thickness: 2,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("delete this playlist",
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).primaryColor)),
                    ),
                  ],
                ),
              )
            ],
            color: Colors.white,
            iconSize: 30,
          )
        ],
      ),
      body: Center(
        child: ListView.builder(
          itemBuilder: ((context, index) => songwidget(
                isPlaylist: true,
                song: [] as SongModel,
              )),
          itemCount: 10,
        ),
      ),
    );
  }
}
