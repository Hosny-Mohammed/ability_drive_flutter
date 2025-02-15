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
    _initializeData();
  }

  void _initializeData() {
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

          return RefreshIndicator(
            onRefresh: () async => _initializeData(),
            child: Column(
              children: [
                _buildAvailabilitySwitch(provider),
                _buildRidesList(provider),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAvailabilitySwitch(HomeDriverProvider provider) {
    return SwitchListTile(
      title: const Text('Available for Rides'),
      value: provider.availability,
      onChanged: (value) => provider.toggleAvailability(widget.driverId, value),
    );
  }

  Widget _buildRidesList(HomeDriverProvider provider) {
    return Expanded(
      child: provider.rides.isEmpty
          ? const Center(child: Text('No available rides'))
          : ListView.builder(
        itemCount: provider.rides.length,
        itemBuilder: (context, index) {
          final ride = provider.rides[index];
          return RideCard(
            ride: ride,
            onConfirm: () => _handleRideConfirmation(context, ride.id, provider),
            onCancel: () => _showCancelReasonSheet(context, ride.id, provider),
          );
        },
      ),
    );
  }

  Future<void> _handleRideConfirmation(BuildContext context, int rideId, HomeDriverProvider provider) async {
    final success = await provider.updateRideStatus(rideId, 'confirmed', '');
    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(success
            ? 'Ride accepted successfully!'
            : 'Failed to accept ride'),
      ),
    );
  }

  void _showCancelReasonSheet(BuildContext context, int rideId, HomeDriverProvider provider) {
    final reasonController = TextEditingController();
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
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                if (reasonController.text.isEmpty) return;

                final success = await provider.updateRideStatus(
                  rideId,
                  'canceled',
                  reasonController.text,
                );

                if (!context.mounted) return;

                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(success
                        ? 'Ride canceled successfully!'
                        : 'Failed to cancel ride'),
                  ),
                );
              },
              child: const Text('Submit Reason'),
            ),
          ],
        ),
      ),
    );
  }
}