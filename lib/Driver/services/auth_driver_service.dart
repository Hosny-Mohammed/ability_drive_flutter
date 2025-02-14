import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AuthDriverService{
  static Dio dio = Dio();
  static Future<Map<String, dynamic>?> login({required String licenseNumber, required String password})async{
    try{
      Map credentials = {
        "licenseNumber": licenseNumber,
        "password": password
      };
      Response response = await dio.post('https://abilitydrive.runasp.net/api/driver/login', data: credentials);
      if(response.statusCode == 200 && response.data['status'] == true){
        return{
          "driverId": response.data['driverId'],
          "driverName": response.data['driverName']
        };
      }
      return null;
    }catch(ex){
      if (kDebugMode) {
        print("Error:$ex");
      }
      return null;
    }
  }
}