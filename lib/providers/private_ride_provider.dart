import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ability_drive_flutter/services/private_ride_service.dart';

class DriversProvider with ChangeNotifier {
  List<dynamic> availableDrivers = []; // Drivers fetched from the API
  bool _isLoading = false;
  double? cost;

  bool get isLoading => _isLoading;

  /// Fetch available drivers from the API
  Future<void> fetchAvailableDrivers({required String preferredLocation,required String lastKnownLocation}) async {
    _isLoading = true;
    notifyListeners();

    var data = await PrivateRideService.fetchData(
      preferredLocation: preferredLocation,
      lastKnownLocation: lastKnownLocation,
    );

    if (data != null) {
      availableDrivers = data;
    } else {
      availableDrivers = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  /// Book a ride
  Future<void> bookRide({
    required int userId,
    required int driverId,
    required String pickupLocation,
    required String destination,
  }) async {
    cost = await PrivateRideService.bookRide(
      userId: userId,
      driverId: driverId,
      pickupLocation: pickupLocation,
      destination: destination,
    );
    notifyListeners();
  }
}
