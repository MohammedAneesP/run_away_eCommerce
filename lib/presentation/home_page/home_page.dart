import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:run_away/domain/services/frbs_auth_methods.dart';
import 'package:run_away/presentation/login_sign_up_pages/login_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final userName = FireBaseAuthMethods(FirebaseAuth.instance);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: IconButton(
              onPressed: () async {
                await FireBaseAuthMethods(FirebaseAuth.instance)
                    .signOut(context);
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
              icon: const Icon(Icons.logout)),
        ),
      ),
    );
  }
}
