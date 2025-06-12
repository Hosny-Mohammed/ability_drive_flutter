import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ability_drive_flutter/providers/auth_provider.dart';

import '../../color_palette.dart';

class SeatBookingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text(
          'Seat Bookings',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          final bookings = authProvider.model?.seatBookings ?? [];

          if (bookings.isEmpty) {
            return const Center(
              child: Text(
                'No seat bookings available.',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final booking = bookings[index];
              return Card(
                color: Colors.white,
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  title: Text(
                    'Bus: ${booking.busName}',
                    style: const TextStyle(color: AppColors.background),
                  ),
                  subtitle: Text(
                    'Booking Time: ${booking.bookingTime}',
                    style: const TextStyle(color: AppColors.background),
                  ),
                  trailing: Text(
                    booking.isDisabledPassenger ? "Disabled" : "Normal",
                    style: const TextStyle(
                      color: Colors.blue,
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
