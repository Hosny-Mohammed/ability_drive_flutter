// rides_model.dart
class Ride {
  final int id;
  final String username;
  final String phoneNumber;
  final String pickupLocation;
  final String destination;
  final double cost;
  final String status;
  final String? reason;

  Ride({
    required this.id,
    required this.username,
    required this.phoneNumber,
    required this.pickupLocation,
    required this.destination,
    required this.cost,
    required this.status,
    this.reason,
  });

  factory Ride.fromJson(Map<String, dynamic> json) {
    return Ride(
      id: json['id'],
      username: json['username'],
      phoneNumber: json['phoneNumber'],
      pickupLocation: json['pickupLocation'],
      destination: json['destination'],
      cost: (json['cost'] as num).toDouble(),
      status: json['status'],
      reason: json['reason'],
    );
  }

  Ride copyWith({
    int? id,
    String? username,
    String? phoneNumber,
    String? pickupLocation,
    String? destination,
    double? cost,
    String? status,
    String? reason,
  }) {
    return Ride(
      id: id ?? this.id,
      username: username ?? this.username,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      pickupLocation: pickupLocation ?? this.pickupLocation,
      destination: destination ?? this.destination,
      cost: cost ?? this.cost,
      status: status ?? this.status,
      reason: reason ?? this.reason,
    );
  }
}

class RideResponse {
  final bool status;
  final List<Ride> rides;

  RideResponse({
    required this.status,
    required this.rides,
  });

  factory RideResponse.fromJson(Map<String, dynamic> json) {
    var ridesList = json['rides'] as List;
    List<Ride> rides = ridesList.map((i) => Ride.fromJson(i)).toList();

    return RideResponse(
      status: json['status'],
      rides: rides,
    );
  }
}