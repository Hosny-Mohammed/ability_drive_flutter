class Ride {
  final int id;
  final String pickupLocation;
  final String destination;
  final double cost;
  final String status;

  Ride({
    required this.id,
    required this.pickupLocation,
    required this.destination,
    required this.cost,
    required this.status,
  });

  factory Ride.fromJson(Map<String, dynamic> json) {
    return Ride(
      id: json['id'],
      pickupLocation: json['pickupLocation'],
      destination: json['destination'],
      cost: (json['cost'] as num).toDouble(),
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pickupLocation': pickupLocation,
      'destination': destination,
      'cost': cost,
      'status': status,
    };
  }
}

class RideResponse {
  final bool status;
  final String message;
  final List<Ride> rides;

  RideResponse({
    required this.status,
    required this.message,
    required this.rides,
  });

  factory RideResponse.fromJson(Map<String, dynamic> json) {
    return RideResponse(
      status: json['status'],
      message: json['message'],
      rides: (json['rides'] as List)
          .map((ride) => Ride.fromJson(ride))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'rides': rides.map((ride) => ride.toJson()).toList(),
    };
  }
}
