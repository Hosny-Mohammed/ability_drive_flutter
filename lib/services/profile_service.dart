import 'package:ability_drive_flutter/models/user_model.dart';
import 'package:dio/dio.dart';

class ProfileService{
  static Dio dio = Dio();

  static Future<UserModel?> getUser({required int userId})async{
    try{
      Response response = await dio.get('https://abilitydrive.runasp.net/api/User/$userId');
      var model = UserModel.getJson(response.data);
      if(response.statusCode == 200 && model.status == true){
        return model;
      }
      return null;
    }catch(ex){
      print("Error:$ex");
      return null;
    }
  }
}