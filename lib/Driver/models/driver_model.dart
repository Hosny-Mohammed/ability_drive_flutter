class Driver {
  final int driverId;
  final String driverName;
  final String licenseNumber;
  final String vehicleType;
  final double rating;
  final bool isAvailable;
  final String location; // Added field for location

  Driver({
    required this.driverId,
    required this.driverName,
    required this.licenseNumber,
    required this.vehicleType,
    required this.rating,
    required this.isAvailable,
    required this.location, // Added to constructor
  });

  factory Driver.fromJson(Map<String, dynamic> json) {
    return Driver(
      driverId: json['driverId'],
      driverName: json['driverName'],
      licenseNumber: json['licenseNumber'],
      vehicleType: json['vehicleType'],
      rating: (json['rating'] as num).toDouble(),
      isAvailable: json['isAvailable'],
      location: json['location'] ?? '', // Use empty string if location is missing
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
      'location': location, // Added field to JSON
    };
  }

  // Added copyWith method to update location (or any field)
  Driver copyWith({
    int? driverId,
    String? driverName,
    String? licenseNumber,
    String? vehicleType,
    double? rating,
    bool? isAvailable,
    String? location,
  }) {
    return Driver(
      driverId: driverId ?? this.driverId,
      driverName: driverName ?? this.driverName,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      vehicleType: vehicleType ?? this.vehicleType,
      rating: rating ?? this.rating,
      isAvailable: isAvailable ?? this.isAvailable,
      location: location ?? this.location,
    );
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
