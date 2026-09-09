import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

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
  final nameController =
  TextEditingController();

  final emailController =
  TextEditingController();

  final passwordController =
  TextEditingController();

  final confirmPasswordController =
  TextEditingController();

  final phoneController =
  TextEditingController();

  final RegisterController registerController =
  RegisterController();

  bool isLoading = false;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;

  int selectedAvatar = 0;

  // ================= REGISTER =================

  Future<void> register() async {
    final l10n =
    AppLocalizations.of(context)!;

    setState(() {
      isLoading = true;
    });

    final error =
    await registerController.register(
      name:
      nameController.text.trim(),
      email:
      emailController.text.trim(),
      password:
      passwordController.text.trim(),
      confirmPassword:
      confirmPasswordController
          .text
          .trim(),
      phone:
      phoneController.text.trim(),
      l10n: l10n,
    );

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    if (error != null) {
      showMessage(error);
      return;
    }

    showMessage(
      l10n.accountCreatedSuccessfully,
    );

    Navigator.pop(context);
  }

  // ================= MESSAGE =================

  void showMessage(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor:
        AuthColors.yellow,
        behavior:
        SnackBarBehavior.floating,
      ),
    );
  }

  // ================= BUILD =================

  @override
  Widget build(BuildContext context) {
    final l10n =
    AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor:
      AuthColors.background,

      body: SafeArea(
        child: Padding(
          padding:
          const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: Column(
            children: [
              // ================= HEADER =================

              SizedBox(
                height: 60,
                child: RegisterHeader(
                  onBack: () {
                    Navigator.pop(context);
                  },
                ),
              ),

              // ================= AVATAR SELECTOR =================

              Expanded(
                child:
                RegisterAvatarSelector(
                  avatars:
                  RegisterData.avatars,
                  selectedAvatar:
                  selectedAvatar,
                  onSelected: (index) {
                    setState(() {
                      selectedAvatar =
                          index;
                    });
                  },
                ),
              ),

              // ================= AVATAR TITLE =================

              Text(
                l10n.avatar,
                style: const TextStyle(
                  color:
                  AuthColors.white,
                  fontSize: 25,
                ),
              ),

              const SizedBox(
                height: 12,
              ),

              // ================= REGISTER FORM =================

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

                onToggleConfirmPassword:
                    () {
                  setState(() {
                    obscureConfirmPassword =
                    !obscureConfirmPassword;
                  });
                },

                onRegister:
                register,
              ),

              const SizedBox(
                height: 12,
              ),

              // ================= LOGIN LINK =================

              Row(
                mainAxisAlignment:
                MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      '${l10n.alreadyHaveAccount} ',
                      style:
                      const TextStyle(
                        color:
                        AuthColors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.pop(
                        context,
                      );
                    },
                    child: Text(
                      l10n.login,
                      style:
                      const TextStyle(
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

              const SizedBox(
                height: 12,
              ),

              // ================= LANGUAGE =================

              const LanguageSwitcher(),

              const SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
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