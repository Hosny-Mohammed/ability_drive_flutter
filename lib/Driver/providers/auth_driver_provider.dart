import 'package:ability_drive_flutter/Driver/services/auth_driver_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AuthDriverProvider extends ChangeNotifier{
  SnackBar? loginSnackbar;
  String? driverName;
  String? driverId;

  Future<void> login({required String licenseNumber, required String password})async{
    var response = await AuthDriverService.login(licenseNumber: licenseNumber, password: password);
    if(response != null){
      driverName = response['driverName'];
      driverId = response['driverId'];
      loginSnackbar = SnackBar(content: Text("Welcome back, $driverName"), backgroundColor: Colors.green,);
    }else{
      loginSnackbar = const SnackBar(content: Text("Login failed. Please check your credentials."), backgroundColor: Colors.red,);
    }
    notifyListeners();
  }
}