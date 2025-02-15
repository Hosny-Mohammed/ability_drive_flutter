class Driver {
  final int driverId;
  final String driverName;
  final String licenseNumber;
  final String vehicleType;
  final double rating;
  final bool isAvailable;

  Driver({
    required this.driverId,
    required this.driverName,
    required this.licenseNumber,
    required this.vehicleType,
    required this.rating,
    required this.isAvailable,
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      driverId: json['driverId'],
      driverName: json['driverName'],
      licenseNumber: json['licenseNumber'],
      vehicleType: json['vehicleType'],
      rating: (json['rating'] as num).toDouble(),
      isAvailable: json['isAvailable'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'driverId': driverId,
      'driverName': driverName,
      'licenseNumber': licenseNumber,
      'vehicleType': vehicleType,
      'rating': rating,
      'isAvailable': isAvailable,
    };
  }
}

class DriverResponse {
  final bool status;
  final String message;
  final Driver driver;

  DriverResponse({
    required this.status,
    required this.message,
    required this.driver,
  });

  factory DriverResponse.fromJson(Map<String, dynamic> json) {
    return DriverResponse(
      status: json['status'],
      message: json['message'],
      driver: Driver.fromJson(json['driver']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'driver': driver.toJson(),
    };
  }
}