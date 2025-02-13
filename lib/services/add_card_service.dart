import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class AddCardService{
  static Dio dio = Dio();

  static Future<bool> addCard({required int userId, required String cardHolderName, required String cardNumber, required String expiryDate, required String securityCode,required String zipCode})async{
    try{
      Map data = {
        "cardHolderName": cardHolderName,
        "cardNumber": cardNumber,
        "expiryDate": expiryDate,
        "securityCode": securityCode,
        "zipCode": zipCode
      };
      Response response =  await dio.post('https://abilitydrive.runasp.net/api/creditcards/AddCard/$userId', data:data);

      if(response.statusCode == 200 && response.data['status'] == true){
        return true;
      }
      return false;
    }catch(ex){
      if (kDebugMode) {
        print("Error:$ex");
      }
      return false;
    }

  }
}