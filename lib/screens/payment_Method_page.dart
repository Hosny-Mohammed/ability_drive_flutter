
import 'package:flutter/material.dart';

import 'Home_page.dart';

class PaymentMethod extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentMethod> {
  String? _selectedPayment;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff0e4f55),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        // actions: [
        //   TextButton(
        //     onPressed: () {},
        //     child: Text(
        //       "DO THIS LATER",
        //       style: TextStyle(color: Colors.blue, fontSize: 16),
        //     ),
        //   ),
        // ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Select your preferred payment method",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            _buildPaymentOption("Credit or Debit Card", Icons.credit_card),
            _buildPaymentOption("Paytm", Icons.account_balance_wallet),
            _buildPaymentOption("Cash", Icons.money),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: EdgeInsets.symmetric(vertical: 15),
                ),
                onPressed: _selectedPayment != null
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Homepage(userId: 1,)),
                        );
                      }
                    : null,
                child: Text("Confirm payment",
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(String title, IconData icon) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(title, style: TextStyle(color: Colors.white)),
      trailing: Radio<String>(
        value: title,
        groupValue: _selectedPayment,
        onChanged: (String? value) {
          setState(() {
            _selectedPayment = value;
          });
        },
      ),
    );
  }
}
