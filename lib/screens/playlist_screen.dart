import 'package:flutter/material.dart';
import 'package:grey_wall/screens/details_screen/playlist_detail_screen.dart';

class playlistScreen extends StatelessWidget {
  playlistScreen({Key? key}) : super(key: key);
  final List<Map> myProduct = List.generate(
      10,
      (index) => {
            "id": index,
            "name": "Product $index",
          });
           final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _textEditingController = TextEditingController();


  Future<void> showInformationDialog(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) {
          bool isChecked = false;
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              content: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: _textEditingController,
                        validator: (value) {
                          return value!.isNotEmpty ? null : "Enter any text";
                        },
                        decoration:
                            const InputDecoration(hintText: "playlist Name"),
                      ),
                     
                    ],
                  )),
              title: const Text('Create new playlist'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Do something like updating SharedPreferences or User Settings etc.
                      Navigator.of(context).pop();
                    }},  child: const Text('OK   '), ),
          
              ],
            );
          });
        });
  }
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: () async {
                await showInformationDialog(context);
              },
            child: Stack(
              children:[
                Container(
                  
                  margin: const EdgeInsets.all(8),
                  width: 79,
                  height: 33,
                  // padding: EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.all(Radius.circular(28))),
                  child:
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Container(
                      margin: const EdgeInsets.only(left: 4),
                      child: const Text(
                        "New",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 17
                           ),
                      ),
                    ),
                    const Icon(
                      Icons.add_circle,
                      size: 35,
                      color: Colors.black,
                    ),
                  ])),] 
            ),
          ),
        ],
        title: const Text('Playlists'),
      ),
      body: Container(
        height: height * .81,
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 280,
            childAspectRatio: 1 / 1.3,
            crossAxisSpacing: 27,
          ),
          itemCount: myProduct.length,
          itemBuilder: (BuildContext ctx, index) {
            return InkWell(
              onTap: (() => Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>PlaylistDetailScreen("Name$index") ))),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
            
                    margin: const EdgeInsets.only(top:5),
                    height: height * .21,
                    width: height * .21,
                    decoration: const BoxDecoration(
                        color: const Color(0xffc4c5c5),
                        borderRadius: const BorderRadius.all(Radius.circular(18))),
                    child: const Icon(
                      Icons.music_note,
                      size: 50,
                    ),
                  ),
                  // The Text
                  Container(
                    margin: const EdgeInsets.only(left: 13),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name$index",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "Total $index songs",
                          style: const TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
