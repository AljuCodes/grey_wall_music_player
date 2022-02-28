import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:grey_wall/controller/hive_controller.dart';
import 'package:grey_wall/controller/permission_controller.dart';
import 'package:grey_wall/controller/player_controller.dart';
import 'package:grey_wall/screens/splash_screens.dart';
import 'package:grey_wall/tab_view.dart';
import 'package:on_audio_room/on_audio_room.dart';

final hiveCtrl = Get.put(HiveBoxController());
final permissionCtrl = Get.put(PermissionController());
//  final playerCtrl = Get.put(PlayerController());
final OnAudioRoom audioRoom1 = OnAudioRoom();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await hiveCtrl.boxInitiliaser();
  await GetStorage.init();
  await permissionCtrl.getPermissionStatus();

  await permissionCtrl.getNotificationStatus();
// await playerCtrl.initializeInitialPlaylist();
  await OnAudioRoom().initRoom();
//  await OnAudioRoom().initRoom(RoomType.FAVORITES,);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // primarySwatch: Colors.grey,
        primaryColor: Colors.black,
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
            overlayColor: MaterialStateProperty.all<Color>(Colors.grey),
          ),
        ),
        appBarTheme: AppBarTheme(
          color: Colors.black,
        ),
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context)
              .textTheme, // If this is not set, then ThemeData.light().textTheme is used.
        ),
      ),
      home:SplashScreen(),
    );
  }
}
