
import 'package:ability_drive_flutter/screens/booking_rides/payment_Method_page.dart';
import 'package:flutter/material.dart';

import '../../color_palette.dart';
import '../Home_page.dart';

class Paymentpage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        title: const Text(
          'Payment',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Add Payment Method
            TextButton(
              onPressed: () {
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => PaymentMethod(),
                //     ));
              },
              child: const Text(
                'Add Payment Method',
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
            ),
            const SizedBox(height: 20),
            // Promotions Section
            const Text(
              'Promotions',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                leading: const Icon(Icons.card_giftcard, color: Colors.orange),
                title: const Text(
                  'Promotions',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {},
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Add Promo Code',
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
            ),
            const SizedBox(height: 20),
            // Vouchers Section
            const Text(
              'Vouchers',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFF2A2A2A),
                borderRadius: BorderRadius.circular(8),
              ),
              child: ListTile(
                leading:
                    const Icon(Icons.confirmation_number, color: Colors.red),
                title: const Text(
                  'Vouchers',
                  style: TextStyle(color: Colors.white),
                ),
                onTap: () {},
              ),
            ),
            TextButton(
              onPressed: () {},
              child: const Text(
                'Add Voucher Code',
                style: TextStyle(fontSize: 16, color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
