import 'package:firebase_auth/firebase_auth.dart';

import '../l10n/app_localizations.dart';

class LoginController {
  final FirebaseAuth _auth;

  LoginController({
    FirebaseAuth? auth,
  }) : _auth = auth ?? FirebaseAuth.instance;

  Future<String?> login({
    required String email,
    required String password,
    required AppLocalizations l10n,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      return l10n.fillAllFields;
    }

    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return l10n.noAccountFound;
      }

      if (e.code == 'wrong-password' ||
          e.code == 'invalid-credential') {
        return l10n.incorrectEmailOrPassword;
      }

      if (e.code == 'invalid-email') {
        return l10n.enterValidEmail;
      }

      return l10n.somethingWentWrong;
    } catch (_) {
      return l10n.somethingWentWrong;
    }
  }
}