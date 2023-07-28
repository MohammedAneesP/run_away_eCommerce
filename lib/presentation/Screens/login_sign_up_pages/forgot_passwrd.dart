import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:run_away/core/color_constants/colors.dart';
import 'package:run_away/core/constants/constants.dart';
import 'package:run_away/core/text_constants/constants.dart';
import 'package:run_away/domain/services/frbs_auth_methods.dart';
import 'package:run_away/presentation/Screens/login_sign_up_pages/login_page.dart';
import 'package:run_away/presentation/Screens/login_sign_up_pages/widgets/text_form.dart';

class ForgotPassword extends StatelessWidget {
  ForgotPassword({super.key});
  TextEditingController forgotController = TextEditingController();
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
       // backgroundColor: Colors.lightBlue[50],
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: kHeight * 0.08,
                    ),
                    Text(
                      "Recover Password",
                      style: loginTitle,
                    ),
                    Text("Please Enter your Email address to",
                        style: italicText),
                    Text(
                      "Recieve a verification Code",
                      style: italicText,
                    ),
                    SizedBox(
                      height: kHeight * 0.12,
                    ),
                    Form(
                      key: formKey,
                      child: Container(
                        decoration: BoxDecoration(
                          color: kWhite,
                          borderRadius: BorderRadius.circular(
                            30,
                          ),
                        ),
                        child: TheTextFormField(
                          anController: forgotController,
                          returnText: "email address required",
                          anLabelText: "Email Address",
                          isObscure: false,
                          anPrefixIcon: const Icon(Icons.mail_outline_rounded),
                          keyInputType: TextInputType.emailAddress,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: kHeight * 0.03,
                    ),
                    SizedBox(
                      width: kWidth * 1,
                      height: kHeight * 0.065,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await FireBaseAuthMethods(FirebaseAuth.instance)
                                .forgotPassword(
                                    anEmail: forgotController.text,
                                    context: context);
                            snackBar(context, "Reset email sent");
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => LoginPage(),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent),
                        child: Text(
                          "Continue",
                          style: buttontextWhite,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
