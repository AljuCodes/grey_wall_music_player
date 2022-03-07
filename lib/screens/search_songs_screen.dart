import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:grey_wall/widgets/song_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../audio.dart';
import '../logic/song_bloc/songbloc_bloc.dart';

class SearchScreen extends StatelessWidget {
  final TextEditingController _textEditingController = TextEditingController();
  String searchingTerm = "";
  final List<dynamic> listOfSongMOdel = [];

  SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<SongBloc>(context).add(SongEvent.load());
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // search box
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 40, left: 15, right: 15),
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: const Color(0xffc4c5c5)),
              child: Stack(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                          margin: const EdgeInsets.only(),
                          child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(
                                Icons.arrow_back,
                                size: 35,
                              ))),
                      Container(
                        child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.search,
                              size: 30,
                            )),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 11,
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      margin: const EdgeInsets.only(
                        left: 40,
                      ),
                      width: width * .63,
                      child: TextFormField(
                        controller: _textEditingController,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.only(top: 24),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.black)),
                          alignLabelWithHint: true,
                          hintStyle: TextStyle(
                            color: Colors.white60,
                          ),
                        ),
                        cursorColor: Colors.black,
                        showCursor: false,
                        onChanged: (value) async {
                          BlocProvider.of<SongBloc>(context)
                              .add(SongEvent.search(query: value));
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: height * .85,
              child: BlocBuilder<SongBloc, List<SongModel>>(
                builder: (context, List<SongModel> state) {
                  // Loading content
                  if (state == null) return const CircularProgressIndicator();
                  if (state.isEmpty) return const Text("Nothing found!");

                  List<SongModel> songModelList = state;

                  List<Audio> audioList = toAudio(songModelList);
                  return ListView.builder(
                    itemCount: songModelList.length,
                    itemBuilder: (context, index) {
                      return SongWidget(
                        audioList: [
                          Audio.file(songModelList[index].data,
                              metas: Metas(
                                artist: songModelList[index].artist,
                                title: songModelList[index].title,
                                id: songModelList[index].id.toString(),
                              ))
                        ],
                        song: songModelList[index],
                        artistName: songModelList[index].artist!,
                        index: 0,
                        songName: songModelList[index].title,
                      );
                    },
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

Future<List<dynamic>> uu(String name) async {
  List<dynamic> something = await OnAudioQuery().queryWithFilters(
    name,
    WithFiltersType.AUDIOS,
    args: AudiosArgs.TITLE,
  );
  return something;
}
