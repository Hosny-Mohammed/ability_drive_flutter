class BusScheduleModel {
  List<dynamic> data;
  bool status;

  BusScheduleModel({
    required this.data,
    required this.status
  });

  factory BusScheduleModel.fromJson(Map json) {
    return BusScheduleModel(
      data: json['schedules'],
      status: json['status']
    );
  }
}
