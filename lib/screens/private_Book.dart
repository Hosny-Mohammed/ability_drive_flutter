import 'package:ability_drive_flutter/providers/auth_provider.dart';
import 'package:ability_drive_flutter/screens/payment_Method_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/private_ride_provider.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/driver_card.dart';

class PrivateBook extends StatefulWidget {
  
  @override
  _PrivateBookState createState() => _PrivateBookState();
}

class _PrivateBookState extends State<PrivateBook> {
  late Future<void> _driverFuture;

  final TextEditingController governorateController = TextEditingController();
  final TextEditingController pickupController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Schedule fetching after build completes to avoid setState during build.
    _driverFuture = Future.delayed(Duration.zero, () {
      return Provider.of<DriversProvider>(context, listen: false)
          .fetchAvailableDrivers();
    });
  }

  @override
  Widget build(BuildContext context) {
    var authProvider = Provider.of<AuthProvider>(context, listen: false);
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
      body: FutureBuilder(
        future: _driverFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(
              child: Text(
                'An error occurred: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextField(
                    controller: governorateController,
                    hintText: 'Enter your governorate',
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Governorate is required';
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
                          Provider.of<DriversProvider>(context, listen: false)
                              .fetchAvailableDrivers(
                              filterValue: governorateController.text);
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
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
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
                          separatorBuilder: (context, index) =>
                          const Divider(),
                          itemBuilder: (context, index) {
                            var driver = provider.availableDrivers[index];
                            return DriverCard(
                              name: driver['name'] ?? 'Unknown',
                              vehicleType: driver['vehicleType'] ?? 'Unknown',
                              isAvailable: driver['isAvailable'] ?? false,
                              lastKnownLocation: driver['lastKnownLocation'],
                              phoneNumber: driver['phoneNumber'] ?? 'Unknown',
                              rating: driver['rating'] ?? 0.0,
                              onBookPressed: () {
                                final GlobalKey<FormState> modalFormKey =
                                GlobalKey<FormState>();
                                showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(16),
                                    ),
                                  ),
                                  builder: (BuildContext context) {
                                    return Padding(
                                      padding:
                                      MediaQuery.of(context).viewInsets,
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Form(
                                          key: modalFormKey,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            children: [
                                              CustomTextField(
                                                controller: pickupController,
                                                hintText: 'Pickup point',
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.trim().isEmpty) {
                                                    return 'Pickup point is required';
                                                  }
                                                  return null;
                                                },
                                              ),
                                              const SizedBox(height: 10),
                                              CustomTextField(
                                                controller:
                                                destinationController,
                                                hintText: 'Destination',
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.trim().isEmpty) {
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
                                                    backgroundColor:
                                                    Colors.blueAccent,
                                                    padding: const EdgeInsets.symmetric(
                                                        vertical: 12),
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                  ),
                                                  onPressed: () async {
                                                    if (modalFormKey.currentState!
                                                        .validate()) {
                                                      await provider.bookRide(userId: authProvider.userId!, driverId: driver['id'], pickupLocation: pickupController.text, destination: destinationController.text);
                                                      
                                                      Navigator.push(context, MaterialPageRoute(builder: (context) => PaymentMethod()));
                                                      print("Pickup: ${pickupController.text}");
                                                      print("Destination: ${destinationController.text}");
                                                    }
                                                  },
                                                  child: const Text(
                                                    'Confirm',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                );
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
          );
        },
      ),
    );
  }
}
