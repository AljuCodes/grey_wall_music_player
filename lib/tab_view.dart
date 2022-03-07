import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grey_wall/logic/index_bloc/index_bloc.dart';
import 'package:grey_wall/main.dart';
import 'package:grey_wall/screens/favorites_screen.dart';
import 'package:grey_wall/screens/home_screen.dart';
import 'package:grey_wall/screens/playlist_screen.dart';

class TabContainerBottom extends StatelessWidget {
  final listScreens = [HomeScreen(), playlistScreen(), FavoritesScreen()];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<IndexBloc, int>(
      builder: (context, state) {
        return Scaffold(
          body: listScreens[state],
          bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.grey[400],
              backgroundColor: Theme.of(context).primaryColor,
              currentIndex: state,
              onTap: (int index) {
                hiveCtrl.setIndex(index);
                BlocProvider.of<IndexBloc>(context).add(IndexEvent.load());
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
      },
    );
  }
}
