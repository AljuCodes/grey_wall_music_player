// import 'package:flutter/material.dart';
// import 'package:grey_wall/models/boxmodels.dart';
// import 'package:grey_wall/widgets/song_widget.dart';
// import 'package:hive_flutter/hive_flutter.dart';

// import 'main.dart';


// class SongsTab extends StatefulWidget {
//   const SongsTab({Key? key}) : super(key: key);

//   @override
//   _SongsTabState createState() => _SongsTabState();
// }

// class _SongsTabState extends State<SongsTab> {
//   final TextEditingController _textEditingController = TextEditingController();
//   String searchingTerm = "";

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         // search 
//         Padding(
//           padding: const EdgeInsets.symmetric(
//             horizontal: 16.0,
//           ),
//           child: SizedBox(
//             height: 48.0,
//             child: TextFormField(
//               controller: _textEditingController,
//               onChanged: (value) {
//                 setState(() {
//                   searchingTerm = value;
//                 });
//               },
//               decoration: const InputDecoration(
//                 border: OutlineInputBorder(),
//                 hintText: "SEARCH SONGS",
//                 hintStyle: TextStyle(
//                   fontSize: 12.0,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 1.0,
//                 ),
//                 prefixIcon: Icon(
//                   Icons.search,
//                   color: Colors.deepPurple,
//                 ),
//               ),
//             ),
//           ),
//         ),
//         (searchingTerm.isEmpty)
//             ? ValueListenableBuilder<Box<SongBoxModel>>(
//                 valueListenable: hiveCtrl.getSongBox().listenable(),
//                 builder: (context, box, _) {
//                   final songs = box.values.toList().cast<SongBoxModel>();
//                   songs.sort((a, b) => a.songTitle.compareTo(b.songTitle));
//                   if (songs.isEmpty) {
//                     return const Center(
//                       child: Text(
//                         "NO SONGS FOUND",
//                       ),
//                     );
//                   } else {
//                     return Expanded(
//                       child: RefreshIndicator(
//                         onRefresh: hiveCtrl.fetchAllsongs,
//                         child: ListView.builder(
//                           itemCount: songs.length,
//                           itemBuilder: (context, index) {
//                             return songwidget(song: song, audioList: audioList)
//                           },
//                         ),
//                       ),
//                     );
//                   }
//                 },
//               )
//             : ValueListenableBuilder<Box<SongBoxModel>>(
//                 valueListenable: hiveCtrl.getSongBox().listenable(),
//                 builder: (context, box, _) {
//                   final filtered = box.values
//                       .where((song) => song.songTitle
//                           .toLowerCase()
//                           .startsWith(searchingTerm))
//                       .toList()
//                       .cast<SongBoxModel>();
//                   if (filtered.isEmpty) {
//                     return const Center(
//                       child: Text(
//                         "NO SONGS FOUND",
//                       ),
//                     );
//                   } else {
//                     return Expanded(
//                       child: ListView.builder(
//                         itemCount: filtered.length,
//                         itemBuilder: (context, index) {
//                           return songwidget(song: song, audioList: audioList)
                       
//                         },
//                       ),
//                     );
//                   }
//                 },
//               )
//       ],
//     );
//   }
// }
