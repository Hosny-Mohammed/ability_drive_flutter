import 'package:flutter/material.dart';
import 'package:ability_drive_flutter/services/private_ride_service.dart';

class DriversProvider with ChangeNotifier {
  List<dynamic> availableDrivers = [];
  bool _isLoading = false;
  double? cost;

  bool get isLoading => _isLoading;

  Future<void> fetchAvailableDrivers({
    required String preferredLocation,
    required String lastKnownLocation,
  }) async {
    _isLoading = true;
    notifyListeners();

    var data = await PrivateRideService.fetchData(
      preferredLocation: preferredLocation,
      lastKnownLocation: lastKnownLocation,
    );

    availableDrivers = data ?? [];
    _isLoading = false;
    notifyListeners();
  }

  /// Book a ride and return the ride object.
  Future<Map<String, dynamic>?> bookRide({
    required int userId,
    required int driverId,
    required String pickupLocation,
    required String destination,
  }) async {
    var ride = await PrivateRideService.bookRide(
      userId: userId,
      driverId: driverId,
      pickupLocation: pickupLocation,
      destination: destination,
    );
    if (ride != null) {
      cost = ride['cost'];
    }
    notifyListeners();
    return ride;
  }

  /// Check ride status for a given rideId.
  Future<Map<String, dynamic>?> checkRideStatus({
    required int rideId,
  }) async {
    return await PrivateRideService.checkRideStatus(rideId: rideId);
  }
}
