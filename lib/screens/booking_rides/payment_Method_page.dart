import 'package:ability_drive_flutter/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../color_palette.dart';
import '../../providers/private_ride_provider.dart';
import '../../stripe_payment/payment_manager.dart';
import '../Home_page.dart';

class PaymentMethod extends StatelessWidget {
  double? totalCost;
  PaymentMethod({Key? key,this.totalCost}) : super(key: key);

  final ValueNotifier<String?> _selectedPayment = ValueNotifier<String?>(null);
  final TextEditingController _voucherController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Get providers for cost and authentication
    var driverProvider = Provider.of<DriversProvider>(context, listen: false);
    var authProvider = Provider.of<AuthProvider>(context, listen: false);

    // If totalCost is not passed, assign the cost from driverProvider
    totalCost ??= driverProvider.cost;


    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display the total cost at the top
            Text(
              "Total Cost: \$${totalCost?.toStringAsFixed(2)}",
              style: const TextStyle(
                  color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              "Select your preferred payment method",
              style: TextStyle(
                  color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Payment Options
            _buildPaymentOption("Credit or Debit Card", Icons.credit_card),
            const SizedBox(height: 12),
            _buildPaymentOption("Cash", Icons.money),
            const SizedBox(height: 20),
            // Voucher TextField
            const Text(
              "Enter Voucher Code (optional):",
              style: TextStyle(
                  color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _voucherController,
              decoration: InputDecoration(
                hintText: "Voucher Code",
                hintStyle: const TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.white.withOpacity(0.1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white54),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white54),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.blueAccent),
                ),
              ),
              style: const TextStyle(color: Colors.white),
            ),
            const Spacer(),
            // Confirm Button
            ValueListenableBuilder<String?>(
              valueListenable: _selectedPayment,
              builder: (context, selected, _) {
                return SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    onPressed: selected != null
                        ? () async {
                      if (selected == "Credit or Debit Card") {
                        try {
                          // Trigger Stripe payment using the driver's cost
                          await PaymentManager.makePayment(totalCost!, "EGP");
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Stripe Payment successful!"),
                              backgroundColor: Colors.green,
                              duration: Duration(seconds: 2),
                            ),
                          );
                        } on PaymentCancelledException {
                          // User cancelled the payment—do nothing.
                          print("Payment cancelled by user.");
                        } catch (error) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Payment error: ${error.toString()}"),
                              backgroundColor: Colors.red,
                            ),
                          );
                        }
                      } else if (selected == "Cash") {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Cash payment selected."),
                            backgroundColor: Colors.blue,
                            duration: Duration(seconds: 2),
                          ),
                        );
                      }
                      // After payment is handled, navigate to Homepage
                      Future.delayed(const Duration(milliseconds: 500), () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Homepage(
                              userId: authProvider.model!.id,
                              isDisabled: authProvider.model!.isDisabled,
                            ),
                          ),
                        );
                      });
                    }
                        : null,
                    child: const Text("Confirm payment",
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(String title, IconData icon) {
    return ValueListenableBuilder<String?>(
      valueListenable: _selectedPayment,
      builder: (context, selected, _) {
        bool isSelected = selected == title;
        return GestureDetector(
          onTap: () {
            _selectedPayment.value = title;
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: isSelected ? Colors.white.withOpacity(0.1) : Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              border: isSelected
                  ? Border.all(color: Colors.blueAccent, width: 2)
                  : Border.all(color: Colors.white54, width: 1),
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.white, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(title,
                      style: const TextStyle(color: Colors.white, fontSize: 16)),
                ),
                Transform.scale(
                  scale: 1.3,
                  child: Radio<String>(
                    value: title,
                    groupValue: selected,
                    onChanged: (String? value) {
                      _selectedPayment.value = value;
                    },
                    activeColor: Colors.blueAccent,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
