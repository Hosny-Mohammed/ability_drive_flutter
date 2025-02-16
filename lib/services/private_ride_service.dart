import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../models/driver_profile_model.dart';

class PrivateRideService {
  static Dio dio = Dio();

  static Future<List<dynamic>?> fetchData({
    required String preferredLocation,
    required String lastKnownLocation,
  }) async {
    try {
      Map<String, String> queryParams = {};
      if (preferredLocation.isNotEmpty) {
        queryParams['preferredLocation'] = preferredLocation;
      }
      if (lastKnownLocation.isNotEmpty) {
        queryParams['lastKnownLocation'] = lastKnownLocation;
      }

      Response response = await dio.get(
        'https://abilitydrive.runasp.net/api/driver/available-drivers',
        queryParameters: queryParams,
      );

      if (response.statusCode == 200) {
        var model = DriverProfileModel.getJson(response.data);
        if (model.status) {
          return model.data;
        }
        return null;
      }
      return null;
    } catch (ex) {
      if (kDebugMode) {
        print('Error: $ex');
      }
      return null;
    }
  }

  /// Book a ride and return the ride object
  static Future<Map<String, dynamic>?> bookRide({
    required int userId,
    required int driverId,
    required String pickupLocation,
    required String destination,
  }) async {
    try {
      Map data = {
        "pickupLocation": pickupLocation,
        "destination": destination,
      };
      Response response = await dio.post(
        'https://abilitydrive.runasp.net/api/Ride/private/$userId/driver/$driverId',
        data: data,
      );
      if (response.statusCode == 200 && response.data['status'] == true) {
        // Expecting response.data['ride'] to include 'id', 'cost', etc.
        return response.data['ride'];
      }
      return null;
    } catch (ex) {
      if (kDebugMode) {
        print('Error: $ex');
      }
      return null;
    }
  }

  /// Check the status of a ride using its rideId
  static Future<Map<String, dynamic>?> checkRideStatus({
    required int rideId,
  }) async {
    try {
      Response response = await dio.get(
        'https://abilitydrive.runasp.net/api/Ride/$rideId/check-status',
      );
      if (response.statusCode == 200 && response.data['status'] == true) {
        return response.data['ride'];
      }
      return null;
    } catch (ex) {
      if (kDebugMode) {
        print("Error checking ride status: $ex");
      }
      return null;
    }
  }
}
