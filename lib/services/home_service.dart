import 'package:dio/dio.dart';
import 'package:ability_drive_flutter/models/bus_schedule_model.dart';
import 'package:flutter/foundation.dart';

class HomeService {
  static Dio dio = Dio();

  static Future<List<dynamic>?> fetchData() async {
    try {
      Response response = await dio.get('https://abilitydrive.runasp.net/api/Ride/bus-schedules');
      if (response.statusCode == 200 && response.data != null) {
        var model = BusScheduleModel.fromJson(response.data);
        if (model.status) {
          return model.data; // Ensure `data` is a list and properly structured.
        }
      }
      return [];
    } catch (ex) {
      if (kDebugMode) {
        print("Error: $ex");
      }
      return [];
    }
  }


  static Future<bool> bookRide({required int userId,required int busScheduleId })async{
    try{
      Response response = await dio.patch('https://abilitydrive.runasp.net/api/Ride/bus/$userId/$busScheduleId');
      if(response.statusCode == 200 && response.data['status'] == true){
        return response.data['status'];
      }
      return false;
    }catch(ex){
      if (kDebugMode) {
        print("Error:$ex");
        return false;
      }
    }
    return false;
  }
}
