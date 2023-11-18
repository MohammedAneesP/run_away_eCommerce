import 'package:flutter/material.dart';

import 'package:run_away/core/constants/constants.dart';
import 'package:run_away/core/text_constants/constants.dart';
import 'package:run_away/presentation/Screens/home_page/widgets/about_and_more/terms_conditions.dart';

class PrivacyAndPolicy extends StatelessWidget {
  const PrivacyAndPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: musiCityBgColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Text(privacyPolicy, style: kHeadingText),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              heightGapSizedBox(context),
              Text(privacyPolicyPara1),
              heightGapSizedBox(context),
              Text(
                privcypolcCollecUse,
                style: kHeadingMedText,
              ),
              heightGapSizedBox(context),
              Text(privacyPolicyPara2),
              heightGapSizedBox(context),
              Text(
                privcyPolcyCookies,
                style: kHeadingMedText,
              ),
              heightGapSizedBox(context),
              Text(privacyPolicyPara3),
              heightGapSizedBox(context),
              Text(
                paraContactText,
                style: kHeadingMedText,
              ),
              heightGapSizedBox(context),
              Text(paraText3),
              heightGapSizedBox(context),
              
            ],
          ),
        ),
      ),
    );
  }
}

String privcyPolcyCookies = "Cookies";
String privacyPolicy = "Privacy and Policy";
String privcypolcCollecUse = "Information collection and Use";

String privacyPolicyPara1 =
    "Mohammed Anees built the RunAway app as a Free app. This SERVICE is provided by Mohammed Anees at no cost and is intended for use as is.This page is used to inform visitors regarding my policies with the collection, use, and disclosure of Personal Information if anyone decided to use my Service.If you choose to use my Service, then you agree to the collection and use of information in relation to this policy. The Personal Information that I collect is used for providing and improving the Service. I will not use or share your information with anyone except as described in this Privacy Policy.\nThe terms used in this Privacy Policy have the same meanings as in our Terms and Conditions, which are accessible at Mohammed Anees unless otherwise defined in this Privacy Policy.";
String privacyPolicyPara2 =
    " For a better experience, while using our Service, I may require you to provide us with certain personally identifiable information, including but not limited to all man. The information that I request will be retained on your device and is not collected by me in any way.\nThe app does use third-party services that may collect information used to identify you.I have implemented an dummy Payment setup in this application for my educational purpose it doesn't require any money of your's and doesn't use any of your money as show, it just show as it is.";
String privacyPolicyPara3 =
    "Cookies are files with a small amount of data that are commonly used as anonymous unique identifiers. These are sent to your browser from the websites that you visit and are stored on your device's internal memory.\nThis Service does not use these “cookies” explicitly. However, the app may use third-party code and libraries that use “cookies” to collect information and improve their services. You have the option to either accept or refuse these cookies and know when a cookie is being sent to your device. If you choose to refuse our cookies, you may not be able to use some portions of this Service.";
