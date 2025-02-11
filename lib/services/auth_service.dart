
import 'package:dio/dio.dart';

import '../models/user_model.dart';

class AuthService {
  static Dio dio = Dio();

  static Future<UserModel> registration({required String phone, required String email, required String firstName, required String lastName, required String password, required bool isDisabled})async{
    try{
      Map credential = {
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phone,
        "email": email,
        "password": password,
        "isDisabled":isDisabled
      };

      Response response = await dio.post('https://localhost:7249/api/User/register', data: credential);

      if(response.statusCode == 200){
        var model = UserModel.getJson(response.data);
        if(model.status){
          return model;
        }
        throw("Couldn't Sign Up");
      }
      throw("Couldn't Sign Up");
    }catch(ex){
      throw('Error:$ex');
    }
  }

  static Future<int> logIn({required String phone, required String password})async{
    try{
      Map credential = {
        "phoneNumber": phone,
        "password": password
      };
      Response response = await dio.post('https://localhost:7249/api/User/login', data: credential);

      if(response.statusCode == 200 && response.data['status']){
        return response.data['userId'];
      }
      throw("Couldn't login");
    }catch(ex){
      throw('Error:$ex');
    }
  }
}