import 'package:firebase_auth/firebase_auth.dart';

import '../l10n/app_localizations.dart';

class RegisterController {
  final FirebaseAuth _auth;

  RegisterController({
    FirebaseAuth? auth,
  }) : _auth = auth ?? FirebaseAuth.instance;

  Future<String?> register({
    required String name,
    required String email,
    required String password,
    required String confirmPassword,
    required String phone,
    required AppLocalizations l10n,
  }) async {
    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        phone.isEmpty) {
      return l10n.fillAllFields;
    }

    if (password != confirmPassword) {
      return l10n.passwordsDoNotMatch;
    }

    if (password.length < 6) {
      return l10n.passwordMinLength;
    }

    try {
      final credential =
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await credential.user?.updateDisplayName(name);

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return l10n.emailAlreadyInUse;
      }

      if (e.code == 'invalid-email') {
        return l10n.enterValidEmail;
      }

      if (e.code == 'weak-password') {
        return l10n.weakPassword;
      }

      return l10n.somethingWentWrong;
    } catch (_) {
      return l10n.somethingWentWrong;
    }
  }
}