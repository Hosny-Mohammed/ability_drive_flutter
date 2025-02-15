import 'package:ability_drive_flutter/providers/auth_provider.dart';
import 'package:ability_drive_flutter/screens/booking_rides/payment_Method_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/private_ride_provider.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/driver_card.dart';

class PrivateBook extends StatelessWidget {
  PrivateBook({Key? key}) : super(key: key);

  final TextEditingController pickupController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
    var driverProvider = Provider.of<DriversProvider>(context);

    return Scaffold(
      backgroundColor: const Color(0xFF183446),
      appBar: AppBar(
        backgroundColor: const Color(0xFF183446),
        elevation: 0,
        title: const Text("Private Ride"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                controller: pickupController,
                hintText: 'Enter your pickup point',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Pickup point is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              CustomTextField(
                controller: destinationController,
                hintText: 'Enter your destination',
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Destination is required';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      driverProvider.fetchAvailableDrivers(
                        preferredLocation: destinationController.text,
                        lastKnownLocation: pickupController.text,
                      );
                    }
                  },
                  child: const Text(
                    'Search',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Consumer<DriversProvider>(
                  builder: (context, provider, _) {
                    if (provider.isLoading) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (provider.availableDrivers.isEmpty) {
                      return const Center(
                        child: Text(
                          'No drivers found.',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }
                    return ListView.separated(
                      itemCount: provider.availableDrivers.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        var driver = provider.availableDrivers[index];
                        return DriverCard(
                          name: driver['name'] ?? 'Unknown',
                          vehicleType: driver['vehicleType'] ?? 'Unknown',
                          isAvailable: driver['isAvailable'] ?? false,
                          lastKnownLocation: driver['lastKnownLocation'] ?? 'Unknown',
                          phoneNumber: driver['phoneNumber'] ?? 'Unknown',
                          rating: driver['rating'] ?? 0.0,
                          preferredLocations: (driver['preferredLocations'] as List<dynamic>?)?.cast<String>() ?? [],
                          onBookPressed: () async{
                            await provider.bookRide(
                              userId: authProvider.model!.id,
                              driverId: driver['id'],
                              pickupLocation: pickupController.text,
                              destination: destinationController.text,
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Ride booked successfully!"),
                                backgroundColor: Colors.green,
                              ),

                            );
                            Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentMethod()));
                          },
                        );
                      },
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
