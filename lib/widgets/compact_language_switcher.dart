import 'package:flutter/material.dart';

import '../auth/auth_colors.dart';
import '../l10n/locale_controller.dart';

class CompactLanguageSwitcher extends StatelessWidget {
  const CompactLanguageSwitcher({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLanguage =
        Localizations.localeOf(context).languageCode;

    final isEnglish = currentLanguage == 'en';
    final isArabic = currentLanguage == 'ar';

    return Container(
      height: 38,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1E1E),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AuthColors.yellow,
          width: 1.4,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _LanguageItem(
            flag: '🇺🇸',
            isSelected: isEnglish,
            onTap: () {
              changeAppLocale('en');
            },
          ),

          const SizedBox(width: 3),

          _LanguageItem(
            flag: '🇪🇬',
            isSelected: isArabic,
            onTap: () {
              changeAppLocale('ar');
            },
          ),
        ],
      ),
    );
  }
}

class _LanguageItem extends StatelessWidget {
  final String flag;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageItem({
    required this.flag,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: 34,
        height: 30,
        decoration: BoxDecoration(
          color: isSelected
              ? AuthColors.yellow
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.center,
        child: Text(
          flag,
          style: const TextStyle(
            fontSize: 17,
          ),
        ),
      ),
    );
  }
}