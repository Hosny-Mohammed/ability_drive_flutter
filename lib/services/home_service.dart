import 'package:dio/dio.dart';
import 'package:ability_drive_flutter/models/bus_schedule_model.dart';

class HomeService {
  static Dio dio = Dio();

  static Future<List<dynamic>?> fetchData() async {
    try {
      Response response = await dio.get('https://abilitydrive.runasp.net/api/Ride/bus-schedules');
      if (response.statusCode == 200) {
        var model = BusScheduleModel.fromJson(response.data);
        if (model.status) {
          return model.data; // Return the list of bus schedules directly
        }
      }
      return null;
    } catch (ex) {
      print("Error: $ex");
      return null;
    }
  }
}
