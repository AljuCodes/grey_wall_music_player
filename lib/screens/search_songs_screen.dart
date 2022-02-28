import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:grey_wall/main.dart';
import 'package:grey_wall/widgets/song_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../audio.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  String searchingTerm = "";
  List<dynamic> listOfSongMOdel = [];
  // List<SongModel> ls = [];
  // List<Audio> audioList = [];
  @override
  void initState() {
    _textEditingController.clear();
    // TODO: implement initState
    super.initState();
  }

  fn() async {
    listOfSongMOdel = await OnAudioQuery().querySongs();
  }

  @override
  Widget build(BuildContext context) {
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
                          setState(() {
                            searchingTerm = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(
              height: height * .85,
              child: (searchingTerm.isEmpty)
                  ? FutureBuilder<List<SongModel>>(
                      // Default values:
                      future: OnAudioQuery().querySongs(
                        sortType: SongSortType.DISPLAY_NAME,
                        orderType: OrderType.ASC_OR_SMALLER,
                      ),
                      builder: (context, item) {
                        // Loading content
                        if (item.data == null)
                          return const CircularProgressIndicator();
                        if (item.data!.isEmpty)
                          return const Text("Nothing found!");
                        List<SongModel> SongModelList = item.data!;
                        List<Audio> audioList = toAudio(SongModelList);
                        return ListView.builder(
                          itemCount: item.data!.length,
                          itemBuilder: (context, index) {
                            return songwidget(
                              audioList: [
                                Audio.file(SongModelList[index].data,
                                    metas: Metas(
                                      artist: SongModelList[index].artist,
                                      title: SongModelList[index].title,
                                      id: SongModelList[index].id.toString(),
                                    ))
                              ],
                              song: item.data![index],
                              artistName: item.data![index].artist!,
                              index: 0,
                              songName: item.data![index].title,
                            );
                          },
                        );
                      },
                    )
                  : FutureBuilder<List<SongModel>>(
                      // Default values:
                      future: OnAudioQuery().querySongs(
                        sortType: SongSortType.DISPLAY_NAME,
                        orderType: OrderType.ASC_OR_SMALLER,
                      ),
                      builder: (context, item) {
                        // Loading content
                        if (item.data == null)
                          return const CircularProgressIndicator();
                        if (item.data!.isEmpty)
                          return const Text("Nothing found!");
                        List<SongModel> allSongModel = item.data!;
                        List<SongModel> SongModelList = allSongModel
                            .where((song) => song.title
                                .toLowerCase()
                                .contains(searchingTerm))
                            .toList();

                        List<Audio> audioList = toAudio(SongModelList);
                        return ListView.builder(
                          itemCount: SongModelList.length,
                          itemBuilder: (context, index) {
                            return songwidget(
                              audioList: [
                                Audio.file(SongModelList[index].data,
                                    metas: Metas(
                                      artist: SongModelList[index].artist,
                                      title: SongModelList[index].title,
                                      id: SongModelList[index].id.toString(),
                                    ))
                              ],
                              song: SongModelList[index],
                              artistName: SongModelList[index].artist!,
                              index: 0,
                              songName: SongModelList[index].title,
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
