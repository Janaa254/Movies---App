import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // ================= COLORS =================

  static const Color background = Color(0xFF0D0F0E);
  static const Color fieldColor = Color(0xFF292B2A);
  static const Color yellow = Color(0xFFFFC400);
  static const Color white = Color(0xFFF5F5F5);

  // ================= CONTROLLERS =================

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();

  // ================= STATE =================

  bool isLoading = false;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  int selectedAvatar = 0;

  // ================= AVATARS =================

  final List<String> avatars = [
    'assets/images/avatar_1.png',
    'assets/images/avatar_2.png',
    'assets/images/avatar_3.png',
    'assets/images/avatar_4.png',
    'assets/images/avatar_5.png',
  ];

  // ================= REGISTER =================

  Future<void> register() async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();
    final confirmPassword = confirmPasswordController.text.trim();
    final phone = phoneController.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        phone.isEmpty) {
      showMessage('Please fill in all fields.');
      return;
    }

    if (password != confirmPassword) {
      showMessage('Passwords do not match.');
      return;
    }

    if (password.length < 6) {
      showMessage('Password must be at least 6 characters.');
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await credential.user?.updateDisplayName(name);

      if (!mounted) return;

      showMessage('Account created successfully.');

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      String message = 'Something went wrong.';

      if (e.code == 'email-already-in-use') {
        message = 'This email is already in use.';
      } else if (e.code == 'invalid-email') {
        message = 'Please enter a valid email.';
      } else if (e.code == 'weak-password') {
        message = 'The password is too weak.';
      }

      showMessage(message);
    } catch (e) {
      showMessage(e.toString());
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  // ================= MESSAGE =================

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: yellow,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ================= BUILD =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            final height = constraints.maxHeight;
            final width = constraints.maxWidth;

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                children: [
                  // ================= TOP BAR =================

                  SizedBox(
                    height: height * 0.07,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            padding: EdgeInsets.zero,
                            icon: const Icon(
                              Icons.arrow_back,
                              color: yellow,
                              size: 36,
                            ),
                          ),
                        ),
                        const Text(
                          'Register',
                          style: TextStyle(
                            color: yellow,
                            fontSize: 28,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // ================= AVATAR SECTION =================

                  Expanded(
                    flex: 5,
                    child: _buildAvatarSelector(width),
                  ),

                  // ================= AVATAR LABEL =================

                  SizedBox(
                    height: height * 0.045,
                    child: const Center(
                      child: Text(
                        'Avatar',
                        style: TextStyle(
                          color: white,
                          fontSize: 25,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.012),

                  // ================= NAME FIELD =================

                  _buildField(
                    controller: nameController,
                    hint: 'Name',
                    icon: Icons.badge_outlined,
                    height: height * 0.067,
                  ),

                  SizedBox(height: height * 0.012),

                  // ================= EMAIL FIELD =================

                  _buildField(
                    controller: emailController,
                    hint: 'Email',
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    height: height * 0.067,
                  ),

                  SizedBox(height: height * 0.012),

                  // ================= PASSWORD FIELD =================

                  _buildField(
                    controller: passwordController,
                    hint: 'Password',
                    icon: Icons.lock,
                    obscureText: obscurePassword,
                    height: height * 0.067,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscurePassword = !obscurePassword;
                        });
                      },
                      icon: Icon(
                        obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: white,
                        size: 30,
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.012),

                  // ================= CONFIRM PASSWORD FIELD =================

                  _buildField(
                    controller: confirmPasswordController,
                    hint: 'Confirm Password',
                    icon: Icons.lock,
                    obscureText: obscureConfirmPassword,
                    height: height * 0.067,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscureConfirmPassword =
                          !obscureConfirmPassword;
                        });
                      },
                      icon: Icon(
                        obscureConfirmPassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: white,
                        size: 30,
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.012),

                  // ================= PHONE FIELD =================

                  _buildField(
                    controller: phoneController,
                    hint: 'Phone Number',
                    icon: Icons.phone,
                    keyboardType: TextInputType.phone,
                    height: height * 0.067,
                  ),

                  SizedBox(height: height * 0.018),

                  // ================= CREATE ACCOUNT BUTTON =================

                  SizedBox(
                    width: double.infinity,
                    height: height * 0.072,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : register,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: yellow,
                        disabledBackgroundColor:
                        yellow.withValues(alpha: 0.5),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(28),
                        ),
                      ),
                      child: isLoading
                          ? const SizedBox(
                        width: 25,
                        height: 25,
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          color: Colors.black,
                        ),
                      )
                          : const Text(
                        'Create Account',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.015),

                  // ================= LOGIN =================

                  SizedBox(
                    height: height * 0.04,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          children: [
                            const TextSpan(
                              text: 'Already Have Account ? ',
                              style: TextStyle(
                                color: white,
                                fontSize: 20,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            WidgetSpan(
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  'Login',
                                  style: TextStyle(
                                    color: yellow,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.012),

                  // ================= LANGUAGE SWITCHER =================

                  SizedBox(
                    height: height * 0.055,
                    child: _buildLanguageSwitcher(),
                  ),

                  SizedBox(height: height * 0.012),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // ================= AVATAR SELECTOR =================

  Widget _buildAvatarSelector(double screenWidth) {
    return Center(
      child: SizedBox(
        height: 180,
        width: screenWidth,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 5),
          itemCount: avatars.length,
          itemBuilder: (context, index) {
            final isSelected = selectedAvatar == index;

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedAvatar = index;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                width: isSelected ? 145 : 95,
                height: isSelected ? 145 : 95,
                margin: EdgeInsets.symmetric(
                  horizontal: isSelected ? 5 : 8,
                  vertical: isSelected ? 15 : 42,
                ),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: isSelected
                      ? Border.all(
                    color: yellow,
                    width: 4,
                  )
                      : null,
                  boxShadow: isSelected
                      ? [
                    BoxShadow(
                      color: yellow.withValues(alpha: 0.35),
                      blurRadius: 15,
                      spreadRadius: 2,
                    ),
                  ]
                      : null,
                ),
                child: ClipOval(
                  child: Image.asset(
                    avatars[index],
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: fieldColor,
                        child: Icon(
                          Icons.person,
                          color: white,
                          size: isSelected ? 60 : 40,
                        ),
                      );
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  // ================= INPUT FIELD =================

  Widget _buildField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required double height,
    bool obscureText = false,
    TextInputType? keyboardType,
    Widget? suffixIcon,
  }) {
    return SizedBox(
      height: height,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(
          color: white,
          fontSize: 20,
        ),
        cursorColor: yellow,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            color: white,
            fontSize: 20,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.only(
              left: 15,
              right: 12,
            ),
            child: Icon(
              icon,
              color: white,
              size: 32,
            ),
          ),
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: fieldColor,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(
              color: yellow,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }

  // ================= LANGUAGE SWITCHER =================

  Widget _buildLanguageSwitcher() {
    return Container(
      width: 160,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(
          color: yellow,
          width: 3,
        ),
      ),
      child: Row(
        children: [
          // USA
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: yellow,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  '🇺🇸',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 6),

          // Egypt
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  '🇪🇬',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ================= DISPOSE =================

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();

    super.dispose();
  }
}