import 'package:flutter/material.dart';
import 'package:grey_wall/widgets/song_widget.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 40, left: 15, right: 15),
              padding: const EdgeInsets.all(10),
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
                          child: IconButton(onPressed: (){
                            Navigator.of(context).pop();
                          }
                            ,icon:const Icon(Icons.arrow_back,
                            size: 35,
                          ))),
                      Container(
                        child: IconButton(
                            onPressed: () {}, icon: const Icon(Icons.search,size: 30,)),
                      ),
                    ],
                  ),
                      Positioned(
                        bottom: 11,
                        child: Container(
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.only(left:40,),
                            width: width * .63,
                            child: TextFormField(
                                decoration: const InputDecoration(
                          
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
                           
                              onChanged: (bool) {},
                            ),
                          ),
                      ),
                ],
      
              ),
            ),
            const SizedBox(height: 30,),
            songwidget(song: [] as SongModel,audioList: [],),
            songwidget(song: [] as SongModel,audioList: [],),
            songwidget(song: [] as SongModel,audioList: [],)
          ],
        ),
      ),
    );
  }
}
