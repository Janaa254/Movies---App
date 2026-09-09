// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Movies App';

  @override
  String get home => 'Home';

  @override
  String get search => 'Search';

  @override
  String get browse => 'Browse';

  @override
  String get profile => 'Profile';

  @override
  String get favorites => 'Favorites';

  @override
  String get watchList => 'Watch List';

  @override
  String get history => 'History';

  @override
  String get login => 'Login';

  @override
  String get register => 'Register';

  @override
  String get createAccount => 'Create Account';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get exit => 'Exit';

  @override
  String get noMoviesWatchList => 'No Movies in Watch List';

  @override
  String get watchListDescription =>
      'Movies you add to your watch list will appear here.';

  @override
  String get noFavorites => 'No Favorite Movies';

  @override
  String get favoritesDescription =>
      'Movies you add to favorites will appear here.';

  @override
  String get summary => 'Summary';

  @override
  String get genres => 'Genres';

  @override
  String get screenShots => 'Screen Shots';

  @override
  String get retry => 'Retry';

  @override
  String get noMoviesFound => 'No movies found';

  @override
  String get somethingWentWrong => 'Something went wrong';
}
