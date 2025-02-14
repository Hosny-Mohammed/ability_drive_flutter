import 'package:flutter/material.dart';
import 'package:ability_drive_flutter/widgets/custom_text_field.dart';
import 'package:ability_drive_flutter/screens/Home_page.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginDriverScreen extends StatelessWidget {
  const LoginDriverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final TextEditingController licenseNumberController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xff17494c),
      appBar: AppBar(
        title: const Text(
          "Login Driver",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xff17494c),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // License Number Field using CustomTextField
              CustomTextField(
                controller: licenseNumberController,
                hintText: 'Enter your license number',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your license number';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Password Field using CustomTextField
              CustomTextField(
                controller: passwordController,
                hintText: 'Password',
                isPassword: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  } else if (value.length < 9) {
                    return 'Password must be at least 8 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // Login Button
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => Homepage()),
                    // );
                  }
                },
                child: const Text('Login', style: TextStyle(color: Colors.white)),
              ),
              const SizedBox(height: 30),

              // Divider for "or" section
              const Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: Text('or', style: TextStyle(color: Colors.grey)),
                  ),
                  Expanded(child: Divider(color: Colors.grey)),
                ],
              ),
              const SizedBox(height: 20),

              // "Join in Application" Link
              GestureDetector(
                onTap: () async {
                  // Uri uri = Uri.parse(url);
                  // if (await canLaunchUrl(uri)) {
                  // await launchUrl(uri, mode: LaunchMode.externalApplication); // Opens in external browser.
                  // } else {
                  // throw 'Could not launch $url';
                  // }
                },
                child: const Text(
                  "Join Us",
                  style: TextStyle(
                    color: Colors.lightBlue,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
