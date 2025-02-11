
import 'package:ability_drive_flutter/screens/payment_Method_page.dart';
import 'package:ability_drive_flutter/screens/private_Book.dart';
import 'package:ability_drive_flutter/screens/profile_page.dart';
import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A3A42),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A3A42),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () {
                // الانتقال إلى صفحة البروفايل عند الضغط على الأيقونة
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => profile()),
                );
              },
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // القسم العلوي: الإشعار
          Container(
            color: const Color(0xFF5B6EF8),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'To find your pickup location automatically, turn on location services',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text('Turn on location'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // القسم الثاني: اختيار الموقع
          Expanded(
            child: Container(
              color: const Color(0xFF1A3A42),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // التنقل إلى صفحة البروفايل عند الضغط على الأيقونة أو النص
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PrivateBook()),
                        );
                      },
                      child: Column(
                        children: [
                          const Icon(Icons.directions_car,
                              size: 50, color: Colors.white),
                          const SizedBox(height: 8),
                          const Text(
                            'Book a Private ride',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.black,
                        hintText: 'Enter pickup point',
                        hintStyle: const TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    // القسم الثالث: المعلومات المحيطة
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Around you',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            const Icon(Icons.directions_car, size: 50),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text('From:'),
                                  Text('To:'),
                                  Text('Price:'),
                                  Text('Departure Time:'),
                                  Text('Arrival Time:'),
                                ],
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PaymentMethod()),
                                );
                              },
                              child: const Text('Book'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
