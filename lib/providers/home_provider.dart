import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ability_drive_flutter/services/home_service.dart';

class HomeProvider extends ChangeNotifier {
  List<dynamic> allBuses = [];
  List<dynamic> filteredBuses = [];
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  SnackBar? bookingSnack;
  bool isBookingSuccessful = false; // Added this property

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

  Future<void> bookRide({
    required int userId,
    required int busScheduleId,
  }) async {
    var bookingStatus = await HomeService.bookRide(
      userId: userId,
      busScheduleId: busScheduleId,
    );

    // Dynamically handle SnackBar message from the response
    bookingSnack = SnackBar(
      content: Text(bookingStatus?['message'] ?? "Something went wrong!"),
      backgroundColor: bookingStatus?['status'] == true ? Colors.green : Colors.red,
    );

    // Update bookingSuccess based on the response status
    isBookingSuccessful = bookingStatus?['status'] == true;

    // Handle case where no available seats or an error occurs
    if (isBookingSuccessful) {
      // If booking is successful, update local data
      for (var bus in allBuses) {
        if (bus['id'] == busScheduleId) {
          bus['availableSeats'] = (bus['availableSeats'] ?? 0) - 1;
          break;
        }
      }

      // Reapply the filter to the updated data
      filteredBuses = allBuses.where((bus) {
        String fromLocation = (bus['fromLocation'] ?? '').toLowerCase();
        return fromLocation.contains(''); // Apply your filter logic
      }).toList();
    } else {
      // Handle the case where no available seats or buses
      if (bookingStatus?['message'] == "No available seats for the selected bus.") {
        // Optionally log, show a more specific message, or handle this case
        print("No seats available for this bus.");
      }
    }

    // Notify listeners to update the UI
    notifyListeners();
  }

}
