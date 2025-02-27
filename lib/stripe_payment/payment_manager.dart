import 'package:ability_drive_flutter/stripe_payment/stripe_keys.dart';
import 'package:dio/dio.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

/// Custom exception to indicate the user cancelled the payment.
class PaymentCancelledException implements Exception {
  final String message;
  PaymentCancelledException([this.message = "Payment cancelled by user."]);
  @override
  String toString() => message;
}

abstract class PaymentManager {
  static Future<void> makePayment(double amount, String currency) async {
    try {
      String clientSecret =
      await _getClientSecret((amount * 100).toInt().toString(), currency);
      await _initializePaymentSheet(clientSecret);
      await Stripe.instance.presentPaymentSheet();
    } on StripeException catch (e) {
      // Check if the error code indicates a cancellation.
      if (e.error.code.toString().toLowerCase() == "canceled" ||
          e.error.code.toString().toLowerCase() == "cancelled") {
        throw PaymentCancelledException();
      }
      throw Exception("Payment failed: ${e.toString()}");
    } catch (error) {
      throw Exception("Payment failed: ${error.toString()}");
    }
  }

  static Future<void> _initializePaymentSheet(String clientSecret) async {
    await Stripe.instance.initPaymentSheet(
      paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: clientSecret,
        merchantDisplayName: "Basel",
      ),
    );
  }

  static Future<String> _getClientSecret(String amount, String currency) async {
    Dio dio = Dio();
    var response = await dio.post(
      'https://api.stripe.com/v1/payment_intents',
      options: Options(
        headers: {
          'Authorization': 'Bearer ${ApiKeys.secretKey}',
          'Content-Type': 'application/x-www-form-urlencoded'
        },
      ),
      data: {
        'amount': amount,
        'currency': currency,
      },
    );
    return response.data["client_secret"];
  }
}
