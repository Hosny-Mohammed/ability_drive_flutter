import 'package:flutter/material.dart';
import 'package:ability_drive_flutter/services/auth_service.dart';
import 'package:ability_drive_flutter/models/user_model.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? model;
  SnackBar? registrationSnackbar;
  bool? registrationStatus;
  SnackBar? loginSnackbar;
  bool? loginStatus;

  Future<void> registration({
    required String phone,
    required String email,
    required String firstName,
    required String lastName,
    required String password,
    required bool isDisabled,
  }) async {
    var result = await AuthService.registration(
      phone: phone,
      email: email,
      firstName: firstName,
      lastName: lastName,
      password: password,
      isDisabled: isDisabled,
    );

    model = result["model"];
    registrationStatus = model != null;
    // Use the message from the API response regardless of success or failure.
    if (registrationStatus!) {
      registrationSnackbar = SnackBar(
        content: Text('Registration successful! Welcome, ${model!.name}!'),
        backgroundColor: Colors.green, // Green for success
      );
    } else {
      registrationSnackbar = SnackBar(
        content: Text(result["message"] ?? 'Registration failed. Please try again.'),
        backgroundColor: Colors.red,
      );
    }
    notifyListeners();
  }

  Future<void> logIn({required String phone, required String password}) async {
    var result = await AuthService.logIn(
      phone: phone,
      password: password,
    );

    model = result["model"];
    loginStatus = model != null;
    if (loginStatus!) {
      loginSnackbar = SnackBar(
        content: Text(result["message"]),
        backgroundColor: Colors.green,
      );
    } else {
      loginSnackbar = SnackBar(
        content: Text(result["message"] ?? 'Login failed. Please check your credentials.'),
        backgroundColor: Colors.red,
      );
    }
    notifyListeners();
  }
}