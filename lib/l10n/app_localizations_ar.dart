// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'تطبيق الأفلام';

  @override
  String get home => 'الرئيسية';

  @override
  String get search => 'بحث';

  @override
  String get browse => 'تصفح';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get favorites => 'المفضلة';

  @override
  String get watchList => 'قائمة المشاهدة';

  @override
  String get history => 'السجل';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get register => 'إنشاء حساب';

  @override
  String get createAccount => 'إنشاء حساب';

  @override
  String get editProfile => 'تعديل الملف الشخصي';

  @override
  String get exit => 'تسجيل الخروج';

  @override
  String get noMoviesWatchList => 'لا توجد أفلام في قائمة المشاهدة';

  @override
  String get watchListDescription =>
      'الأفلام التي تضيفيها إلى قائمة المشاهدة ستظهر هنا.';

  @override
  String get noFavorites => 'لا توجد أفلام مفضلة';

  @override
  String get favoritesDescription =>
      'الأفلام التي تضيفيها إلى المفضلة ستظهر هنا.';

  @override
  String get summary => 'الملخص';

  @override
  String get genres => 'الأنواع';

  @override
  String get screenShots => 'لقطات الشاشة';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get noMoviesFound => 'لا توجد أفلام';

  @override
  String get somethingWentWrong => 'حدث خطأ ما';
}
