import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';

class Permission_Handler extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Permission Handler"),),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(onPressed: (){}, child: Text("Camera permission")),
            ElevatedButton(onPressed: (){}, child: Text("Multiple Permission")),
            ElevatedButton(onPressed: (){}, child: Text("Settings")),
          ],
        ),
      ),
    );
  }
  void requestCameraPermission() async {
    var status = await Permission.camera.status;
    if(status.isGranted){
      print("Perminssion is granded");
    }else if(status.isDenied){
      //cheack if the permission is already allowed
      if(await Permission.camera.request().isGranted){
        print("permission was granted");
      }
    }
  }
  void reuestMultiplePermission() async {
    Map<Permission,PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
      Permission.phone
    ].request();
    print("location permission : ${statuses[Permission.location]},"
        "storage permission : ${statuses[Permission.phone]}");
  }

  void requestPermissionWithOpenSettings() async {

    openAppSettings();
  }
}
