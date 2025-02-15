// home_provider.dart
import 'package:flutter/material.dart';
import 'package:ability_drive_flutter/Driver/models/driver_model.dart';
import 'package:ability_drive_flutter/Driver/models/rides_model.dart';
import 'package:ability_drive_flutter/Driver/services/home_service.dart';

class HomeDriverProvider extends ChangeNotifier {
  Driver? _driver;
  List<Ride> _rides = [];
  bool _isLoading = false;
  bool _availability = false;

  Driver? get driver => _driver;
  List<Ride> get rides => _rides;
  bool get isLoading => _isLoading;
  bool get availability => _availability;

  Future<void> fetchDriverInfo(int driverId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await HomeService.getDriverInfo(driverId: driverId);
      _driver = response.driver;
      _availability = _driver?.isAvailable ?? false;
    } catch (e) {
      print("Error fetching driver info: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchRides(int driverId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await HomeService.fetchRides(driverId: driverId);
      if (response != null && response.status) {
        _rides = response.rides;
      }
    } catch (e) {
      print("Error fetching rides: $e");
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> toggleAvailability(int driverId, bool newValue) async {
    final success = await HomeService.changeAvailability(
      driverId: driverId,
      availability: newValue,
    );

    if (success) {
      _availability = newValue;
      if (newValue) fetchRides(driverId);
      notifyListeners();
    }
  }

  Future<void> updateRideStatus(int rideId, String status, String reason) async {
    final success = await HomeService.updateRideStatus(
      rideId: rideId,
      status: status,
      reason: reason,
    );

    if (success) {
      _rides.removeWhere((ride) => ride.id == rideId);
      notifyListeners();
    }
  }
}