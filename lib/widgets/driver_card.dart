import 'package:flutter/material.dart';

class DriverCard extends StatelessWidget {
  final String name;
  final String vehicleType;
  final bool isAvailable;
  final String lastKnownLocation;
  final String phoneNumber;
  final double rating;
  final VoidCallback onBookPressed;

  const DriverCard({
    Key? key,
    required this.name,
    required this.vehicleType,
    required this.isAvailable,
    required this.lastKnownLocation,
    required this.phoneNumber,
    required this.rating,
    required this.onBookPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                      radius: 30,
                      child: Text(
                        name[0], // Show the first letter of the name
                        style: const TextStyle(color: Colors.white, fontSize: 24),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          'Vehicle: $vehicleType',
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Phone: $phoneNumber',
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Status: ${isAvailable ? "Available" : "Not Available"}',
                          style: TextStyle(
                            fontSize: 14,
                            color: isAvailable ? Colors.green : Colors.red,
                          ),
                        ),
                          Text(
                            'Last Location: $lastKnownLocation',
                            style: const TextStyle(fontSize: 14),
                          ),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      children: List.generate(5, (index) {
                        return Icon(
                          index < rating.floor()
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.orangeAccent,
                        );
                      }),
                    ),
                    Text(
                      rating.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
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
                onPressed: onBookPressed,
                child: const Text(
                  'Book',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
