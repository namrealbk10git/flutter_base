import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:vo247_ios/res/strings.dart';

class AppPermissionRequest{

  AppPermissionRequest.__internal();
  static  AppPermissionRequest _instance ;
  factory AppPermissionRequest(){
    return _instance?? new AppPermissionRequest.__internal();
  }

  static const Permission permissionCamera = Permission.camera; // yet use
  static const Permission permissionStorage = Permission.storage; // yet use
  static const Permission permissionLocation = Permission.accessMediaLocation; // yet use
  static const Permission permissionMicrophone = Permission.microphone; // yet use
  Future<bool> getPermission(Permission permission ,BuildContext context) async{
    try{
      var status = await permission.status;
      if(await checkPermissionStatus(null, status, null)){
        return true;
      }else{
        var permissionStatusRequest =   await permission.request();
        return checkPermissionStatus(permission, permissionStatusRequest, context);
      }
    }catch(err, stack){
      // MyFirebaseCrashlytics().recordError(err, stack: stack ,keyReason: 'Permission/${permission.toString()}');
      return false;
    }
  }


  Future<bool> checkPermissionStatus(Permission permission, PermissionStatus  permissionStatus, BuildContext context)async{
    switch (permissionStatus) {
      case PermissionStatus.granted:
      // Application has been given permission to use the feature.
        return true;
        break;
      case PermissionStatus.denied:
      // Application has been denied permission to use the feature.
        return false;
        break;
      case PermissionStatus.undetermined:
      // No action perform for the permissions.
        return false;
        break;
      case PermissionStatus.restricted:
      // iOS has restricted access to a specific feature.
        return false;
        break;
      case PermissionStatus.permanentlyDenied:
        String per;
        switch (permission){
          case permissionCamera:
            per = AppStrings.per_camera;
            break;
          case permissionStorage:
            per =  AppStrings.per_storage;
            break;
          case permissionLocation:
            per =  AppStrings.per_accessMediaLocation;
            break;
          case permissionMicrophone:
            per =  AppStrings.per_microphone;
            break;
          default:
            return false;
        }
        _askLoginNow(
          context,
          message: per,
        );
        return false;
        break;
      default:
        return false;
    }
  }

  void _askLoginNow( BuildContext context, {String message}){
    if(context == null) {return;}

    // ShowNotification.showDialog(
    //     context,
    //     alertType: ShowNotification.typeWarning,
    //     title: "$ask_permission_head $ask_permission_tail",
    //     desc: message,
    //     btnText1: "Cài đặt",
    //     btnClick1: ()async{
    //       /// go to settings
    //       final AndroidIntent intent = AndroidIntent(
    //         action: 'action_application_details_settings',
    //         data: 'package:vn.bk247.mo247', // replace com.example.app with your applicationId
    //       );
    //       await intent.launch();
    //     },
    //     btnText2: "Quay lại",
    //     btnClick2: ()=>null,
    //     closeFunction: (){
    //
    //     }
    //     );
  }
}