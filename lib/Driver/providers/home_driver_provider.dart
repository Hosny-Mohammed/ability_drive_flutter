import 'package:flutter/material.dart';
import '../models/driver_model.dart';
import '../models/rides_model.dart';
import '../services/home_service.dart';

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
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
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
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> toggleAvailability(int driverId, bool newValue) async {
    try {
      final success = await HomeService.changeAvailability(
        driverId: driverId,
        availability: newValue,
      );

      if (success) {
        _availability = newValue;
        if (newValue) {
          await fetchRides(driverId);
        }
        notifyListeners();
      }
      return success;
    } catch (e) {
      print("Error toggling availability: $e");
      return false;
    }
  }

  Future<bool> updateRideStatus(int rideId, String status, String reason) async {
    try {
      final success = await HomeService.updateRideStatus(
        rideId: rideId,
        status: status,
        reason: reason,
      );

      if (success) {
        final index = _rides.indexWhere((ride) => ride.id == rideId);
        if (index != -1) {
          _rides[index] = _rides[index].copyWith(
            status: status,
            reason: reason,
          );
          notifyListeners();
        }
      }
      return success;
    } catch (e) {
      print("Error updating ride status: $e");
      return false;
    }
  }

  // New: Update driver's location
  Future<bool> updateDriverLocation(int driverId, String location) async {
    try {
      final success = await HomeService.updateDriverLocation(
        driverId: driverId,
        location: location,
      );
      if (success) {
        // Optionally update the driver's location locally if your model supports it.
        if (_driver != null) {
          _driver = _driver!.copyWith(location: location);
        }
        notifyListeners();
      }
      return success;
    } catch (e) {
      print("Error updating location: $e");
      return false;
    }
  }
}
