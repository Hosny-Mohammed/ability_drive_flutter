import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../models/user_model.dart';

class AuthService {
  static final Dio dio = Dio(); // Initialize Dio only once.

  // Registration Method returns a Map with model and message
  static Future<Map<String, dynamic>> registration({
    required String phone,
    required String email,
    required String firstName,
    required String lastName,
    required String password,
    required bool isDisabled,
  }) async {
    try {
      Map<String, dynamic> credential = {
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phone,
        "email": email,
        "password": password,
        "isDisabled": isDisabled,
      };

      // Make POST request
      Response response = await dio.post(
        'https://abilitydrive.runasp.net/api/User/register',
        data: credential,
      );

      // Check response status
      if (response.statusCode == 200) {
        var responseData = response.data;
        // If the API returns status true, parse and return the model with message.
        if (responseData["status"] == true) {
          var model = UserModel.getJson(responseData);
          return {"model": model, "message": responseData["message"]};
        } else {
          // When registration fails, return null model along with the error message.
          return {"model": null, "message": responseData["message"]};
        }
      }
      return {"model": null, "message": "Unexpected response. Please try again later."};
    } catch (ex) {
      if (kDebugMode) {
        print('Registration Error: $ex');
      }
      return {
        "model": null,
        "message": "An error occurred. Please check your connection and try again."
      };
    }
  }

  // Login Method returns a Map with model and message
  static Future<Map<String, dynamic>> logIn({
    required String phone,
    required String password,
  }) async {
    try {
      Map<String, dynamic> credential = {
        "phoneNumber": phone,
        "password": password,
      };

      // Make POST request
      Response response = await dio.post(
        'https://abilitydrive.runasp.net/api/User/login',
        data: credential,
      );

      // Check response status
      if (response.statusCode == 200) {
        var responseData = response.data;
        if (responseData["status"] == true) {
          var model = UserModel.getJson(responseData);
          return {"model": model, "message": responseData["message"]};
        } else {
          return {"model": null, "message": responseData["message"]};
        }
      }
      return {"model": null, "message": "Unexpected response. Please try again later."};
    } catch (ex) {
      if (kDebugMode) {
        print('Login Error: $ex');
      }
      return {
        "model": null,
        "message": "An error occurred. Please check your connection and try again."
      };
    }
  }
}
