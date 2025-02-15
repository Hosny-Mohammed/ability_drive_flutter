import 'package:ability_drive_flutter/providers/auth_provider.dart';
import 'package:ability_drive_flutter/providers/home_provider.dart';
import 'package:ability_drive_flutter/providers/private_ride_provider.dart';
import 'package:ability_drive_flutter/screens/Welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Driver/providers/auth_driver_provider.dart';
import 'Driver/providers/home_driver_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => DriversProvider()),
        ChangeNotifierProvider(create: (context) => AuthDriverProvider()),
        ChangeNotifierProvider(create: (context) => HomeDriverProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // Removes the debug banner
        theme: ThemeData(
          primarySwatch: Colors.teal, // Example: Set your app's theme color
        ),
        home: WelcomePage(),
      ),
    );
  }
}
