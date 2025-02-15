import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('From: ${ride.pickupLocation}'),
            Text('To: ${ride.destination}'),
            Text('Cost: \$${ride.cost.toStringAsFixed(2)}'),
            Text('Status: ${ride.status}'),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onConfirm,
                    icon: const Icon(Icons.check),
                    label: const Text('Confirm'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onCancel,
                    icon: const Icon(Icons.close),
                    label: const Text('Cancel'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}