# Movies App

A modern, responsive, feature-rich Flutter movie application built with Firebase, BLoC state management, REST API integration, localization, persistent language preferences, user authentication, favorites, watchlists, profile management, movie browsing, searching, and detailed movie information.

The application is designed to provide a smooth cinematic experience with a clean dark UI, yellow accent color, responsive layouts, reusable widgets, structured architecture, and support for both English and Arabic.

---

## Project Overview

Movies App is a complete Flutter-based mobile application that allows users to discover, browse, search, save, and manage movies through a modern and intuitive interface.

The app combines:

* Flutter
* Firebase Authentication
* Cloud Firestore
* BLoC State Management
* REST API integration
* Localization
* Shared Preferences
* Reusable widgets
* Clean feature-based project structure

The project focuses on providing a polished user experience while maintaining clean code separation between presentation, business logic, services, models, authentication, localization, and Firebase operations.

---

# Core Features

## Authentication

The application includes a complete authentication flow using Firebase Authentication.

Supported authentication features include:

* User registration
* User login
* User logout
* Email validation
* Password validation
* Confirm password validation
* Firebase authentication error handling
* Persistent authenticated Firebase session
* Guest profile experience
* Navigation to Home after successful login
* User-friendly localized error messages

Examples of handled authentication errors:

* Empty fields
* Invalid email
* Weak password
* Email already in use
* User not found
* Wrong password
* Invalid credentials
* Recent login required for sensitive account operations

---

## User Registration

Users can create a new account using:

* Name
* Email
* Password
* Confirm password
* Phone number
* Avatar selection

The registration flow validates user input before sending the registration request to Firebase Authentication.

After successful account creation, the user can continue using the application with their authenticated Firebase account.

---

## User Login

Users can log in using their Firebase Authentication credentials.

The login process includes:

* Email field
* Password field
* Password visibility toggle
* Forget Password navigation
* Localized validation messages
* Loading state
* Firebase error handling
* Automatic navigation to Home after successful login

After login, previous authentication screens are removed from the navigation stack.

---

## Forget Password

The application includes a dedicated Forget Password screen as part of the authentication flow.

It currently provides the UI and validation structure for password recovery.

The project is prepared for integrating Firebase password reset functionality using:

```dart
FirebaseAuth.instance.sendPasswordResetEmail(
  email: email,
);
```

---

## Google Login UI

The Login screen includes a Google Login button.

The UI and required dependency are available, while full Google authentication integration can be implemented later.

The current application provides a localized informational message when Google Login is selected.

---

# Firebase Integration

The application uses Firebase for authentication and user-related cloud data.

Firebase services used:

* Firebase Core
* Firebase Authentication
* Cloud Firestore

Firebase is initialized when the application starts using FlutterFire configuration.

Example:

```dart
await Firebase.initializeApp(
  options: DefaultFirebaseOptions.currentPlatform,
);
```

The Android application is connected to the Firebase project through:

```text
google-services.json
```

Firebase project configuration includes:

```text
Project ID:
movies-app-rewan

Android Package:
com.example.movies_app
```

---

# Cloud Firestore

Cloud Firestore is used for storing and retrieving user-related movie data.

Firestore currently supports:

* User profile data
* Avatar selection
* Favorites
* Watch List
* Favorite movie count
* Watch List movie count

User-specific collections are organized under the authenticated user's UID.

Example structure:

```text
users
└── {userId}
    ├── profile data
    ├── favorites
    │   ├── {movieId}
    │   └── {movieId}
    └── watchlist
        ├── {movieId}
        └── {movieId}
```

This ensures that each authenticated user has their own independent movie collections.

---

# Firestore User Profile Data

The application stores user profile information inside Firestore.

Example user document:

```json
{
  "avatarIndex": 0,
  "name": "User Name",
  "email": "user@example.com"
}
```

Profile information is saved using merge behavior so existing document fields are preserved.

```dart
SetOptions(
  merge: true,
)
```

---

# Favorites System

Users can add movies to their personal Favorites collection.

Favorites are stored in Firestore per authenticated user.

Main capabilities:

* Add movie to Favorites
* Remove movie from Favorites
* Detect whether a movie is already favorited
* Display favorite state in Movie Details
* Stream favorite movies
* Display favorite movie count
* Display Favorites inside Profile
* Firebase-backed persistence

Favorites are handled using a dedicated service:

```text
FavoriteService
```

Firestore structure:

```text
users/{uid}/favorites/{movieId}
```

---

# Watch List System

Users can save movies to their personal Watch List.

Watch List capabilities include:

* Add movie to Watch List
* Remove movie from Watch List
* Check whether movie exists in Watch List
* Show saved Watch List movies
* Display Watch List count
* Persist Watch List data using Firestore
* Update UI automatically through Firestore streams

Watch List operations are handled by:

```text
WatchlistService
```

Firestore structure:

```text
users/{uid}/watchlist/{movieId}
```

---

# History Section

The Profile includes a dedicated History section.

The History interface is already integrated into the profile tab structure.

Current sections:

```text
Watch List
History
Favorites
```

The History section currently contains an empty-state interface and is prepared for future movie playback history storage.

Potential Firestore structure:

```text
users/{uid}/history/{movieId}
```

---

# User Profile

The Profile screen provides a centralized place for account and movie library management.

Profile features include:

* User avatar
* User display name
* Watch List count
* History count
* Favorites count
* Edit Profile button
* Logout button
* Watch List tab
* History tab
* Favorites tab
* Language switcher
* Bottom navigation

The screen automatically detects whether a Firebase user is authenticated.

---

# Guest Profile

When the user is not authenticated, the Profile screen displays a dedicated Guest experience.

Guest Profile includes:

* Guest avatar
* Welcome message
* Explanation of account benefits
* Login button
* Create Account button
* Language switcher
* Bottom navigation

This allows users to explore the application before creating an account.

---

# Edit Profile

Users can edit their account profile through the Update Profile screen.

Editable information includes:

* Name
* Email
* Avatar

Profile update functionality includes:

* Update Firebase display name
* Request Firebase email update verification
* Update Firestore profile information
* Save avatar index
* Input validation
* Loading state
* Firebase authentication error handling
* Success feedback
* Localized messages

---

# Avatar System

The application includes a complete custom avatar selection system.

Users can select avatars from multiple character categories.

Available categories include:

```text
Marvel
Disney
Harry Potter
```

The application supports multiple avatars inside each category.

Example asset structure:

```text
assets/
└── avatars/
    ├── marvel/
    ├── disney/
    └── harry_potter/
```

Avatar selection is stored using an integer index.

Example:

```dart
'avatarIndex': selectedAvatar,
```

The stored avatar is automatically loaded when the user returns to their Profile.

---

# Home Screen

The Home screen is the primary screen after login.

It provides a cinematic movie discovery experience.

Home features include:

* Main hero movie
* Background movie image
* Center movie poster
* Side movie posters
* Available Now section
* Watch Now button
* Movie lists
* Action section
* See More navigation
* Infinite loading behavior
* Pull-to-refresh
* Movie Details navigation
* Bottom navigation
* Compact language switcher
* Localized text

---

# Hero Movie Section

The Home screen includes a large cinematic hero section.

The hero contains:

* Movie background image
* Dark cinematic gradient
* Main movie poster
* Secondary side posters
* Available Now graphic
* Watch Now graphic
* Movie Details navigation
* Language control

The layout creates a visual movie-streaming style experience.

---

# Movie Lists

Movies are displayed using horizontal scrollable lists.

Movie list features include:

* Movie posters
* Movie cards
* Horizontal scrolling
* Dynamic movie loading
* Automatic pagination
* Movie Details navigation

When the user reaches near the end of the list, additional movies are loaded automatically.

---

# Infinite Scrolling

The application supports automatic pagination.

Example logic:

```dart
if (metrics.pixels >=
    metrics.maxScrollExtent - 100) {
  context.read<HomeBloc>().add(
    LoadMoreMovies(),
  );
}
```

Pagination is implemented in:

* Home
* Search
* Browse

This provides a smooth continuous browsing experience.

---

# Pull to Refresh

The Home screen supports pull-to-refresh.

Users can refresh the current movie collection using:

```dart
RefreshIndicator
```

The refresh operation triggers:

```dart
LoadMovies()
```

---

# Search

The Search screen allows users to search the movie database dynamically.

Search features include:

* Movie title search
* Search input field
* Search icon
* Submit button
* Keyboard search action
* Loading state
* Empty search state
* Search results grid
* Infinite result pagination
* Movie rating
* Movie poster
* Movie Details navigation
* Error state
* Retry button
* Localization
* Compact language switcher

---

# Search Result Cards

Search results are displayed using a responsive two-column grid.

Each card includes:

* Movie poster
* Movie rating
* Star icon
* Network image loading
* Fallback image state
* Loading indicator
* Movie Details navigation

---

# Browse

The Browse screen allows users to discover movies based on genre.

Available genres include:

```text
Action
Adventure
Animation
Comedy
Crime
Documentary
Drama
Family
Fantasy
Horror
Mystery
Romance
Sci-Fi
Sport
Thriller
War
Western
```

The internal API genre values remain in English to maintain API compatibility.

The displayed genre names are localized dynamically.

---

# Genre Localization

Genres use English internally:

```dart
'Action'
'Comedy'
'Horror'
```

But the UI displays localized values using:

```dart
l10n.genreAction
l10n.genreComedy
l10n.genreHorror
```

This allows API logic and localization logic to remain cleanly separated.

---

# Browse Movie Grid

Browse results are displayed as a two-column responsive movie grid.

Features include:

* Genre filtering
* Selected genre styling
* Infinite pagination
* Movie poster cards
* Movie Details navigation
* Loading state
* Error state
* Retry functionality
* Localized interface

---

# Movie Details

The Movie Details feature provides extended information about each movie.

The screen is built using BLoC and reacts dynamically to movie loading states.

States include:

```text
Loading
Success
Error
```

---

# Movie Details Information

Movie Details can display:

* Movie poster
* Movie title
* Movie rating
* Release information
* Runtime information
* Summary
* Genres
* Screenshots
* Cast
* Similar movies
* Watch Movie button
* Watch Trailer button
* Favorite control
* Watch List control

---

# Movie Summary

The Details screen contains a Summary section.

When the movie API does not provide a summary, the application shows a localized fallback message.

Example:

```text
No summary available.
```

---

# Movie Genres

Movie genres are displayed inside the Movie Details interface.

Genres come from the movie API and are presented alongside the remaining movie information.

---

# Cast Section

Movie Details includes a Cast section.

Cast information can display:

* Actor name
* Character name

Localized labels include:

```text
Name
Character
```

---

# Similar Movies

The application supports related movie recommendations.

Similar movie cards can be selected to navigate directly to another Movie Details screen.

Navigation creates a new Movie Details route using the selected movie ID.

---

# Movie Trailer

The Movie Details screen supports trailer launching.

The application uses:

```text
url_launcher
```

Trailer handling includes:

* Trailer availability validation
* External trailer URL launching
* Localized error messages
* Invalid trailer handling

Localized responses include:

```text
Trailer is not available for this movie.
Could not open the trailer.
```

---

# Watch Movie

The Movie Details interface includes a Watch Movie action.

The UI is already prepared for future movie playback integration.

Current behavior displays a localized informational message indicating that movie playback will be available later.

---

# Favorite Toggle

Movie Details allows users to toggle the favorite state.

The UI changes based on:

```dart
isFavorite
```

When selected, the BLoC receives:

```dart
ToggleFavorite(
  state.movie,
)
```

The BLoC coordinates the movie state and Firestore FavoriteService.

---

# Watch List Toggle

Movie Details also supports Watch List toggling.

The UI state is controlled by:

```dart
isInWatchlist
```

The event is dispatched through:

```dart
ToggleWatchlist(
  state.movie,
)
```

The saved state persists through Firestore.

---

# BLoC State Management

The application uses:

```text
flutter_bloc
```

to separate business logic from presentation.

Primary BLoC modules include:

```text
HomeBloc
SearchBloc
BrowseBloc
MovieDetailsBloc
```

Each feature contains:

```text
Bloc
Event
State
```

This keeps UI widgets focused on rendering while BLoC classes handle application behavior.

---

# Home BLoC

HomeBloc manages:

* Initial movie loading
* Refreshing movies
* Pagination
* Loading states
* Error states
* Successful movie state

Common events include:

```text
LoadMovies
LoadMoreMovies
```

---

# Search BLoC

SearchBloc manages:

* Search queries
* Search loading
* Search results
* Search pagination
* Search errors

Common events include:

```text
SearchMovies
LoadMoreSearchMovies
```

---

# Browse BLoC

BrowseBloc manages:

* Initial browse loading
* Genre selection
* Movie filtering
* Browse pagination
* Loading states
* Error states

Common events include:

```text
LoadBrowseMovies
LoadMoreBrowseMovies
ChangeGenre
```

---

# Movie Details BLoC

MovieDetailsBloc manages:

* Movie details loading
* Movie suggestions
* Favorite state
* Watch List state
* Favorite toggling
* Watch List toggling
* Error handling

Common events include:

```text
GetMovieDetails
ToggleFavorite
ToggleWatchlist
```

---

# API Integration

The project retrieves movie data from an external movie API.

API communication is separated from UI code through dedicated data services.

The networking layer uses:

```text
Dio
HTTP
```

depending on the project service implementation.

This separation provides better maintainability and allows the API layer to evolve independently from the UI.

---

# Movie Model

Movie data is represented using a dedicated MovieModel.

Movie information can include fields such as:

```text
ID
Title
Rating
Cover Image
Large Cover Image
Medium Cover Image
Background Image
Genres
Summary
Runtime
Release information
```

The model is shared across Home, Search, Browse, Movie Details, Favorites, and Watch List features.

---

# Network Image Handling

Movie artwork is retrieved from remote URLs.

The application includes loading and error states for network images.

If a movie image cannot be loaded, a fallback container is displayed using:

```dart
Icons.movie
```

Movie images may use:

```dart
mediumCoverImage
largeCoverImage
backgroundImage
```

with fallback priority.

---

# Localization

The entire application supports multiple languages using Flutter's official localization system.

Supported languages:

```text
English
Arabic
```

Localization is generated using Flutter Gen L10n.

Main localization files:

```text
lib/l10n/app_en.arb
lib/l10n/app_ar.arb
lib/l10n/app_localizations.dart
```

Configuration:

```text
l10n.yaml
```

---

# Localization Configuration

Example:

```yaml
arb-dir: lib/l10n
template-arb-file: app_en.arb
output-localization-file: app_localizations.dart
```

Flutter localization generation is enabled through:

```yaml
flutter:
  generate: true
```

---

# Localization Delegates

The application registers Flutter localization delegates:

```dart
localizationsDelegates: const [
  AppLocalizations.delegate,
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
],
```

Supported locales:

```dart
supportedLocales: const [
  Locale('en'),
  Locale('ar'),
],
```

---

# Arabic Support

Arabic localization supports:

* Arabic UI labels
* RTL layout
* Directional widgets
* Direction-aware positioning
* Arabic navigation labels
* Arabic form labels
* Arabic error messages
* Arabic profile interface
* Arabic movie-related sections
* Arabic onboarding text

Directional Flutter widgets are used where necessary to maintain proper RTL behavior.

Examples:

```dart
AlignmentDirectional
EdgeInsetsDirectional
PositionedDirectional
```

---

# Language Switcher

The application includes a global language switching experience.

Two types of language controls are used:

```text
LanguageSwitcher
CompactLanguageSwitcher
```

The larger switcher is used in authentication and onboarding-related screens.

The compact switcher is used inside the main application.

---

# Compact Language Switcher

The compact language switcher is available across major screens:

```text
Home
Search
Browse
Profile
Movie Details
Update Profile
```

It allows users to switch instantly between:

```text
English
Arabic
```

The selected language is visually highlighted using the app's yellow accent color.

---

# Persistent Language Preference

The selected application language is stored using:

```text
shared_preferences
```

This means the selected language remains active even after closing and reopening the application.

The selected language code is saved locally.

Example values:

```text
en
ar
```

---

# Locale Controller

Language state is handled through:

```text
locale_controller.dart
```

The application uses:

```dart
ValueNotifier<Locale?>
```

for lightweight global locale updates.

Example:

```dart
final ValueNotifier<Locale?> appLocale =
    ValueNotifier<Locale?>(null);
```

---

# Loading Saved Locale

At application startup, the stored language is loaded before the app is rendered.

Example:

```dart
await loadSavedLocale();
```

This prevents the selected language from resetting every time the application starts.

---

# Changing Language

The application updates locale using:

```dart
changeAppLocale('en');
```

or:

```dart
changeAppLocale('ar');
```

The selected language is saved automatically through SharedPreferences.

---

# Localized Navigation

The application's main navigation labels are localized.

Navigation tabs include:

```text
Home
Search
Browse
Profile
```

Each label automatically updates when the language changes.

---

# Bottom Navigation

The application contains a reusable shared bottom navigation widget:

```text
AppBottomNav
```

This avoids duplicating navigation UI across multiple screens.

Main navigation indexes:

```text
0 = Home
1 = Search
2 = Browse
3 = Profile
```

The same navigation experience is shared across:

```text
HomeScreen
SearchScreen
BrowseScreen
ProfileScreen
```

---

# Navigation Architecture

The application uses a combination of:

```text
Named Routes
MaterialPageRoute
pushReplacement
pushNamedAndRemoveUntil
```

Named routes include:

```text
/onboarding
/login
/register
/forget-password
/home
```

After successful login:

```dart
Navigator.pushNamedAndRemoveUntil(
  context,
  '/home',
  (route) => false,
);
```

This ensures Home becomes the main root screen.

---

# Splash Screen

The application contains a dedicated Splash Screen.

The Splash screen is used as the application's initial screen.

It is responsible for providing the startup entry point before authentication or onboarding navigation.

---

# Onboarding

The application contains a multi-page onboarding experience.

The onboarding system introduces users to the major app capabilities.

Topics include:

```text
Finding favorite movies
Movie discovery
Creating Watch Lists
Exploring genres
Rating and reviewing movies
Starting the movie experience
```

The onboarding content is fully localized.

---

# Onboarding Localization

Onboarding titles and descriptions are stored in ARB localization files.

This means onboarding changes automatically when the application language changes.

The application dynamically builds onboarding data using:

```dart
getOnboardingData(
  AppLocalizations l10n,
)
```

---

# Authentication Localization

Authentication screens are localized.

Localized authentication content includes:

```text
Email
Password
Login
Register
Create Account
Forget Password
Confirm Password
Phone Number
Login With Google
Validation messages
Firebase error messages
```

---

# Profile Localization

Profile-related UI is localized.

Examples include:

```text
Profile
Favorites
Watch List
History
Edit Profile
Exit
Change Avatar
Save Changes
User
```

---

# Movie Localization

Movie-related sections support localization.

Examples:

```text
Summary
Genres
Screen Shots
Similar
Cast
Watch Movie
Watch Trailer
Name
Character
Retry
No Movies Found
```

---

# Empty States

The application includes dedicated empty states.

Examples:

## Watch List

```text
No Movies in Watch List
Movies you add to your watch list will appear here.
```

## Favorites

```text
No Favorite Movies
Movies you add to favorites will appear here.
```

## History

```text
No History Yet
Movies you watch will appear here.
```

## Search

```text
Search for a movie
```

---

# Error Handling

The application includes error handling across multiple layers.

Handled areas include:

* Firebase Authentication
* Firestore
* API requests
* Movie loading
* Search
* Browse
* Movie Details
* Trailer opening
* Profile updates
* Image loading

Errors are displayed through:

```text
SnackBar
Error state widgets
Fallback UI
Retry buttons
```

---

# Retry System

Home, Browse, Search, and other async areas include retry support.

Example:

```dart
ElevatedButton(
  onPressed: retryFunction,
  child: Text(
    l10n.retry,
  ),
)
```

---

# Loading States

The application provides loading feedback during asynchronous operations.

Examples include:

```text
Movie loading
Browse loading
Search loading
Movie Details loading
Profile update loading
Avatar loading
Pagination loading
```

The main loading indicator uses the project's yellow/amber color.

---

# UI Design

The application uses a modern cinematic dark theme.

Primary design characteristics:

```text
Dark background
Yellow accent color
White typography
Rounded cards
Minimal borders
Cinematic gradients
Movie poster focused UI
Responsive spacing
Reusable components
```

Main background colors include dark tones such as:

```text
#101010
#121212
#1E1E1E
```

Primary accent:

```text
#FFC107
```

---

# Material 3

The application uses Material 3:

```dart
useMaterial3: true
```

The application theme is based on a dark color scheme.

---

# Theme

Example theme configuration:

```dart
ThemeData(
  useMaterial3: true,
  fontFamily: 'Arial',
  brightness: Brightness.dark,
  scaffoldBackgroundColor:
      const Color(0xff101010),
  colorScheme:
      ColorScheme.fromSeed(
    seedColor:
        const Color(0xffffc107),
    brightness:
        Brightness.dark,
  ),
)
```

---

# Responsive Layout

The application uses responsive Flutter widgets such as:

```text
Expanded
Flexible
FittedBox
LayoutBuilder
AspectRatio
MediaQuery-compatible layouts
ListView
GridView
Stack
Positioned
```

This helps the UI adapt to different screen dimensions.

---

# Reusable Components

The project contains reusable UI components to reduce duplication.

Examples include:

```text
AppBottomNav
LanguageSwitcher
CompactLanguageSwitcher
AuthTextField
AuthPrimaryButton
AuthDivider
MovieCard
BrowseMovieCard
MovieDetailsContent
AvatarPicker
```

---

# Auth UI Components

Authentication interfaces are broken into reusable widgets.

These include:

```text
AuthTextField
AuthPrimaryButton
AuthDivider
LanguageSwitcher
```

This allows Login and Register screens to share a consistent design system.

---

# Application Architecture

The project uses a feature-oriented architecture.

A simplified structure looks like:

```text
lib/
│
├── auth/
│   ├── login_screen.dart
│   ├── login_controller.dart
│   ├── register_screen.dart
│   ├── register_controller.dart
│   ├── forget_password_screen.dart
│   ├── auth_colors.dart
│   └── widgets/
│
├── data/
│   ├── models/
│   │   └── movie_model.dart
│   │
│   └── services/
│       ├── movie_api_service.dart
│       ├── favorite_service.dart
│       └── watchlist_service.dart
│
├── features/
│   ├── home/
│   │   ├── bloc/
│   │   ├── screens/
│   │   └── widgets/
│   │
│   ├── search/
│   │   ├── bloc/
│   │   └── screens/
│   │
│   ├── browse/
│   │   ├── bloc/
│   │   ├── screens/
│   │   └── widgets/
│   │
│   └── movie_details/
│       ├── bloc/
│       ├── screens/
│       └── widgets/
│
├── l10n/
│   ├── app_en.arb
│   ├── app_ar.arb
│   ├── app_localizations.dart
│   └── locale_controller.dart
│
├── profile/
│   ├── profile_screen.dart
│   ├── update_profile_screen.dart
│   ├── avatar_picker.dart
│   ├── profile_colors.dart
│   └── tabs/
│       ├── watchlist_tab.dart
│       ├── favorites_tab.dart
│       └── history_tab.dart
│
├── widgets/
│   ├── app_bottom_nav.dart
│   └── compact_language_switcher.dart
│
├── firebase_options.dart
└── main.dart
```

---

# Assets Structure

The application uses local assets for branding, UI graphics, and avatars.

Example structure:

```text
assets/
│
├── images/
│   ├── logo.png
│   ├── logo_foreground.png
│   ├── available_now.png
│   └── watch_now.png
│
└── avatars/
    ├── marvel/
    ├── disney/
    └── harry_potter/
```

---

# App Icon

The project uses:

```text
flutter_launcher_icons
```

for generating Android and iOS launcher icons.

Configuration example:

```yaml
flutter_launcher_icons:
  android: true
  ios: true

  image_path:
    "assets/images/logo_foreground.png"

  adaptive_icon_background:
    "#0B0D0C"

  adaptive_icon_foreground:
    "assets/images/logo_foreground.png"

  min_sdk_android: 21
```

Generate launcher icons using:

```bash
dart run flutter_launcher_icons
```

---

# Main Dependencies

Main dependencies used in the project include:

```yaml
flutter_bloc
dio
http
firebase_core
firebase_auth
cloud_firestore
google_sign_in
url_launcher
shared_preferences
intl
flutter_localizations
```

Development dependencies include:

```yaml
flutter_test
flutter_lints
flutter_launcher_icons
```

---

# Technology Stack

## Frontend

```text
Flutter
Dart
Material Design 3
```

## State Management

```text
flutter_bloc
```

## Backend Services

```text
Firebase Authentication
Cloud Firestore
```

## Networking

```text
Dio
HTTP
```

## Localization

```text
Flutter Gen L10n
ARB
Intl
```

## Local Storage

```text
SharedPreferences
```

## External Links

```text
url_launcher
```

## Launcher Icon

```text
flutter_launcher_icons
```

---

# Installation

Clone the repository:

```bash
git clone <repository-url>
```

Navigate into the project:

```bash
cd movies_app
```

Install dependencies:

```bash
flutter pub get
```

Generate localization files if needed:

```bash
flutter gen-l10n
```

Generate application icons if needed:

```bash
dart run flutter_launcher_icons
```

Run the application:

```bash
flutter run
```

---

# Firebase Setup

To run the application with Firebase, create or connect a Firebase project.

Enable:

```text
Authentication
Firestore Database
```

Add an Android application using the package:

```text
com.example.movies_app
```

Download:

```text
google-services.json
```

Place it inside:

```text
android/app/google-services.json
```

The project also uses:

```text
lib/firebase_options.dart
```

generated through FlutterFire CLI.

---

# FlutterFire CLI

If Firebase needs to be configured again:

```bash
dart pub global activate flutterfire_cli
```

Then:

```bash
flutterfire configure
```

Choose the Firebase project and required platforms.

This generates:

```text
lib/firebase_options.dart
```

---

# Android Firebase Configuration

The Android application applies the Google Services plugin.

Inside:

```text
android/app/build.gradle.kts
```

the plugins section includes:

```kotlin
plugins {
    id("com.android.application")
    id("com.google.gms.google-services")
    id("dev.flutter.flutter-gradle-plugin")
}
```

Android package configuration:

```kotlin
namespace = "com.example.movies_app"
```

and:

```kotlin
applicationId = "com.example.movies_app"
```

---

# Android Internet Permission

The application requires Internet access for:

* Movie API requests
* Firebase
* Firestore
* Authentication
* Network images
* Trailer URLs

AndroidManifest contains:

```xml
<uses-permission android:name="android.permission.INTERNET" />
```

---

# Firestore Rules

During development, Firestore may temporarily use development rules.

Example unrestricted development rule:

```text
rules_version = '2';

service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if true;
    }
  }
}
```

This configuration should only be used temporarily.

For production, secure user-specific rules should be used.

Example:

```text
rules_version = '2';

service cloud.firestore {
  match /databases/{database}/documents {

    match /users/{userId} {
      allow read, write:
        if request.auth != null &&
           request.auth.uid == userId;

      match /{document=**} {
        allow read, write:
          if request.auth != null &&
             request.auth.uid == userId;
      }
    }
  }
}
```

This allows authenticated users to access only their own data.

---

# Firebase Authentication Requirement

Favorites, Watch List, profile editing, and user-specific Firestore features depend on Firebase Authentication.

User identity is retrieved using:

```dart
FirebaseAuth.instance.currentUser
```

If no user is authenticated, the application can display Guest Profile behavior instead of accessing protected user data.

---

# Firestore Streams

The application uses Firestore streams for real-time data updates.

Examples include:

```text
Favorites count
Watch List count
Favorites list
Watch List list
```

This means UI values update automatically after Firestore data changes.

---

# Profile Counts

The Profile displays statistics for:

```text
Watch List
History
Favorites
```

Watch List and Favorites counts are retrieved dynamically.

Example:

```dart
StreamBuilder<int>
```

The current History count is initially displayed as:

```text
0
```

until full history persistence is implemented.

---

# Data Persistence

The project uses two forms of persistence.

## Cloud Persistence

Firebase Firestore stores:

```text
Favorite movies
Watch List movies
User profile information
Avatar index
```

## Local Persistence

SharedPreferences stores:

```text
Selected application language
```

---

# State Separation

The project separates UI state and persistent state.

Examples:

```text
BLoC
→ screen interaction and API state

Firebase
→ cloud user data

SharedPreferences
→ lightweight local preferences
```

This keeps the application architecture modular.

---

# Loading and Async Safety

Async operations frequently check:

```dart
if (!mounted) return;
```

before interacting with the Flutter widget tree.

This prevents errors caused by accessing a disposed context after an asynchronous operation finishes.

---

# Form Controllers

Text input fields use dedicated controllers:

```dart
TextEditingController
```

Controllers are correctly disposed using:

```dart
@override
void dispose() {
  controller.dispose();
  super.dispose();
}
```

This prevents unnecessary memory usage.

---

# Profile Email Update

Firebase requires extra security when modifying account email information.

The project uses:

```dart
verifyBeforeUpdateEmail(
  email,
);
```

If Firebase requires recent authentication, the application handles:

```text
requires-recent-login
```

with a localized user-friendly message.

---

# Authentication Navigation

The authentication navigation flow is structured as:

```text
Splash
↓
Onboarding / Login
↓
Login
↓
Home
```

After successful login, Home becomes the main route.

From Home, users can navigate using the bottom navigation bar.

```text
Home
├── Search
├── Browse
└── Profile
```

---

# Main App Flow

```text
Application Start
      ↓
Splash Screen
      ↓
Authentication / Onboarding
      ↓
Login or Register
      ↓
Home Screen
      ↓
 ┌──────────────┬──────────────┬──────────────┐
 │              │              │              │
Search         Browse        Profile      Movie Details
 │              │              │              │
Movie          Genre          Watch List     Summary
Results        Filters        History        Cast
 │              │             Favorites      Similar
 └──────→ Movie Details ←──────┴──────────────┘
```

---

# Authentication Flow

```text
Login Screen
│
├── Login
│   └── Firebase Authentication
│       ├── Success → Home
│       └── Error → Localized message
│
├── Create Account
│   └── Register Screen
│
└── Forget Password
    └── Forget Password Screen
```

---

# Movie Discovery Flow

```text
Home
│
├── Main Hero Movie
│   └── Movie Details
│
├── Movie List
│   └── Movie Details
│
└── See More
    └── Browse
```

---

# Search Flow

```text
Search Input
     ↓
SearchMovies Event
     ↓
SearchBloc
     ↓
Movie API
     ↓
SearchSuccess
     ↓
Movie Grid
     ↓
Movie Details
```

---

# Browse Flow

```text
Browse Screen
     ↓
Select Genre
     ↓
ChangeGenre Event
     ↓
BrowseBloc
     ↓
Movie API
     ↓
Movie Grid
     ↓
Movie Details
```

---

# Favorite Flow

```text
Movie Details
     ↓
Favorite Button
     ↓
ToggleFavorite Event
     ↓
MovieDetailsBloc
     ↓
FavoriteService
     ↓
Cloud Firestore
     ↓
Profile Favorites
```

---

# Watch List Flow

```text
Movie Details
     ↓
Watch List Button
     ↓
ToggleWatchlist Event
     ↓
MovieDetailsBloc
     ↓
WatchlistService
     ↓
Cloud Firestore
     ↓
Profile Watch List
```

---

# Localization Flow

```text
Language Switcher
      ↓
changeAppLocale()
      ↓
SharedPreferences
      ↓
ValueNotifier<Locale?>
      ↓
MaterialApp.locale
      ↓
Entire UI Rebuilds
      ↓
English / Arabic
```

---

# Language Persistence Flow

```text
User chooses Arabic
      ↓
"ar" saved locally
      ↓
Application closes
      ↓
Application starts
      ↓
loadSavedLocale()
      ↓
Arabic automatically restored
```

---

# Profile Flow

```text
Profile
│
├── Avatar
├── Name
├── Watch List Count
├── History Count
├── Favorites Count
│
├── Edit Profile
│   ├── Change Avatar
│   ├── Change Name
│   ├── Change Email
│   └── Save
│
├── Watch List
├── History
├── Favorites
│
└── Logout
```

---

# Code Quality

The project follows several maintainability practices:

* Reusable widgets
* Feature-based folders
* Dedicated services
* Dedicated BLoCs
* Dedicated models
* Shared localization
* Shared navigation
* Centralized colors
* Null-aware API handling
* Async mounted checks
* Controller disposal
* State-specific UI
* Error handling
* Loading handling
* Cloud persistence
* Local persistence

---

# Project Goals

The application was designed with the following goals:

* Build a complete movie discovery experience
* Practice Flutter production-style architecture
* Integrate Firebase Authentication
* Integrate Cloud Firestore
* Apply BLoC architecture
* Handle REST APIs
* Implement localization
* Support RTL layouts
* Persist user preferences
* Build reusable UI components
* Handle authentication state
* Provide responsive mobile layouts
* Manage user movie collections

---

# Current Implemented Features Summary

| Feature                          | Status      |
| -------------------------------- | ----------- |
| Splash Screen                    | Implemented |
| Onboarding                       | Implemented |
| English Localization             | Implemented |
| Arabic Localization              | Implemented |
| RTL Support                      | Implemented |
| Persistent Language Selection    | Implemented |
| Language Switcher                | Implemented |
| Compact Language Switcher        | Implemented |
| Login                            | Implemented |
| Register                         | Implemented |
| Logout                           | Implemented |
| Firebase Authentication          | Implemented |
| Firebase Core                    | Implemented |
| Cloud Firestore                  | Implemented |
| Guest Profile                    | Implemented |
| Edit Profile                     | Implemented |
| Avatar Selection                 | Implemented |
| Firebase Profile Storage         | Implemented |
| Home Screen                      | Implemented |
| Search                           | Implemented |
| Browse                           | Implemented |
| Genre Filtering                  | Implemented |
| Infinite Scrolling               | Implemented |
| Pull to Refresh                  | Implemented |
| Movie Details                    | Implemented |
| Movie Summary                    | Implemented |
| Movie Genres                     | Implemented |
| Cast                             | Implemented |
| Similar Movies                   | Implemented |
| Movie Screenshots Section        | Implemented |
| Trailer Launcher                 | Implemented |
| Watch Movie UI                   | Implemented |
| Favorites                        | Implemented |
| Favorites Firestore Persistence  | Implemented |
| Favorite Count                   | Implemented |
| Watch List                       | Implemented |
| Watch List Firestore Persistence | Implemented |
| Watch List Count                 | Implemented |
| History UI                       | Implemented |
| History Persistence              | Planned     |
| Google Login UI                  | Implemented |
| Google Login Authentication      | Planned     |
| Password Reset UI                | Implemented |
| Firebase Password Reset Action   | Planned     |

---

# Future Improvements

Possible future improvements include:

* Full movie watch history persistence
* Google Sign-In authentication
* Firebase password reset email integration
* Advanced movie filters
* Movie reviews
* User ratings
* Movie recommendations based on Favorites
* Recently viewed movies
* Continue Watching
* User profile image upload
* Cloud Storage integration
* Movie notifications
* Offline caching
* Favorite synchronization improvements
* Watch List sorting
* Search history
* Custom recommendations
* Advanced account settings
* Firebase App Check
* Production-level Firestore security rules
* Unit testing
* Widget testing
* Integration testing
* CI/CD
* Release signing
* Play Store publishing
* iOS production configuration

---

# Recommended Production Firestore Rules

For production, unrestricted Firestore development rules should be replaced with user-specific authentication rules.

Example:

```text
rules_version = '2';

service cloud.firestore {
  match /databases/{database}/documents {

    match /users/{userId} {
      allow read, write:
        if request.auth != null &&
        request.auth.uid == userId;

      match /favorites/{movieId} {
        allow read, write:
          if request.auth != null &&
          request.auth.uid == userId;
      }

      match /watchlist/{movieId} {
        allow read, write:
          if request.auth != null &&
          request.auth.uid == userId;
      }

      match /history/{movieId} {
        allow read, write:
          if request.auth != null &&
          request.auth.uid == userId;
      }
    }
  }
}
```

---

# Running the Project

Install packages:

```bash
flutter pub get
```

Generate localization:

```bash
flutter gen-l10n
```

Run analysis:

```bash
flutter analyze
```

Run tests:

```bash
flutter test
```

Run development build:

```bash
flutter run
```

Build Android APK:

```bash
flutter build apk
```

Build release APK:

```bash
flutter build apk --release
```

---

# Useful Development Commands

Clean project:

```bash
flutter clean
```

Restore packages:

```bash
flutter pub get
```

Generate localization:

```bash
flutter gen-l10n
```

Generate launcher icons:

```bash
dart run flutter_launcher_icons
```

Check connected devices:

```bash
flutter devices
```

Analyze project:

```bash
flutter analyze
```

Run app:

```bash
flutter run
```

Build APK:

```bash
flutter build apk
```

---

# Troubleshooting

## Firebase Permission Denied

If Firestore returns:

```text
[cloud_firestore/permission-denied]
Missing or insufficient permissions
```

check Firestore security rules.

During development, verify that authenticated users are allowed to access the required collections.

---

## Firestore Client Offline

If Firestore reports:

```text
[cloud_firestore/unavailable]
Failed to get document because the client is offline
```

verify:

```text
Internet connection
Android INTERNET permission
Firebase configuration
Firestore Database enabled
Correct Firebase project
Correct package name
Firestore backend availability
```

---

## Images Not Loading

Check:

```text
Asset paths
pubspec.yaml
Exact file names
Folder names
Android case sensitivity
```

Then run:

```bash
flutter clean
flutter pub get
flutter run
```

---

## Avatar Assets Not Loading

Make sure avatar folders are included in:

```yaml
flutter:
  assets:
    - assets/images/
    - assets/avatars/
    - assets/avatars/marvel/
    - assets/avatars/disney/
    - assets/avatars/harry_potter/
```

---

## Localization Not Updating

Run:

```bash
flutter gen-l10n
```

Then:

```bash
flutter clean
flutter pub get
flutter run
```

Also verify that:

```dart
MaterialApp.locale
```

is connected to the app locale controller.

---

## App Icon Not Updating

Run:

```bash
flutter clean
flutter pub get
dart run flutter_launcher_icons
```

Then uninstall the existing application from the emulator or physical device and reinstall it.

Launcher icons may remain cached by Android until the application is reinstalled.

---

# Platform Support

The project is primarily developed for Flutter mobile.

The current architecture is compatible with:

```text
Android
iOS
```

Additional Flutter platforms can be supported with platform-specific Firebase and dependency configuration.

---

# Security

Sensitive Firebase access should never depend on client-side UI restrictions alone.

Production security should include:

* Firebase Authentication
* Secure Firestore rules
* Firebase App Check
* Proper API key restrictions
* Release signing
* Secure backend validation where required

Client-side checks improve user experience but should not replace backend security.

---

# Performance

The project uses several techniques to maintain smooth performance:

* Lazy movie list building
* GridView.builder
* ListView.builder / separated
* Pagination
* Reusable widgets
* BLoC state separation
* StreamBuilder for realtime counts
* Image fallbacks
* Controlled async loading
* Proper controller disposal

---

# User Experience

The application focuses heavily on a smooth movie browsing experience.

Important UX details include:

* Clear navigation
* Dark cinema-inspired interface
* Persistent selected language
* Immediate localization updates
* Guest experience
* Loading indicators
* Retry buttons
* Empty states
* Profile statistics
* Movie poster-first design
* Quick access to Favorites
* Quick access to Watch List
* Responsive controls
* Persistent cloud data

---

# Design System

## Primary Background

```text
Dark / near black
```

## Primary Accent

```text
Amber / Yellow
#FFC107
```

## Primary Text

```text
White
```

## Secondary Text

```text
White70 / White54
```

## Error Accent

```text
Red Accent
```

The visual system creates a consistent modern streaming application style.

---

# Final Project Summary

Movies App is a complete Flutter movie discovery and personal movie library application that combines REST API data with Firebase cloud functionality.

Users can:

* Register
* Login
* Logout
* Browse movies
* Search movies
* Filter movies by genre
* View detailed movie information
* Open trailers
* Discover similar movies
* View cast information
* Add movies to Favorites
* Add movies to Watch List
* Manage their profile
* Select custom avatars
* Change their name
* Update their email
* Switch between Arabic and English
* Keep their selected language after restarting the app
* Use the application with RTL support
* Access cloud-synchronized personal movie collections

The project demonstrates practical implementation of Flutter application architecture, BLoC state management, Firebase Authentication, Cloud Firestore, REST APIs, localization, local persistence, responsive UI design, and reusable component development.

It is structured to remain extensible, allowing future features such as full watch history, Google Authentication, password reset, reviews, recommendations, notifications, and advanced personalization to be added without rebuilding the entire application architecture.
