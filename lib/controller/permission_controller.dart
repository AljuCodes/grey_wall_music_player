

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grey_wall/main.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PermissionController extends GetxController {
  bool permissionStatus = false;
  GetStorage storage = GetStorage();
  @override
  void onInit() {
    // TODO: implement onInit
    permissionStatus = storage.read('permission') ?? false;
    super.onInit();
  }

  Future<void> getPermissionStatus() async{
    if(permissionStatus){
      hiveCtrl.fetchAllsongs();
    }else{
      await askPermission();
    }
  }

  Future<void> askPermission()async {
    if(!kIsWeb){
      bool currentStatus = await OnAudioQuery().permissionsStatus();
      if(currentStatus){
        storage.write('permission', true);
        hiveCtrl.fetchAllsongs();
      }else{
        bool nowStatus = await OnAudioQuery().permissionsRequest();
        if(nowStatus){
          storage.write('permission', true);
          hiveCtrl.fetchAllsongs();
        }else{
          storage.write('permission', false);
        }
      }
    }
  }
}
