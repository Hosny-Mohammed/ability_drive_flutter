import 'package:ability_drive_flutter/screens/payment_information_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ability_drive_flutter/providers/auth_provider.dart';
import 'Rides_History/rides_page.dart';
import 'Rides_History/seat_bookings_page.dart'; // Import your Credit Card page

class Profile extends StatelessWidget {
  Profile();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A3A42),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121212),
        title: const Text(
          'Menu',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          final user = authProvider.model;

          if (user == null) {
            return const Center(
              child: Text(
                'No user data available. Please log in.',
                style: TextStyle(color: Colors.white),
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF121212),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.person, size: 30, color: Colors.white),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${user.name}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              user.phone,
                              style: const TextStyle(color: Colors.white70),
                            ),
                            Text(
                              user.email,
                              style: const TextStyle(color: Colors.white70),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Text(
                                  'Status: ',
                                  style: TextStyle(color: Colors.white70),
                                ),
                                Text(
                                  user.isDisabled ? "Disabled" : "Active",
                                  style: TextStyle(
                                    color: user.isDisabled
                                        ? Colors.red
                                        : Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RidesPage(),
                      ),
                    );
                  },
                  child: const Text(
                    'View Rides',
                    style: TextStyle(fontSize: 16, color: Color(0xffffffff)),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SeatBookingsPage(),
                      ),
                    );
                  },
                  child: const Text(
                    'View Seat Bookings',
                    style: TextStyle(fontSize: 16, color: Color(0xffffffff)),
                  ),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PaymentInfoPage(), // Navigate to the Credit Card page
                      ),
                    );
                  },
                  child: const Text(
                    'Manage Credit Card',
                    style: TextStyle(fontSize: 16, color: Color(0xffffffff)),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
