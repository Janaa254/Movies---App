import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/profile/profile_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // ================= COLORS =================

  static const Color background = Color(0xFF0B0D0C);
  static const Color fieldColor = Color(0xFF292B29);
  static const Color yellow = Color(0xFFFFC400);

  // ================= CONTROLLERS =================

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // ================= STATE =================

  bool isLoading = false;
  bool obscurePassword = true;

  // ================= LOGIN =================

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      showMessage('Please fill in all fields.');
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      String message = 'Something went wrong.';

      if (e.code == 'user-not-found') {
        message = 'No account found with this email.';
      } else if (e.code == 'wrong-password' ||
          e.code == 'invalid-credential') {
        message = 'Incorrect email or password.';
      } else if (e.code == 'invalid-email') {
        message = 'Please enter a valid email.';
      }

      showMessage(message);
    } catch (_) {
      showMessage('Something went wrong.');
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
        content: Text(message),
        backgroundColor: yellow,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ================= NAVIGATION =================

  void goToRegister() {
    Navigator.pushNamed(
      context,
      '/register',
    );
  }

  void goToForgetPassword() {
    Navigator.pushNamed(
      context,
      '/forget-password',
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

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 23),
              child: Column(
                children: [
                  // ================= LOGO =================

                  const SizedBox(height: 20),

                  SizedBox(
                    height: 120,
                    width: 170,
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.play_circle_outline,
                          color: yellow,
                          size: 70,
                        );
                      },
                    ),
                  ),

                  SizedBox(height: height * 0.025),

                  // ================= EMAIL FIELD =================

                  _buildField(
                    controller: emailController,
                    hintText: 'Email',
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  SizedBox(height: height * 0.018),

                  // ================= PASSWORD FIELD =================

                  _buildField(
                    controller: passwordController,
                    hintText: 'Password',
                    icon: Icons.lock,
                    obscureText: obscurePassword,
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
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),

                  // ================= FORGET PASSWORD =================

                  SizedBox(
                    height: height * 0.055,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: goToForgetPassword,
                        child: const Text(
                          'Forget Password ?',
                          style: TextStyle(
                            color: yellow,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // ================= LOGIN BUTTON =================

                  SizedBox(
                    width: double.infinity,
                    height: height * 0.075,
                    child: ElevatedButton(
                      onPressed: isLoading ? null : login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: yellow,
                        disabledBackgroundColor:
                        yellow.withValues(alpha: 0.5),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
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
                        'Login',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.025),

                  // ================= CREATE ACCOUNT =================

                  SizedBox(
                    height: height * 0.04,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don’t Have Account ? ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          GestureDetector(
                            onTap: goToRegister,
                            child: const Text(
                              'Create One',
                              style: TextStyle(
                                color: yellow,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(height: height * 0.025),

                  // ================= OR DIVIDER =================

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 2,
                          color: yellow,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 13),
                        child: Text(
                          'OR',
                          style: TextStyle(
                            color: yellow,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 2,
                          color: yellow,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: height * 0.025),

                  // ================= GOOGLE LOGIN =================

                  SizedBox(
                    width: double.infinity,
                    height: height * 0.075,
                    child: ElevatedButton(
                      onPressed: () {
                        showMessage(
                          'Google login is not implemented yet.',
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: yellow,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'G',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 29,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 15),
                          Text(
                            'Login With Google',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 19,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  const Spacer(),

                  // ================= LANGUAGE SWITCHER =================

                  Container(
                    width: 110,
                    height: 43,
                    decoration: BoxDecoration(
                      color: background,
                      border: Border.all(
                        color: yellow,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        const Text(
                          '🇺🇸',
                          style: TextStyle(
                            fontSize: 23,
                          ),
                        ),
                        Container(
                          width: 2,
                          height: 25,
                          color: yellow,
                        ),
                        const Text(
                          '🇪🇬',
                          style: TextStyle(
                            fontSize: 23,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: height * 0.018),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  // ================= TEXT FIELD =================

  Widget _buildField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    TextInputType? keyboardType,
    Widget? suffixIcon,
  }) {
    return SizedBox(
      height: 63,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 17,
        ),
        cursorColor: yellow,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.white,
            fontSize: 17,
          ),
          prefixIcon: Icon(
            icon,
            color: Colors.white,
            size: 28,
          ),
          suffixIcon: suffixIcon,
          filled: true,
          fillColor: fieldColor,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 15,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: const BorderSide(
              color: yellow,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }

  // ================= DISPOSE =================

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}