import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:run_away/core/constants/constants.dart';

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
        await sendEmailVerification(context);
        
      }
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
}
