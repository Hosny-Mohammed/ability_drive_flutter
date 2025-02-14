import 'package:ability_drive_flutter/services/auth_service.dart';
import 'package:ability_drive_flutter/models/user_model.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  UserModel? model;
  SnackBar? registrationSnackbar;
  bool? registrationStatus;
  SnackBar? loginSnackbar;
  bool? loginStatus;

  Future<void> registration({required String phone, required String email, required String firstName, required String lastName, required String password, required bool isDisabled}) async {

    model = await AuthService.registration(phone: phone, email: email, firstName: firstName, lastName: lastName, password: password, isDisabled: isDisabled);

    registrationStatus = model != null;
    if(registrationStatus!){
      registrationSnackbar = SnackBar(
        content: Text('Registration successful! Welcome, ${model!.name}!'),
        backgroundColor: Colors.green, // Green for success
      );
      notifyListeners();
    }else{
      registrationSnackbar = const SnackBar(
        content: Text('Registration failed. Please try again.'),
        backgroundColor: Colors.red, // Red for failure
      );
      notifyListeners();
    }
    notifyListeners();
  }

  Future<void> logIn({required String phone, required String password})async{
    model = await AuthService.logIn(phone: phone, password: password);

    loginStatus = model != null;
    if(loginStatus!){
      loginSnackbar = const SnackBar(
        content: Text('Login successful! Welcome back!'),
        backgroundColor: Colors.green, // Green for success
      );
      notifyListeners();
    }else{
      loginSnackbar = const SnackBar(
        content: Text('Login failed. Please check your credentials.'),
        backgroundColor: Colors.red, // Red for failure
      );
      notifyListeners();
    }
    notifyListeners();
  }
}
