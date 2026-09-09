import 'package:flutter/material.dart';

import '../../l10n/locale_controller.dart';
import '../auth_colors.dart';

class LanguageSwitcher extends StatelessWidget {
  const LanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLanguage =
        Localizations.localeOf(context).languageCode;

    final bool isEnglish =
        currentLanguage == 'en';

    final bool isArabic =
        currentLanguage == 'ar';

    return Container(
      width: 130,
      height: 48,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        border: Border.all(
          color: AuthColors.yellow,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(25),
      ),
      child: Row(
        children: [
          // ================= ENGLISH =================

          Expanded(
            child: GestureDetector(
              onTap: () {
                appLocale.value =
                const Locale('en');
              },
              child: AnimatedContainer(
                duration:
                const Duration(milliseconds: 200),
                height: double.infinity,
                decoration: BoxDecoration(
                  color: isEnglish
                      ? AuthColors.yellow
                      : Colors.transparent,
                  borderRadius:
                  BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    '🇺🇸',
                    style: TextStyle(
                      fontSize:
                      isEnglish ? 23 : 21,
                    ),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(width: 4),

          // ================= ARABIC =================

          Expanded(
            child: GestureDetector(
              onTap: () {
                appLocale.value =
                const Locale('ar');
              },
              child: AnimatedContainer(
                duration:
                const Duration(milliseconds: 200),
                height: double.infinity,
                decoration: BoxDecoration(
                  color: isArabic
                      ? AuthColors.yellow
                      : Colors.transparent,
                  borderRadius:
                  BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    '🇪🇬',
                    style: TextStyle(
                      fontSize:
                      isArabic ? 23 : 21,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}