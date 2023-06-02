import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/core/text_constants/constants.dart';
import 'package:run_away/domain/services/frbs_auth_methods.dart';
import 'package:run_away/presentation/login_sign_up_pages/login_page.dart';
import 'package:run_away/presentation/login_sign_up_pages/widgets/button_widget.dart';
import 'package:run_away/presentation/login_sign_up_pages/widgets/text_form.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  final formKey = GlobalKey<FormState>();

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
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: kHeight * 0.08,
                      ),
                      Text(
                        "Create Account",
                        style: loginTitle,
                      ),
                      Text("Let's create Account together", style: italicText),
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
                          anController: userNameController,
                          returnText: "name required",
                          anLabelText: "Your Name",
                          isObscure: false,
                          anPrefixIcon: const Icon(Icons.abc_rounded),
                          keyInputType: TextInputType.text,
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
                          anController: emailController,
                          returnText: "Email required",
                          anLabelText: "Email address",
                          isObscure: false,
                          anPrefixIcon: const Icon(Icons.mail_outline_rounded),
                          keyInputType: TextInputType.emailAddress,
                        ),
                      ),
                      SizedBox(
                        height: kHeight * 0.03,
                      ),
                      Column(
                        children: [
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
                              isObscure: false,
                              anPrefixIcon:const Icon(Icons.lock_outline_rounded),
                              keyInputType: TextInputType.text,
                            ),
                          ),
                          SizedBox(
                            height: kHeight * 0.03,
                          ),
                          SizedBox(
                            width: kWidth * 1,
                            height: kHeight * 0.065,
                            child: AnElevatedButton(
                              forFormKey: formKey,
                              emailController: emailController,
                              passwordController: passwordController,
                              anOnPressed: () async {
                                if (formKey.currentState!.validate()) {
                                  await FireBaseAuthMethods(
                                          FirebaseAuth.instance)
                                      .signUpWithEmail(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    context: context,
                                  );
                                }
                              },
                            ),
                          ),
                          SizedBox(
                            height: kHeight * 0.2,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                             const Text("Already have an account?"),
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                      builder: (context) => LoginPage(),
                                    ),
                                  );
                                },
                                child:const Text(
                                  "Login",
                                ),
                              ),
                            ],
                          )
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
