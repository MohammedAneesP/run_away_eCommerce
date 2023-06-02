import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/core/text_constants/constants.dart';
import 'package:run_away/domain/services/frbs_auth_methods.dart';
import 'package:run_away/presentation/login_sign_up_pages/forgot_passwrd.dart';

import 'sign_up_page.dart';
import 'widgets/button_widget.dart';
import 'widgets/text_form.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final forFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final kHeight = MediaQuery.of(context).size.height;
    final kWidth = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentScope = FocusScope.of(context);

        if (!currentScope.hasPrimaryFocus) {
          currentScope.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.lightBlue[50],
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: forFormKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: kHeight * 0.08,
                      ),
                      Text(
                        "Hello Again!",
                        style: loginTitle,
                      ),
                      Text("Welcome back you've been missed!",
                          style: italicText),
                      SizedBox(
                        height: kHeight * 0.12,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(
                            30,
                          ),
                        ),
                        child: TheTextFormField(
                          anController: emailController,
                          returnText: "Email required",
                          anLabelText: "Email address",
                          isObscure: false,
                          keyInputType: TextInputType.emailAddress,
                          anPrefixIcon: const Icon(
                            Icons.mail_outline_rounded,
                          ),
                          anSuffixIcon: const Icon(Icons.abc),
                        ),
                      ),
                      SizedBox(
                        height: kHeight * 0.03,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(
                            30,
                          ),
                        ),
                        child: TheTextFormField(
                          anController: passwordController,
                          returnText: "Password required",
                          anLabelText: "Password",
                          isObscure: true,
                          anPrefixIcon: const Icon(Icons.lock),
                          anSuffixIcon: const Icon(
                            CupertinoIcons.eye_slash_fill,
                          ),
                          keyInputType: TextInputType.text,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(220, 10, 0, 0),
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>  ForgotPassword(),
                            ));
                          },
                          child: const Text(
                            "Forgot Password ?",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: kHeight * 0.03,
                      ),
                      SizedBox(
                        width: kWidth * 1,
                        height: kHeight * 0.065,
                        child: AnElevatedButton(
                          forFormKey: forFormKey,
                          emailController: emailController,
                          passwordController: passwordController,
                          anOnPressed: () async {
                            if (forFormKey.currentState!.validate()) {
                              await FireBaseAuthMethods(FirebaseAuth.instance)
                                  .loginWithEmail(
                                email: emailController.text,
                                password: passwordController.text,
                                context: context,
                              );
                              emailController.clear();
                              passwordController.clear();
                            }
                          },
                        ),
                      ),
                      SizedBox(height: kHeight * 0.03),
                      GestureDetector(
                        onTap: () async {
                          await FireBaseAuthMethods(FirebaseAuth.instance)
                              .signInWithGoogle(context);
                        },
                        child: Container(
                          height: kHeight * 0.065,
                          width: kWidth * 1,
                          decoration: BoxDecoration(
                              color: kWhite,
                              borderRadius: BorderRadius.circular(30)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: kHeight * 0.065,
                                width: kWidth * 0.07,
                                decoration: const BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/google_png.png',
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: kWidth * 0.04),
                              Text(
                                "Sign in with Google",
                                style: buttonTextBlack,
                              )
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: kHeight * 0.15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an Account?"),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SignUpPage(),
                                ),
                              );
                            },
                            child: const Text("Sign up"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

