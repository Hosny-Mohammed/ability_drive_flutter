import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ability_drive_flutter/services/private_ride_service.dart';

class DriversProvider with ChangeNotifier {
  List<dynamic> allDrivers = []; // All drivers fetched from the API
  List<dynamic> availableDrivers = []; // Filtered drivers displayed to the user
  bool _isLoading = false;
  double? cost;
  bool get isLoading => _isLoading;

  /// Fetch all drivers from the API and optionally filter them
  Future<void> fetchAvailableDrivers({String filterValue = ''}) async {
    _isLoading = true;
    notifyListeners();

    if (allDrivers.isEmpty) {
      // Fetch drivers only if not already fetched
      var data = await PrivateRideService.fetchData();
      _isLoading = false;

      if (data != null) {
        allDrivers = data;
        availableDrivers = allDrivers; // Initially, show all drivers
      } else {
        allDrivers = [];
        availableDrivers = [];
      }
    }

    // Filter drivers based on the input value
    availableDrivers = allDrivers.where((driver) {
      String pickupLocation = (driver['lastKnownLocation'] ?? '').toLowerCase();
      return pickupLocation.contains(filterValue.toLowerCase());
    }).toList();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> bookRide({required int userId,required int driverId,required String pickupLocation,required String destination}) async{
    cost = await PrivateRideService.bookRide(userId: userId, driverId: driverId, pickupLocation: pickupLocation, destination: destination);
  }
}

