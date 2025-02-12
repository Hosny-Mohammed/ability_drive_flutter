import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ability_drive_flutter/services/home_service.dart';

class HomeProvider extends ChangeNotifier {
  List<dynamic> allBuses = [];
  List<dynamic> filteredBuses = [];
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  SnackBar? bookingSnack;
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

  Future<void> bookRide({required int userId, required int busScheduleId}) async {
    var bookingStatus = await HomeService.bookRide(userId: userId, busScheduleId: busScheduleId);

    if (bookingStatus) {
      bookingSnack = const SnackBar(
        content: Text("Your ride has been booked successfully"),
        backgroundColor: Colors.green,
      );

      // Update the local data manually without re-fetching
      for (var bus in allBuses) {
        if (bus['id'] == busScheduleId) {
          bus['availableSeats'] = (bus['availableSeats'] ?? 0) - 1;
          break;
        }
      }

      // Reapply the filter to the updated data
      filteredBuses = allBuses.where((bus) {
        String fromLocation = (bus['fromLocation'] ?? '').toLowerCase();
        return fromLocation.contains('');
      }).toList();
    } else {
      bookingSnack = const SnackBar(
        content: Text("Something went wrong!"),
        backgroundColor: Colors.red,
      );
    }

    notifyListeners();
  }

}
