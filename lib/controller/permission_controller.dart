

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grey_wall/main.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PermissionController extends GetxController {
  bool permissionStatus = false;
  bool notification = false;
  GetStorage storage = GetStorage();
  @override
  void onInit() {

    // TODO: implement onInit

    permissionStatus = storage.read('permission') ?? false;
    notification = storage.read("notification" )??false;
    super.onInit();
  }
    Future<void> getNotificationStatus() async {
    notification= permissionCtrl.storage.read('notification')??true;
  }

  Future<void> getPermissionStatus({VoidCallback? fnn}) async{

    if(permissionStatus){
      fnn==null?null:fnn();
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
bool getNotification(){
  return notification;
}
bool changeNotify(bool value){
  notification = value;
  storage.write("notification", value);
  return notification;

}
}
