import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:run_away/core/constants/constants.dart';
import 'package:run_away/presentation/home_page/home_page.dart';
import 'package:run_away/presentation/login_sign_up_pages/login_page.dart';

class FireBaseAuthMethods {
  final FirebaseAuth fireAuth;
  FireBaseAuthMethods(this.fireAuth);

  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await fireAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await sendEmailVerification(context);
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      snackBar(context, e.message.toString());
    }
  }

  Future<void> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await fireAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (!fireAuth.currentUser!.emailVerified) {
        await fireAuth.currentUser?.sendEmailVerification();
      }
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      snackBar(context, e.message.toString());
    }
  }

  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        UserCredential userCredential =
            await fireAuth.signInWithCredential(credential);
      }
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
    } on FirebaseAuthException catch (e) {
      snackBar(context, e.message.toString());
    }
  }

  Future<void> sendEmailVerification(BuildContext context) async {
    try {
      fireAuth.currentUser!.sendEmailVerification();
      snackBar(context, "Email verification Sent");
    } on FirebaseAuthException catch (e) {
      snackBar(context, e.message.toString());
    }
  }

  Future<void> checkLogedIn(BuildContext context) async {
    User? user = fireAuth.currentUser;
    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    }
  }

  Future<void> signOut(BuildContext context) async {
    try {
      await fireAuth.signOut();
    } on FirebaseAuthException catch (e) {
      snackBar(context, e.message.toString());
    }
  }

  Future<void> forgotPassword(
      {required String anEmail, required BuildContext context}) async {
    try {
      await fireAuth.sendPasswordResetEmail(email: anEmail);
    } on FirebaseAuthException catch (e) {
      snackBar(context, e.message.toString());
    }
  }
}
