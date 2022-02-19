import 'package:flutter/material.dart';
import 'package:grey_wall/screens/favorites_screen.dart';
import 'package:grey_wall/screens/home_screen.dart';
import 'package:grey_wall/screens/playlist_screen.dart';
import 'package:hive_flutter/hive_flutter.dart';
class TabContainerBottom extends StatefulWidget {
  TabContainerBottom({this.index1});
  int? index1;

  @override
  _TabContainerBottomState createState() => _TabContainerBottomState();
}

class _TabContainerBottomState extends State<TabContainerBottom> {
  int tabIndex = 0;

  late final List<Widget>? listScreens;
  @override
  void initState() {
    print("tabindex is $tabIndex");
    int? tabIndex1 = widget.index1;
    print("tabindex1 from widget is  is $tabIndex1");
    tabIndex = widget.index1 != null ? widget.index1! : 0;
    print("tabindex after checking $tabIndex");
    super.initState();
    listScreens = [HomeScreen(), playlistScreen(), FavoritesScreen()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: listScreens![tabIndex],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey[400],
          backgroundColor: Theme.of(context).primaryColor,
          currentIndex: tabIndex,
          onTap: (int index) {
            setState(() {
              tabIndex = index;
            });
          },
          items: [
            const BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: 'Home',
            ),
            const BottomNavigationBarItem(
              icon: const Icon(Icons.playlist_play_rounded),
              label: "Playlist",
            ),
            const BottomNavigationBarItem(
              icon: const Icon(Icons.favorite),
              label: "Favorites",
            ),
          ]),
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
