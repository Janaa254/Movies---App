import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({
    super.key,
  });

  @override
  State<ForgetPasswordScreen> createState() =>
      _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState
    extends State<ForgetPasswordScreen> {
  final TextEditingController emailController =
  TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void verifyEmail() {
    final l10n =
    AppLocalizations.of(context)!;

    final email =
    emailController.text.trim();

    if (email.isEmpty) {
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            l10n.pleaseEnterYourEmail,
          ),
        ),
      );

      return;
    }

    debugPrint('Email: $email');
  }

  @override
  Widget build(BuildContext context) {
    final l10n =
    AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor:
      const Color(0xFF101211),
      body: SafeArea(
        child: Padding(
          padding:
          const EdgeInsets.symmetric(
            horizontal: 30,
          ),
          child: Column(
            children: [
              // Header
              SizedBox(
                height: 70,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment:
                      AlignmentDirectional
                          .centerStart,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(
                            context,
                          );
                        },
                        icon: Icon(
                          Directionality.of(
                              context) ==
                              TextDirection.rtl
                              ? Icons.arrow_forward
                              : Icons.arrow_back,
                          color:
                          const Color(
                            0xFFFFC400,
                          ),
                          size: 38,
                        ),
                        padding:
                        EdgeInsets.zero,
                      ),
                    ),

                    Text(
                      l10n.forgetPassword,
                      style:
                      const TextStyle(
                        color: Color(
                          0xFFFFC400,
                        ),
                        fontSize: 30,
                        fontWeight:
                        FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(
                flex: 1,
              ),

              Expanded(
                flex: 5,
                child: Image.asset(
                  'assets/images/forget_password.png',
                  fit: BoxFit.contain,
                ),
              ),

              const Spacer(
                flex: 1,
              ),

              SizedBox(
                height: 75,
                width: double.infinity,
                child: TextField(
                  controller:
                  emailController,
                  keyboardType:
                  TextInputType
                      .emailAddress,
                  style:
                  const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                  ),
                  decoration:
                  InputDecoration(
                    filled: true,
                    fillColor:
                    const Color(
                      0xFF292B2A,
                    ),
                    border:
                    OutlineInputBorder(
                      borderRadius:
                      BorderRadius
                          .circular(
                        24,
                      ),
                      borderSide:
                      BorderSide.none,
                    ),
                    prefixIcon:
                    const Icon(
                      Icons.email,
                      color:
                      Colors.white,
                      size: 35,
                    ),
                    hintText:
                    l10n.email,
                    hintStyle:
                    const TextStyle(
                      color:
                      Colors.white,
                      fontSize: 22,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 18,
              ),

              SizedBox(
                height: 75,
                width: double.infinity,
                child:
                ElevatedButton(
                  onPressed:
                  verifyEmail,
                  style:
                  ElevatedButton
                      .styleFrom(
                    backgroundColor:
                    const Color(
                      0xFFFFC400,
                    ),
                    foregroundColor:
                    Colors.black,
                    elevation: 0,
                    shape:
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius
                          .circular(
                        24,
                      ),
                    ),
                  ),
                  child: Text(
                    l10n.verifyEmail,
                    style:
                    const TextStyle(
                      fontSize: 25,
                      fontWeight:
                      FontWeight.w500,
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}