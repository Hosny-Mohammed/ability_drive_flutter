import 'package:ability_drive_flutter/screens/profile_page.dart';
import 'package:flutter/material.dart';


class PaymentInfoPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _cardController = TextEditingController();
  final _expDateController = TextEditingController();
  final _cvvController = TextEditingController();
  final _zipController = TextEditingController();

  void _validateAndSubmit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All fields are valid! Processing payment...')),
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => profile()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      backgroundColor: const Color(0xff17494c),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Card(
              elevation: 8.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.blue.shade100,
                        child: const Icon(Icons.person, color: Colors.blue, size: 40),
                      ),
                      const SizedBox(height: 15),
                      const Text(
                        'Payment info',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          hintText: 'Alex Smith',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter your full name'
                            : null,
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: _cardController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Credit Card Number',
                          hintText: '1234 1234 1234 1234',
                          suffixIcon: const Icon(Icons.credit_card),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Please enter your credit card number'
                            : value.length != 16
                            ? 'Credit card number must be 16 digits'
                            : null,
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _expDateController,
                              keyboardType: TextInputType.datetime,
                              decoration: InputDecoration(
                                labelText: 'Exp Date',
                                hintText: 'MM/YY',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter expiry date';
                                } else if (!RegExp(r"^(0[1-9]|1[0-2])\/([0-9]{2})$")
                                    .hasMatch(value)) {
                                  return 'Invalid format. Use MM/YY';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextFormField(
                              controller: _cvvController,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                labelText: 'CVV',
                                hintText: '•••',
                                suffixIcon: const Icon(Icons.info_outline),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              validator: (value) => value == null || value.isEmpty
                                  ? 'Enter CVV'
                                  : value.length != 3
                                  ? 'CVV must be 3 digits'
                                  : null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      TextFormField(
                        controller: _zipController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Zip Code',
                          hintText: '90210',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        validator: (value) => value == null || value.isEmpty
                            ? 'Enter zip code'
                            : value.length != 5
                            ? 'Zip code must be 5 digits'
                            : null,
                      ),
                      const SizedBox(height: 25),
                      ElevatedButton(
                        onPressed: () => _validateAndSubmit(context),
                        child: const Text('Confirm Payment'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
