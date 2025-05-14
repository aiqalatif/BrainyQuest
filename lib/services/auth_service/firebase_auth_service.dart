import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application/utils/custom_toast_message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  static Future<User?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found for that email.';
          break;
        case 'wrong-password':
          errorMessage = 'Wrong password provided.';
          break;
        default:
          errorMessage = 'An error occurred. Please try again.';
      }
      CustomToast.showToast("Error", errorMessage);

      throw FirebaseAuthException(
        code: e.code,
        message: errorMessage,
      );
    }
  }

  static Future<void> sendPasswordResetEmail({
    required String email,
  }) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found for that email.';
          break;
        default:
          errorMessage = 'An error occurred. Please try again.';
      }
      CustomToast.showToast("Error", errorMessage);

      throw FirebaseAuthException(
        code: e.code,
        message: errorMessage,
      );
    }
  }

  static Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      // Get the currently signed-in user
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        CustomToast.showToast("no-current-user", "No user is currently signed in.");

        throw FirebaseAuthException(
          code: 'no-current-user',
          message: 'No user is currently signed in.',
        );
      }

      // Re-authenticate the user with the old password
      AuthCredential credential = EmailAuthProvider.credential(
        email: user.email!,
        password: oldPassword,
      );

      UserCredential userCredential = await user.reauthenticateWithCredential(credential);

      // Update the password to the new one
      await userCredential.user?.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'wrong-password':
          errorMessage = 'Old password is incorrect.';
          break;
        case 'weak-password':
          errorMessage = 'The new password is too weak.';
          break;
        case 'no-current-user':
          errorMessage = 'No user is currently signed in.';
          break;
        default:
          errorMessage = 'An error occurred. Please try again.';
      }
      CustomToast.showToast("Error", errorMessage);

      throw FirebaseAuthException(
        code: e.code,
        message: errorMessage,
      );
    }
  }

  static Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      // User cancelled the sign-in
      return null;
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
