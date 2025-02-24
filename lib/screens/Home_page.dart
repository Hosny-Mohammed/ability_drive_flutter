import 'package:ability_drive_flutter/providers/home_provider.dart';
import 'package:ability_drive_flutter/screens/booking_rides/payment_Method_page.dart';
import 'package:ability_drive_flutter/screens/booking_rides/private_Book.dart';
import 'package:ability_drive_flutter/screens/authentication/profile_page.dart';
import 'package:ability_drive_flutter/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homepage extends StatelessWidget {
  int userId;
  bool isDisabled;
  final TextEditingController pickupController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Homepage({required this.userId, required this.isDisabled});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<HomeProvider>((context), listen: false);
    return Scaffold(
      backgroundColor: const Color(0xFF1A3A42),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A3A42),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Profile()),
                );
              },
            ),
          ],
        ),
      ),
      body: Consumer<HomeProvider>(
        builder: (context, homeProvider, child) {
          return SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: const Color(0xFF5B6EF8),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'To find your pickup location automatically, turn on location services',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Turn on location'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if(isDisabled){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => PrivateBook()),
                              );
                            }else{
                              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("This Service is available for disabled individuals"), backgroundColor: Colors.red,));
                            }

                          },
                          child: Column(
                            children: const [
                              Icon(Icons.directions_car, size: 50, color: Colors.white),
                              SizedBox(height: 8),
                              Text(
                                'Book a Private ride',
                                style: TextStyle(color: Colors.white, fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
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
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<HomeProvider>().fetchData(pickupController.text);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Confirm Pickup',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Available Buses',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (homeProvider.isLoading)
                          const Center(child: CircularProgressIndicator())
                        else if (homeProvider.filteredBuses.isEmpty)
                          const Center(
                            child: Text(
                              "No buses available for this location",
                              style: TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          )
                        else
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: homeProvider.filteredBuses.length,
                            itemBuilder: (context, index) {
                              final bus = homeProvider.filteredBuses[index];
                              return Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Consumer<HomeProvider>(
                                    builder: (context, homeProvider, child) {
                                      final bus = homeProvider.filteredBuses[index];
                                      return Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              const Icon(Icons.directions_bus, size: 50),
                                              const SizedBox(width: 16),
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      'Bus Number: ${bus["busNumber"]}',
                                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                                    ),
                                                    Text('From: ${bus["fromLocation"]}'),
                                                    Text('To: ${bus["toLocation"]}'),
                                                    Text('Departure: ${bus["departureTime"]}'),
                                                    Text('Available Seats: ${bus["availableNormalSeats"]}'),
                                                    Text(
                                                        'Available Seats For Disabled: ${bus["availableDisabledSeats"]}'),
                                                    Text(
                                                        'Wheelchair Accessible: ${bus["isWheelchairAccessible"] ? "Yes" : "No"}'),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 10),
                                          ElevatedButton(
                                            onPressed: () async {
                                              await homeProvider.bookRide(
                                                userId: userId,
                                                busScheduleId: bus['id'],
                                              );

                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                  homeProvider.bookingSnack!);

                                              if (homeProvider
                                                  .isBookingSuccessful) {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          PaymentMethod()),
                                                );
                                              }
                                            },
                                            child: const Text('Book'),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              )
                              ;
                            },
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
