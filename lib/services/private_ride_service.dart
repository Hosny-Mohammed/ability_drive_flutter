import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../models/driver_profile_model.dart';

class PrivateRideService{
  static Dio dio = Dio();
  
  static Future<List<dynamic>?> fetchData() async{
    try{
      Response response = await dio.get('https://abilitydrive.runasp.net/api/driver/available-drivers');
      if(response.statusCode == 200){
        var model = DriverProfileModel.getJson(response.data);
        if(model.status){
          return model.data;
        }
        return null;
      }
      return null;
    }catch(ex){
      if (kDebugMode) {
        print('Error;$ex');
      }
      return null;
    }

  }

  static Future<double> bookRide({required int userId,required int driverId,required String pickupLocation,required String destination}) async{
    try{
      Map data = {
        "pickupLocation": pickupLocation,
        "destination": destination
      };
      Response response = await dio.post('https://abilitydrive.runasp.net/api/Ride/private/$userId/driver/$driverId', data: data);
      if(response.statusCode == 200 && response.data['status'] == true){
        return response.data['ride']['cost'];
      }
      return 0.0;
    }catch(ex){
      if (kDebugMode) {
        print('Error:$ex');
      }
      return 0.0;
    }
  }
}