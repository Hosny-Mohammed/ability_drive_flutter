import 'package:ability_drive_flutter/services/add_card_service.dart';
import 'package:flutter/material.dart';

class AddCardProvider extends ChangeNotifier{
  bool? status;
  Future<void> addCard({required int userId, required String cardHolderName, required String cardNumber, required String expiryDate, required String securityCode,required String zipCode})async{

    status = await AddCardService.addCard(userId: userId, cardHolderName: cardHolderName, cardNumber: cardNumber, expiryDate: expiryDate, securityCode: securityCode, zipCode: zipCode);


  }
}