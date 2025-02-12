import 'package:flutter/material.dart';
import 'package:ability_drive_flutter/services/home_service.dart';

class HomeProvider extends ChangeNotifier {
  List<dynamic> allBuses = [];
  List<dynamic> filteredBuses = [];
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> fetchData(String filterValue) async {
    _isLoading = true;
    notifyListeners();

    var data = await HomeService.fetchData(); // Replace with actual API call

    _isLoading = false;
    if (data != null) {
      allBuses = data;
      filteredBuses = allBuses.where((bus) {
        String fromLocation = (bus['fromLocation'] ?? '').toLowerCase();
        return fromLocation.contains(filterValue.toLowerCase());
      }).toList();
    }

    notifyListeners();
  }
}
