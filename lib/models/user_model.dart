class UserModel {
  int id;
  String name;
  String phone;
  String email;
  bool isDisabled;
  bool status;
  List<RideModel> rides;
  List<SeatBookingModel> seatBookings;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.isDisabled,
    required this.status,
    required this.rides,
    required this.seatBookings,
  });

  factory UserModel.getJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['user']['id'],
      name: json['user']['firstName'] + " " + json['user']['lastName'],
      email: json['user']['email'],
      phone: json['user']['phoneNumber'],
      isDisabled: json['user']['isDisabled'],
      status: json['status'],
      rides: (json['user']['rides'] as List)
          .map((ride) => RideModel.getJson(ride))
          .toList(),
      seatBookings: (json['user']['seatBookings'] as List)
          .map((seat) => SeatBookingModel.getJson(seat))
          .toList(),
    );
  }
}

class RideModel {
  String pickupLocation;
  String destination;
  double cost;
  String status;

  RideModel({
    required this.pickupLocation,
    required this.destination,
    required this.cost,
    required this.status,
  });

  factory RideModel.getJson(Map<String, dynamic> json) {
    return RideModel(
      pickupLocation: json['pickupLocation'],
      destination: json['destination'],
      cost: json['cost'],
      status: json['status'],
    );
  }
}

class SeatBookingModel {
  String busName;
  bool isDisabledPassenger;
  DateTime bookingTime;
  int status;

  SeatBookingModel({
    required this.busName,
    required this.isDisabledPassenger,
    required this.bookingTime,
    required this.status,
  });

  factory SeatBookingModel.getJson(Map<String, dynamic> json) {
    return SeatBookingModel(
      busName: json['busName'],
      isDisabledPassenger: json['isDisabledPassenger'],
      bookingTime: DateTime.parse(json['bookingTime']),
      status: json['status'],
    );
  }
}
