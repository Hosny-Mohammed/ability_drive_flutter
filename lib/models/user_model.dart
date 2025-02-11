class UserModel{
  int id;
  String name;
  String phone;
  String email;
  bool isDisabled;
  bool status;
  UserModel({required this.id, required this.name, required this.email, required this.phone, required this.isDisabled, required this.status});


  factory UserModel.getJson(Map json){
    return UserModel(id: json['user']['id'], name: json['user']['firstName'] + json['user']['lastName'], email: json['user']['email'], phone: json['user']['phoneNumber'], isDisabled: json['user']['isDisabled'], status: json['status']);
  }
}