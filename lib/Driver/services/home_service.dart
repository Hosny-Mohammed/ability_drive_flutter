import 'package:ability_drive_flutter/Driver/models/driver_model.dart';
import 'package:dio/dio.dart';

import '../models/rides_model.dart';

class HomeService{
  static Dio dio = Dio();
  static Future<RideResponse?> fetchRides({required int driverId})async{
    try{
      Response response = await dio.get('https://abilitydrive.runasp.net/api/Ride/available-rides', queryParameters: {
        "driverId" : driverId
      });
      if(response.statusCode == 200){
        var model = RideResponse.fromJson(response.data);
        return model;
      }
      return null;
    }catch(ex){
      print("Error$ex");
      return null;
    }
  }

  static Future<bool> changeAvailability({required int driverId,required bool availability})async{
    Response response = await dio.put('https://abilitydrive.runasp.net/api/driver/availability/$driverId', queryParameters: {
      "isAvailable" : availability
    });
    if(response.statusCode == 200){
      return true;
    }
    return false;
  }

  static Future<DriverResponse> getDriverInfo({required int driverId})async{
    Response response = await dio.get('https://abilitydrive.runasp.net/api/driver/profile/$driverId');
    var model = DriverResponse.fromJson(response.data);
    return model;
  }
}