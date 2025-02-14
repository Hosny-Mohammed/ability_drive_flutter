import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ability_drive_flutter/providers/auth_provider.dart';

class RidesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A3A42),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        title: const Text(
          'Rides',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          final rides = authProvider.model?.rides ?? [];

          if (rides.isEmpty) {
            return const Center(
              child: Text(
                'No rides available.',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: rides.length,
            itemBuilder: (context, index) {
              final ride = rides[index];
              return Card(
                color: const Color(0xFF121212),
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  title: Text(
                    '${ride.pickupLocation} → ${ride.destination}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                    'Cost: \$${ride.cost}',
                    style: const TextStyle(color: Colors.white70),
                  ),
                  trailing: Text(
                    ride.status,
                    style: const TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
