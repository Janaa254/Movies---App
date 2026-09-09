import 'package:firebase_auth/firebase_auth.dart';

class LoginController {
  final FirebaseAuth _auth;

  LoginController({
    FirebaseAuth? auth,
  }) : _auth = auth ?? FirebaseAuth.instance;

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    if (email.isEmpty || password.isEmpty) {
      return 'Please fill in all fields.';
    }

    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No account found with this email.';
      }

      if (e.code == 'wrong-password' ||
          e.code == 'invalid-credential') {
        return 'Incorrect email or password.';
      }

      if (e.code == 'invalid-email') {
        return 'Please enter a valid email.';
      }

      return 'Something went wrong.';
    } catch (_) {
      return 'Something went wrong.';
    }
  }
}