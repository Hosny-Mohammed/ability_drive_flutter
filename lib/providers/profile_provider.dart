import 'package:ability_drive_flutter/models/user_model.dart';
import 'package:ability_drive_flutter/services/profile_service.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  UserModel? model;
  bool isLoading = true;

  Future<void> getUser({required int userId}) async {
    isLoading = true;
    notifyListeners();

    try {
      model = await ProfileService.getUser(userId: userId);
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
