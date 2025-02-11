
import 'package:ability_drive_flutter/screens/payment_Method_page.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';

class PrivateBook extends StatelessWidget {
  final TextEditingController pickupController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF183446),
      appBar: AppBar(
        backgroundColor: Color(0xFF183446),
        elevation: 0,
        title: const Text("Private Ride"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Assign the form key
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: pickupController,
                hintText: 'Enter pickup point',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Pickup point is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),
              CustomTextField(
                controller: destinationController,
                hintText: 'Where to?',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Destination is required';
                  }
                  return null;
                },
              ),
              SizedBox(height: 10),

              // Search button with validation
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      print("Searching for rides...");
                    }
                  },
                  child: Text(
                    'Search',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              SizedBox(height: 20),

              Expanded(
                child: ListView.separated(
                  itemCount: 2,
                  separatorBuilder: (context, index) => Divider(),
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.network(
                                  'https://c8.alamy.com/comp/2C7DJJ5/car-sharing-logo-vector-city-micro-white-car-eco-vehicle-icon-isolated-white-background-cartoon-vector-illustration-2C7DJJ5.jpg',
                                  width: 70,
                                  height: 50,
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('From:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text('To:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    Text('Price:',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ],
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF6B70F8),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PaymentMethod()),
                                );
                              },
                              child: Text('Book'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
