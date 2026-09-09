import 'package:flutter/material.dart';
import 'package:movies_app/profile/profile_screen.dart';

import '../l10n/app_localizations.dart';

import 'auth_colors.dart';
import 'login_controller.dart';

import 'widgets/auth_text_field.dart';
import 'widgets/auth_primary_button.dart';
import 'widgets/auth_divider.dart';
import 'widgets/language_switcher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController =
  TextEditingController();

  final passwordController =
  TextEditingController();

  final LoginController loginController =
  LoginController();

  bool isLoading = false;
  bool obscurePassword = true;

  // ================= LOGIN =================

  Future<void> login() async {
    final email =
    emailController.text.trim();

    final password =
    passwordController.text.trim();

    setState(() {
      isLoading = true;
    });

    final String? error =
    await loginController.login(
      email: email,
      password: password,
    );

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    if (error != null) {
      showMessage(error);
      return;
    }

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) =>
        const ProfileScreen(),
      ),
    );
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
    final l10n =
    AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor:
      AuthColors.background,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (
              context,
              constraints,
              ) {
            final height =
                constraints.maxHeight;

            return Padding(
              padding:
              const EdgeInsets.symmetric(
                horizontal: 23,
              ),
              child: Column(
                children: [
                  // ================= LOGO =================

                  const SizedBox(
                    height: 20,
                  ),

                  SizedBox(
                    height: 120,
                    width: 170,
                    child: Image.asset(
                      'assets/images/logo.png',
                      fit: BoxFit.contain,
                      errorBuilder: (
                          context,
                          error,
                          stackTrace,
                          ) {
                        return const Icon(
                          Icons
                              .play_circle_outline,
                          color:
                          AuthColors.yellow,
                          size: 70,
                        );
                      },
                    ),
                  ),

                  SizedBox(
                    height:
                    height * 0.025,
                  ),

                  // ================= EMAIL =================

                  AuthTextField(
                    controller:
                    emailController,
                    hintText:
                    l10n.email,
                    icon: Icons.email,
                    keyboardType:
                    TextInputType
                        .emailAddress,
                  ),

                  SizedBox(
                    height:
                    height * 0.018,
                  ),

                  // ================= PASSWORD =================

                  AuthTextField(
                    controller:
                    passwordController,
                    hintText:
                    l10n.password,
                    icon: Icons.lock,
                    obscureText:
                    obscurePassword,
                    suffixIcon:
                    IconButton(
                      onPressed: () {
                        setState(() {
                          obscurePassword =
                          !obscurePassword;
                        });
                      },
                      icon: Icon(
                        obscurePassword
                            ? Icons
                            .visibility_off
                            : Icons
                            .visibility,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),

                  // ================= FORGET PASSWORD =================

                  SizedBox(
                    height:
                    height * 0.055,
                    child: Align(
                      alignment:
                      AlignmentDirectional
                          .centerEnd,
                      child:
                      GestureDetector(
                        onTap:
                        goToForgetPassword,
                        child: Text(
                          l10n
                              .forgetPasswordQuestion,
                          style:
                          const TextStyle(
                            color:
                            AuthColors.yellow,
                            fontSize: 16,
                            fontWeight:
                            FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // ================= LOGIN =================

                  SizedBox(
                    height:
                    height * 0.075,
                    child:
                    AuthPrimaryButton(
                      text:
                      l10n.login,
                      onPressed: login,
                      isLoading:
                      isLoading,
                    ),
                  ),

                  SizedBox(
                    height:
                    height * 0.025,
                  ),

                  // ================= CREATE ACCOUNT =================

                  SizedBox(
                    height:
                    height * 0.04,
                    child: FittedBox(
                      fit:
                      BoxFit.scaleDown,
                      child: Row(
                        mainAxisAlignment:
                        MainAxisAlignment
                            .center,
                        children: [
                          Text(
                            '${l10n.dontHaveAccount} ',
                            style:
                            const TextStyle(
                              color:
                              Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          GestureDetector(
                            onTap:
                            goToRegister,
                            child: Text(
                              l10n.createOne,
                              style:
                              const TextStyle(
                                color:
                                AuthColors.yellow,
                                fontSize: 16,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height:
                    height * 0.025,
                  ),

                  // ================= OR =================

                  const AuthDivider(),

                  SizedBox(
                    height:
                    height * 0.025,
                  ),

                  // ================= GOOGLE LOGIN =================

                  AuthPrimaryButton(
                    text:
                    l10n.loginWithGoogle,
                    onPressed: () {
                      showMessage(
                        l10n
                            .googleLoginNotImplemented,
                      );
                    },
                  ),

                  const Spacer(),

                  const LanguageSwitcher(),

                  SizedBox(
                    height:
                    height * 0.018,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}