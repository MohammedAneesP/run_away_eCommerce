// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:run_away/core/constants/constants.dart';
import 'package:run_away/core/text_constants/constants.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text(
          termsConditions,
          style: kHeadingText,
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    heightGapSizedBox(context),
                    Text(paraText1),
                    heightGapSizedBox(context),
                    Text(paraChangeText),
                    heightGapSizedBox(context),
                    Text(paraText2),
                    heightGapSizedBox(context),
                    Text(paraContactText),
                    heightGapSizedBox(context),
                    Text(paraText3),
                    heightGapSizedBox(context)
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

String termsConditions = "Term's & Condition's";
String paraText1 =
    "You should be aware that there are certain things that ShoeWei will not take responsibility for. Certain functions of the app will require the app to have an active internet connection. The connection can be Wi-Fi or provided by your mobile network provider, but Mohammed Anees cannot take responsibility for the app not working at full functionality if you dont have access to Wi-Fi, and you dont have any of your data allowance left.\n\nIf you’re using the app outside of an area with Wi-Fi, you should remember that the terms of the agreement with your mobile network provider will still apply. As a result, you may be charged by your mobile provider for the cost of data for the duration of the connection while accessing the app, or other third-party charges. In using the app, you’re accepting responsibility for any such charges, including roaming data charges if you use the app outside of your home territory (i.e. region or country) without turning off data roaming. If you are not the bill payer for the device on which you’re using the app, please be aware that we assume that you have received permission from the bill payer for using the app.\n\nAlong the same lines, Mohammed Anees cannot always take responsibility for the way you use the app i.e. You need to make sure that your device stays charged – if it runs out of battery and you can’t turn it on to avail the Service, Anees cannot accept responsibility.\nWith respect to his responsibility for your use of the app, when you’re using the app, it’s important to bear in mind that although we endeavor to ensure that it is updated and correct at all times, we do rely on third parties to provide information to us so that we can make it available to you.Mohammed Anees accepts no liability for any loss, direct or indirect, you experience as a result of relying wholly on this functionality of the app.At some point, we may wish to update the app. The app is currently available on Android – the requirements for the system(and for any additional systems we decide to extend the availability of the app to) may change, and you’ll need to download the updates if you want to keep using the app.Mohammed Anees does not promise that it will always update the app so that it is relevant to you and/or works with the Android version that you have installed on your device. However, you promise to always accept updates to the application when offered to you, We may also wish to stop providing the app, and may terminate use of it at any time without giving notice of termination to you. Unless we tell you otherwise, upon any termination, (a) the rights and licenses granted to you in these terms will end; (b) you must stop using the app, and (if needed) delete it from your device.";
String paraText2 =
    "I may update our Terms and Conditions from time to time. Thus, you are advised to review this page periodically for any changes. I will notify you of any changes by posting the new Terms and Conditions on this page.These terms and conditions are effective as of 2023-1-20";
String paraText3 =
    "If you have any questions or suggestions about my Terms and Conditions, do not hesitate to contact me at mohammedanees454@gmail.com.\nThis Terms and Conditions page was generated by App Privacy Policy Generator";
String paraChangeText = "Changes to this Term's and Conditions";
String paraContactText = "Contact us :";
