// ride_card.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/rides_model.dart';

class RideCard extends StatelessWidget {
  final Ride ride;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const RideCard({
    super.key,
    required this.ride,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('From: ${ride.pickupLocation}', style: const TextStyle(fontSize: 16)),
            Text('To: ${ride.destination}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 8),
            Text('Fare: \$${ride.cost.toStringAsFixed(2)}', style: const TextStyle(fontSize: 16)),

            if (ride.status == 'confirmed') ...[
              const SizedBox(height: 16),
              const Divider(),
              const Text('Passenger Details:', style: TextStyle(fontWeight: FontWeight.bold)),
              Text('Name: ${ride.username}'),
              Row(
                children: [
                  Text('Phone: ${ride.phoneNumber}'),
                  const SizedBox(width: 8),
                  IconButton(
                    icon: const Icon(Icons.content_copy, size: 20),
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: ride.phoneNumber));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Phone number copied!')),
                      );
                    },
                  ),
                ],
              ),
            ] else
              ButtonBar(
                children: [
                  ElevatedButton(
                    onPressed: onConfirm,
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                    child: const Text('Confirm Ride'),
                  ),
                  TextButton(
                    onPressed: onCancel,
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                    child: const Text('Cancel Ride'),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}