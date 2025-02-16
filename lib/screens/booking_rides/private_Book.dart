import 'package:ability_drive_flutter/providers/auth_provider.dart';
import 'package:ability_drive_flutter/screens/booking_rides/payment_Method_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/private_ride_provider.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/driver_card.dart';

class PrivateBook extends StatefulWidget {
  const PrivateBook({Key? key}) : super(key: key);

  @override
  _PrivateBookState createState() => _PrivateBookState();
}

class _PrivateBookState extends State<PrivateBook> {
  final TextEditingController pickupController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // This flag helps to avoid calling refresh repeatedly.
  bool _didRefreshOnBuild = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // If the page is current and the pickup/destination fields are not empty,
    // refresh available drivers. (This occurs when the page is rebuilt.)
    if ((ModalRoute.of(context)?.isCurrent ?? false) &&
        pickupController.text.isNotEmpty &&
        destinationController.text.isNotEmpty &&
        !_didRefreshOnBuild) {
      final driverProvider = Provider.of<DriversProvider>(context, listen: false);
      driverProvider.fetchAvailableDrivers(
        preferredLocation: destinationController.text,
        lastKnownLocation: pickupController.text,
      );
      _didRefreshOnBuild = true;
    }
  }

  @override
  void dispose() {
    pickupController.dispose();
    destinationController.dispose();
    super.dispose();
  }

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
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              if (pickupController.text.isNotEmpty &&
                  destinationController.text.isNotEmpty) {
                // Reset the flag so that subsequent rebuilds may refresh as needed.
                _didRefreshOnBuild = false;
                driverProvider.fetchAvailableDrivers(
                  preferredLocation: destinationController.text,
                  lastKnownLocation: pickupController.text,
                );
              }
            },
          )
        ],
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
                      // Reset refresh flag when doing a new search.
                      _didRefreshOnBuild = false;
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
                          preferredLocations: (driver['preferredLocations'] as List<dynamic>?)
                              ?.cast<String>() ??
                              [],
                          onBookPressed: () async {
                            // First, attempt to book the ride.
                            final ride = await provider.bookRide(
                              userId: authProvider.model!.id,
                              driverId: driver['id'],
                              pickupLocation: pickupController.text,
                              destination: destinationController.text,
                            );

                            if (ride == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Booking failed."),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }

                            // Booking succeeded—now show a modal dialog waiting for ride acceptance.
                            bool cancelPolling = false;
                            showDialog(
                              context: context,
                              barrierDismissible: false,
                              builder: (context) {
                                return StatefulBuilder(
                                  builder: (context, setState) {
                                    return AlertDialog(
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: const [
                                          CircularProgressIndicator(),
                                          SizedBox(height: 20),
                                          Text("Waiting for ride acceptance..."),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            cancelPolling = true;
                                            Navigator.pop(context);
                                          },
                                          child: const Text("Cancel"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            );

                            final rideId = ride['id'];
                            // Poll the check-status endpoint every 2 seconds.
                            while (true) {
                              if (cancelPolling) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Booking cancelled by user."),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                                return;
                              }
                              final statusResponse =
                              await provider.checkRideStatus(rideId: rideId);
                              if (statusResponse != null) {
                                final status = statusResponse['status'];
                                if (status == 'confirmed') {
                                  break;
                                } else if (status == 'canceled') {
                                  if (Navigator.canPop(context)) {
                                    Navigator.pop(context);
                                  }
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "Ride canceled: ${statusResponse['reason']}"),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                  return;
                                }
                              }
                              await Future.delayed(const Duration(seconds: 2));
                            }

                            // Dismiss the waiting dialog, then navigate.
                            if (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            }
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Ride confirmed!"),
                                backgroundColor: Colors.green,
                              ),
                            );
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => PaymentMethod()),
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
      ),
    );
  }
}
