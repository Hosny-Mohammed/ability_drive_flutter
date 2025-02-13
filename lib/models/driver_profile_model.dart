class DriverProfileModel{
  bool status;
  List<dynamic> data;

  DriverProfileModel({required this.data, required this.status});
  factory DriverProfileModel.getJson(Map json){
    return DriverProfileModel(data: json['drivers'], status: json['status']);
  }
}