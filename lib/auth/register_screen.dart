import 'package:flutter/material.dart';

import 'auth_colors.dart';
import 'register_controller.dart';
import 'register_data.dart';

import 'widgets/register_header.dart';
import 'widgets/register_form.dart';
import 'widgets/register_avatar_selector.dart';
import 'widgets/language_switcher.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() =>
      _RegisterScreenState();
}

class _RegisterScreenState
    extends State<RegisterScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController =
  TextEditingController();
  final phoneController = TextEditingController();

  final RegisterController registerController =
  RegisterController();

  bool isLoading = false;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  int selectedAvatar = 0;

  Future<void> register() async {
    setState(() => isLoading = true);

    final error = await registerController.register(
      name: nameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      confirmPassword:
      confirmPasswordController.text.trim(),
      phone: phoneController.text.trim(),
    );

    if (!mounted) return;

    setState(() => isLoading = false);

    if (error != null) {
      showMessage(error);
      return;
    }

    showMessage('Account created successfully.');

    Navigator.pop(context);
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AuthColors.yellow,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AuthColors.background,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
          ),

          child: Column(
            children: [
              SizedBox(
                height: 60,
                child: RegisterHeader(
                  onBack: () =>
                      Navigator.pop(context),
                ),
              ),

              Expanded(
                child: RegisterAvatarSelector(
                  avatars:
                  RegisterData.avatars,
                  selectedAvatar:
                  selectedAvatar,
                  onSelected: (index) {
                    setState(() {
                      selectedAvatar = index;
                    });
                  },
                ),
              ),

              const Text(
                'Avatar',
                style: TextStyle(
                  color: AuthColors.white,
                  fontSize: 25,
                ),
              ),

              const SizedBox(height: 12),

              RegisterForm(
                nameController:
                nameController,
                emailController:
                emailController,
                passwordController:
                passwordController,
                confirmPasswordController:
                confirmPasswordController,
                phoneController:
                phoneController,
                obscurePassword:
                obscurePassword,
                obscureConfirmPassword:
                obscureConfirmPassword,
                isLoading:
                isLoading,

                onTogglePassword: () {
                  setState(() {
                    obscurePassword =
                    !obscurePassword;
                  });
                },

                onToggleConfirmPassword: () {
                  setState(() {
                    obscureConfirmPassword =
                    !obscureConfirmPassword;
                  });
                },

                onRegister:
                register,
              ),

              const SizedBox(height: 12),

              Row(
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already Have Account ? ',
                    style: TextStyle(
                      color:
                      AuthColors.white,
                      fontSize: 18,
                    ),
                  ),
                  GestureDetector(
                    onTap: () =>
                        Navigator.pop(context),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        color:
                        AuthColors.yellow,
                        fontSize: 18,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              const LanguageSwitcher(),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

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