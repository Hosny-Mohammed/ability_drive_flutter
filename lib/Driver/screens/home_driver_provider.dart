import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ability_drive_flutter/Driver/models/driver_model.dart';

import '../providers/home_driver_provider.dart';
import '../widgets/ride_card.dart';

class DriverHomePage extends StatefulWidget {
  final int driverId;

  const DriverHomePage({super.key, required this.driverId});

  @override
  State<DriverHomePage> createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  @override
  void initState() {
    super.initState();
    final provider = context.read<HomeDriverProvider>();
    provider.fetchDriverInfo(widget.driverId);
    provider.fetchRides(widget.driverId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Driver Dashboard'),
      ),
      body: Consumer<HomeDriverProvider>(
        builder: (context, provider, _) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              SwitchListTile(
                title: const Text('Available for Rides'),
                value: provider.availability,
                onChanged: (value) => provider.toggleAvailability(
                  widget.driverId,
                  value,
                ),
              ),
              Expanded(
                child: provider.rides.isEmpty
                    ? const Center(child: Text('No available rides'))
                    : ListView.builder(
                  itemCount: provider.rides.length,
                  itemBuilder: (context, index) {
                    final ride = provider.rides[index];
                    return RideCard(
                      ride: ride,
                      onConfirm: () => provider.updateRideStatus(
                        ride.id,
                        'confirmed',
                        '',
                      ),
                      onCancel: () => showCancelReasonSheet(
                        context,
                        ride.id,
                        provider,
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void showCancelReasonSheet(
      BuildContext context,
      int rideId,
      HomeDriverProvider provider,
      ) {
    final TextEditingController reasonController = TextEditingController();
    showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(
                labelText: 'Reason for cancellation',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (reasonController.text.isNotEmpty) {
                  provider.updateRideStatus(
                    rideId,
                    'canceled',
                    reasonController.text,
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text('Submit Reason'),
            ),
          ],
        ),
      ),
    );
  }
}