import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void verifyEmail() {
    final email = emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email'),
        ),
      );
      return;
    }

    // Add your API or Firebase password reset logic here
    debugPrint('Email: $email');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101211),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            children: [
              // Header
              SizedBox(
                height: 70,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back,
                          color: Color(0xFFFFC400),
                          size: 38,
                        ),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                    const Text(
                      'Forget Password',
                      style: TextStyle(
                        color: Color(0xFFFFC400),
                        fontSize: 30,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(flex: 1),

              // Illustration
              Expanded(
                flex: 5,
                child: Image.asset(
                  'assets/images/forget_password.png',
                  fit: BoxFit.contain,
                ),
              ),

              const Spacer(flex: 1),

              // Email Field
              SizedBox(
                height: 75,
                width: double.infinity,
                child: TextField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color(0xFF292B2A),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide.none,
                    ),
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Colors.white,
                      size: 35,
                    ),
                    hintText: 'Email',
                    hintStyle: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // Verify Email Button
              SizedBox(
                height: 75,
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: verifyEmail,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFC400),
                    foregroundColor: Colors.black,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: const Text(
                    'Verify Email',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}