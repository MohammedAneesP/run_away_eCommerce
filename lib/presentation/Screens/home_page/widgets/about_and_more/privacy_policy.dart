import 'package:flutter/material.dart';

import 'package:run_away/core/constants/constants.dart';
import 'package:run_away/core/text_constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyAndPolicy extends StatelessWidget {
  const PrivacyAndPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    final Uri url = Uri.parse('https://policies.google.com/privacy');
    final Uri privacyPolicyUrlLink = Uri.parse('https://sites.google.com/view/runawayshop/home');
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
              Text(privacyPolicyExp),
              heightGapSizedBox(context),
              Text(privcypolcCollecUse, style: kHeadingMedText),
              heightGapSizedBox(context),
              Text(infoAndCollecExp),
              heightGapSizedBox(context),
              Text(emailAddresses, style: kHeadingMedText),
              heightGapSizedBox(context),
              Text(emailAdressesExp),
              heightGapSizedBox(context),
              Text(addressAndContact, style: kHeadingMedText),
              heightGapSizedBox(context),
              Text(addressAndContactExp),
              heightGapSizedBox(context),
              Text(dataSecurity, style: kHeadingMedText),
              heightGapSizedBox(context),
              Text(dataSecurityExp),
              TextButton(
                  onPressed: () async {
                    if (!await launchUrl(url)) {
                      throw Exception('Could not launch $url');
                    }
                  },
                  child: Text(
                    "Firebase Privacy Policy",
                    style: kBluePlainText,
                  )),
              heightGapSizedBox(context),
              Text(thirdParty, style: kHeadingMedText),
              heightGapSizedBox(context),
              Text(thirdPartyExp),
              heightGapSizedBox(context),
              Text(accessControl, style: kHeadingMedText),
              heightGapSizedBox(context),
              Text(accessControlExp),
              heightGapSizedBox(context),
              Text(purposeOfData, style: kHeadingMedText),
              heightGapSizedBox(context),
              Text(purposeOfDataExp),
              heightGapSizedBox(context),
              Text(userRight, style: kHeadingMedText),
              heightGapSizedBox(context),
              Text(userRightExp),
              heightGapSizedBox(context),
              Text(updatesToPrivacy, style: kHeadingMedText),
              heightGapSizedBox(context),
              Text(updatesToPrivacyExp),
              heightGapSizedBox(context),
              Text(privacyPolicyUrl, style: kHeadingMedText),
              TextButton(
                  onPressed: () async {
                    if (!await launchUrl(privacyPolicyUrlLink)) {
                      throw Exception('Could not launch $privacyPolicyUrlLink');
                    }
                  },
                  child: Text(
                    "Privacy Policy URL",
                    style: kBluePlainText,
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

String privcyPolcyCookies = "Cookies";
String privacyPolicy = "Privacy and Policy";

String privacyPolicyExp =
    "ShoeWee ('us', 'we', or 'our') operates ShoeWee (the 'App'). This page informs you of our policies regarding the collection, use, and disclosure of Personal Information we receive from users of the App.";
String privcypolcCollecUse = "Information collection and Use";
String infoAndCollecExp =
    "While using our App, we may ask you to provide us with certain personally identifiable information that can be used to contact or identify you. Personally identifiable information may include, but is not limited to, your email address, physical address, and contact details.";
String emailAddresses = "Email Addresses";
String emailAdressesExp =
    "We collect email addresses through Firebase Authentication for the purpose of user authentication.";
String addressAndContact = "Addresses and Contact Details";
String addressAndContactExp =
    "We collect physical addresses and contact details for the delivery option in our App. This information is stored securely in Firebase Database.";
String dataSecurity = "Data Security";
String dataSecurityExp =
    "We are committed to ensuring that your information is secure. To prevent unauthorized access or disclosure, we have implemented suitable physical, electronic, and managerial procedures to safeguard and secure the information we collect.";
String thirdParty = "Third-Party Services";
String thirdPartyExp =
    "Our App uses Firebase for authentication and data storage. Please refer to Firebase's privacy policy for information on how they handle user data:";
String accessControl = "Access Control";
String accessControlExp =
    "Access to the collected data is restricted to authorized personnel only, and we ensure that only necessary personnel have access to this information.";
String purposeOfData = "Purpose of Data Collection";
String purposeOfDataExp =
    "Email Addresses: Collected for authentication purposes through Firebase Authentication.\nAddresses and Contact Details: Collected for order delivery purposes and stored securely in Firebase Database.";
String userRight = "User Rights";
String userRightExp =
    "You have the right to request access, correction, or deletion of your personal information. For privacy concerns, please contact us at mohammedanees454@gmail.com.";
String updatesToPrivacy = "Updates to Privacy Policy";
String updatesToPrivacyExp =
    "This Privacy Policy may be updated from time to time. We will notify you of any changes by posting the new Privacy Policy on this page.";
String privacyPolicyUrl = "Privacy Policy URL";
