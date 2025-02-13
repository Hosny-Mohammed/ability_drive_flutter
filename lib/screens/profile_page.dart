import 'package:ability_drive_flutter/screens/payment_information_page.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  final Map<String, dynamic> user = {
    "id": 2,
    "firstName": "hosny",
    "lastName": "mohammed",
    "phoneNumber": "01149871367",
    "email": "hosny@gmail.com",
    "isDisabled": false,
    "password": "pass#123",
    "createdAt": "2025-02-12T20:34:44.5533846",
  };

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
      body: Padding(
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
                          '${user["firstName"]} ${user["lastName"]}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          user["phoneNumber"],
                          style: const TextStyle(color: Colors.white70),
                        ),
                        Text(
                          user["email"],
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
                              user["isDisabled"] ? "Disabled" : "Active",
                              style: TextStyle(
                                color: user["isDisabled"]
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
                      builder: (context) => PaymentInfoPage(),
                    ));
              },
              child: const Text(
                'Add Created Card Data',
                style: TextStyle(fontSize: 16, color: Color(0xffffffff)),
              ),
            ),
            const SizedBox(height: 16),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
