import 'package:ability_drive_flutter/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../color_palette.dart';
import '../../widgets/custom_text_field.dart';
import '../Home_page.dart';

class RegistrationScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final ValueNotifier<bool> isDisabled = ValueNotifier<bool>(false);

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AuthProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Registration',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Row(
                        children: [
                          Image.network(
                            'https://uxwing.com/wp-content/themes/uxwing/download/flags-landmarks/egypt-flag-icon.png',
                            width: 24,
                            height: 45,
                            errorBuilder: (context, error, stackTrace) => const Placeholder(),
                          ),
                          const SizedBox(width: 8),
                          const Text(
                            '+02',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: CustomTextField(
                        controller: _phoneController,
                        hintText: '81234 56789',
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your phone number';
                          } else if (value.length != 11) {
                            return 'Phone number must be exactly 11 digits';
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _emailController,
                  hintText: 'Email',
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$")
                        .hasMatch(value)) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _firstNameController,
                  hintText: 'First Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _lastNameController,
                  hintText: 'Last Name',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: _passwordController,
                  hintText: 'Password',
                  isPassword: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),

                // 🔹 Improved "Are You Disabled?" Section
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.white70, width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Are You Disabled?',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      ValueListenableBuilder<bool>(
                        valueListenable: isDisabled,
                        builder: (context, value, child) {
                          return Switch(
                            value: value,
                            onChanged: (newValue) {
                              isDisabled.value = newValue;
                            },
                            activeColor: Colors.blueAccent,
                            inactiveTrackColor: Colors.white38,
                          );
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await provider.registration(
                          email: _emailController.text.trim(),
                          firstName: _firstNameController.text.trim(),
                          lastName: _lastNameController.text.trim(),
                          password: _passwordController.text.trim(),
                          phone: _phoneController.text.trim(),
                          isDisabled: isDisabled.value,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(provider.registrationSnackbar!);
                        if (provider.registrationStatus != null && provider.registrationStatus!) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Homepage(userId: provider.model!.id, isDisabled: isDisabled.value),
                            ),
                          );
                        }
                      }
                    },
                    child: const Text(
                      'Next',
                      style: TextStyle(color: AppColors.background, fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}