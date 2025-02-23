import 'package:dio/dio.dart';
import '../models/driver_model.dart';
import '../models/rides_model.dart';

class HomeService {
  static Dio dio = Dio();

  static Future<RideResponse?> fetchRides({required int driverId}) async {
    try {
      Response response = await dio.get(
        'https://abilitydrive.runasp.net/api/Ride/available-rides',
        queryParameters: {"driverId": driverId},
      );
      if (response.statusCode == 200) {
        return RideResponse.fromJson(response.data);
      }
      return null;
    } catch (ex) {
      print("Error: $ex");
      return null;
    }
  }

  static Future<bool> changeAvailability({required int driverId, required bool availability}) async {
    try {
      Response response = await dio.put(
        'https://abilitydrive.runasp.net/api/driver/availability/$driverId',
        queryParameters: {"isAvailable": availability},
      );
      return response.statusCode == 200;
    } catch (ex) {
      print("Error: $ex");
      return false;
    }
  }

  static Future<DriverResponse> getDriverInfo({required int driverId}) async {
    Response response = await dio.get(
      'https://abilitydrive.runasp.net/api/driver/profile/$driverId',
    );
    return DriverResponse.fromJson(response.data);
  }

  static Future<bool> updateRideStatus({required int rideId, required String status, required String reason}) async {
    try {
      Response response = await dio.put(
        'https://abilitydrive.runasp.net/api/Ride/$rideId/status',
        data: {"status": status, "reason": reason},
      );
      return response.statusCode == 200;
    } catch (ex) {
      print("Error: $ex");
      return false;
    }
  }

  // New: Update driver's location using the provided endpoint
  static Future<bool> updateDriverLocation({required int driverId, required String location}) async {
    try {
      Response response = await dio.put(
        'https://abilitydrive.runasp.net/api/driver/update-location/$driverId',
        queryParameters: {"location": location},
      );
      return response.statusCode == 200;
    } catch (ex) {
      print("Error updating location: $ex");
      return false;
    }
  }
}
