import 'package:firebase_auth/firebase_auth.dart';

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
  }) async {
    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        phone.isEmpty) {
      return 'Please fill in all fields.';
    }

    if (password != confirmPassword) {
      return 'Passwords do not match.';
    }

    if (password.length < 6) {
      return 'Password must be at least 6 characters.';
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
        return 'This email is already in use.';
      }

      if (e.code == 'invalid-email') {
        return 'Please enter a valid email.';
      }

      if (e.code == 'weak-password') {
        return 'The password is too weak.';
      }

      return 'Something went wrong.';
    } catch (_) {
      return 'Something went wrong.';
    }
  }
}