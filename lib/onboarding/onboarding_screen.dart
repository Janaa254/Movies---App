import 'package:flutter/material.dart';

import 'onboarding_data.dart';
import '../auth/login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState
    extends State<OnboardingScreen> {
  final PageController _pageController =
  PageController();

  int currentPage = 0;

  static const Color backgroundColor =
  Color(0xFF0B0D0C);

  static const Color yellowColor =
  Color(0xFFFFC400);

  // ================= NEXT =================

  void nextPage() {
    if (currentPage <
        onboardingData.length - 1) {
      _pageController.nextPage(
        duration:
        const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      finishOnboarding();
    }
  }

  // ================= BACK =================

  void previousPage() {
    if (currentPage > 0) {
      _pageController.previousPage(
        duration:
        const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  // ================= FINISH =================

  void finishOnboarding() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) =>
        const LoginScreen(),
      ),
    );
  }

  // ================= DISPOSE =================

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // ================= BUILD =================

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,

      body: PageView.builder(
        controller: _pageController,

        itemCount: onboardingData.length,

        onPageChanged: (index) {
          setState(() {
            currentPage = index;
          });
        },

        itemBuilder: (context, index) {
          final item =
          onboardingData[index];

          return Stack(
            children: [
              // ================= BACKGROUND IMAGE =================

              Positioned.fill(
                child: Image.asset(
                  item.image,
                  fit: BoxFit.cover,

                  errorBuilder: (
                      context,
                      error,
                      stackTrace,
                      ) {
                    return Container(
                      color: backgroundColor,

                      child: Center(
                        child: Text(
                          'Image not found\n${item.image}',
                          textAlign:
                          TextAlign.center,
                          style:
                          const TextStyle(
                            color:
                            Colors.white54,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // ================= DARK GRADIENT =================

              Positioned.fill(
                child: Container(
                  decoration:
                  const BoxDecoration(
                    gradient:
                    LinearGradient(
                      begin:
                      Alignment.topCenter,
                      end:
                      Alignment.bottomCenter,

                      colors: [
                        Colors.transparent,
                        Color(0x11000000),
                        Color(0x44000000),
                        Color(0x99000000),
                        Color(0xEE0B0D0C),
                        Color(0xFF0B0D0C),
                      ],

                      stops: [
                        0.0,
                        0.35,
                        0.50,
                        0.65,
                        0.82,
                        1.0,
                      ],
                    ),
                  ),
                ),
              ),

              // ================= CONTENT =================

              Align(
                alignment:
                Alignment.bottomCenter,

                child: SafeArea(
                  top: false,

                  child: Padding(
                    padding:
                    const EdgeInsets.fromLTRB(
                      16,
                      0,
                      16,
                      22,
                    ),

                    child: Column(
                      mainAxisSize:
                      MainAxisSize.min,

                      children: [
                        // ================= TITLE =================

                        Text(
                          item.title,

                          textAlign:
                          TextAlign.center,

                          style:
                          TextStyle(
                            color: Colors.white,

                            fontSize:
                            index == 0
                                ? 36
                                : 30,

                            height: 1.22,

                            fontWeight:
                            FontWeight.w500,
                          ),
                        ),

                        // ================= DESCRIPTION =================

                        if (item
                            .description
                            .isNotEmpty) ...[
                          const SizedBox(
                            height: 22,
                          ),

                          Text(
                            item.description,

                            textAlign:
                            TextAlign.center,

                            style:
                            const TextStyle(
                              color:
                              Colors.white70,

                              fontSize: 18,

                              height: 1.45,

                              fontWeight:
                              FontWeight.w400,
                            ),
                          ),

                          const SizedBox(
                            height: 28,
                          ),
                        ],

                        // ================= NEXT / EXPLORE / FINISH =================

                        SizedBox(
                          width:
                          double.infinity,

                          height: 56,

                          child:
                          ElevatedButton(
                            onPressed:
                            nextPage,

                            style:
                            ElevatedButton
                                .styleFrom(
                              backgroundColor:
                              yellowColor,

                              foregroundColor:
                              Colors.black,

                              elevation: 0,

                              shape:
                              RoundedRectangleBorder(
                                borderRadius:
                                BorderRadius
                                    .circular(
                                  16,
                                ),
                              ),
                            ),

                            child: Text(
                              currentPage == 0
                                  ? 'Explore Now'
                                  : currentPage ==
                                  onboardingData.length -
                                      1
                                  ? 'Finish'
                                  : 'Next',

                              style:
                              const TextStyle(
                                fontSize: 20,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        // ================= BACK =================

                        if (currentPage >
                            0) ...[
                          const SizedBox(
                            height: 14,
                          ),

                          SizedBox(
                            width:
                            double.infinity,

                            height: 56,

                            child:
                            OutlinedButton(
                              onPressed:
                              previousPage,

                              style:
                              OutlinedButton
                                  .styleFrom(
                                foregroundColor:
                                yellowColor,

                                side:
                                const BorderSide(
                                  color:
                                  yellowColor,
                                  width: 2,
                                ),

                                shape:
                                RoundedRectangleBorder(
                                  borderRadius:
                                  BorderRadius
                                      .circular(
                                    16,
                                  ),
                                ),
                              ),

                              child:
                              const Text(
                                'Back',

                                style:
                                TextStyle(
                                  fontSize:
                                  20,

                                  fontWeight:
                                  FontWeight
                                      .bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}