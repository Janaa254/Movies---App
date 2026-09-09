import 'package:flutter/material.dart';

import '../auth_colors.dart';
import 'auth_text_field.dart';
import 'auth_primary_button.dart';

class RegisterForm extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController phoneController;

  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final bool isLoading;

  final VoidCallback onTogglePassword;
  final VoidCallback onToggleConfirmPassword;
  final VoidCallback onRegister;

  const RegisterForm({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.phoneController,
    required this.obscurePassword,
    required this.obscureConfirmPassword,
    required this.isLoading,
    required this.onTogglePassword,
    required this.onToggleConfirmPassword,
    required this.onRegister,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AuthTextField(
          controller: nameController,
          hintText: 'Name',
          icon: Icons.badge_outlined,
          borderRadius: 25,
          fontSize: 20,
        ),

        const SizedBox(height: 12),

        AuthTextField(
          controller: emailController,
          hintText: 'Email',
          icon: Icons.email,
          keyboardType: TextInputType.emailAddress,
          borderRadius: 25,
          fontSize: 20,
        ),

        const SizedBox(height: 12),

        AuthTextField(
          controller: passwordController,
          hintText: 'Password',
          icon: Icons.lock,
          obscureText: obscurePassword,
          borderRadius: 25,
          fontSize: 20,
          suffixIcon: IconButton(
            onPressed: onTogglePassword,
            icon: Icon(
              obscurePassword
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: AuthColors.white,
            ),
          ),
        ),

        const SizedBox(height: 12),

        AuthTextField(
          controller: confirmPasswordController,
          hintText: 'Confirm Password',
          icon: Icons.lock,
          obscureText: obscureConfirmPassword,
          borderRadius: 25,
          fontSize: 20,
          suffixIcon: IconButton(
            onPressed: onToggleConfirmPassword,
            icon: Icon(
              obscureConfirmPassword
                  ? Icons.visibility_off
                  : Icons.visibility,
              color: AuthColors.white,
            ),
          ),
        ),

        const SizedBox(height: 12),

        AuthTextField(
          controller: phoneController,
          hintText: 'Phone Number',
          icon: Icons.phone,
          keyboardType: TextInputType.phone,
          borderRadius: 25,
          fontSize: 20,
        ),

        const SizedBox(height: 18),

        AuthPrimaryButton(
          text: 'Create Account',
          onPressed: onRegister,
          isLoading: isLoading,
        ),
      ],
    );
  }
}