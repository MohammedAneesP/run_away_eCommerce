import 'package:flutter/material.dart';
import 'package:run_away/core/text_constants/constants.dart';
import 'package:run_away/presentation/Screens/home_page/widgets/about_and_more/privacy_policy.dart';
import 'package:run_away/presentation/Screens/home_page/widgets/about_and_more/terms_conditions.dart';

class MoreOPtionScreen extends StatelessWidget {
  MoreOPtionScreen({super.key});
  bool musicNotify = true;

  @override
  Widget build(BuildContext context) {
    final mqheight = MediaQuery.of(context).size.height;
    final mqwidth = MediaQuery.of(context).size.width;

    return Scaffold(
      //  backgroundColor: musiCityBgColor,
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding:
                    EdgeInsets.fromLTRB(mqwidth * .008, mqheight * .045, 0, 0),
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 20,
                    //  color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.fromLTRB(mqwidth * .1, mqheight * .045, 0, 0),
                child: Text(
                  "More Options",
                  style: kHeadingText,
                ),
              )
            ],
          ),
          SizedBox(
            height: mqheight * .03,
          ),
          SizedBox(
            height: mqheight * .5,
            child: Column(
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TermsAndConditions(),
                        ));
                  },
                  child: ListTile(
                    title: Text(
                      listOfOptiions[0],
                    ),
                    trailing: listOfOptionsIcons[1],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PrivacyAndPolicy(),
                        ));
                  },
                  child: ListTile(
                    title: Text(
                      listOfOptiions[1],
                    ),
                    trailing: listOfOptionsIcons[1],
                  ),
                ),
                InkWell(
                  onTap: () {
                    aboutPopUp(context);
                  },
                  child: ListTile(
                    title: Text(
                      listOfOptiions[2],
                    ),
                    trailing: listOfOptionsIcons[1],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: mqheight * 0.3,
          ),
          const Text("Version"),
          SizedBox(
            height: mqheight * 0.005,
          ),
          const Text(
            "1.0.0",
            style: TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }

  aboutPopUp(context) {
    showAboutDialog(
      context: context,
      applicationName: 'RunAway',
      applicationIcon: Image.asset(
        'assets/sneakers.png',
        height: 40,
        width: 40,
      ),
      applicationVersion: "1.0.0",
      children: [
        const Text(
            "RanAway is an app with every options as an basic shopping or e-commerce application which are cart,buying,favourites,orders and a dummy payment setup which is no money can be deducted."),
        const Text('''App developed by :

Mohammed Anees''')
      ],
    );
  }
}

List listOfOptiions = [
  "Terms and Conditions",
  "Privacy and Policy",
  "About",
];

List listOfOptionsIcons = [
  GestureDetector(
    onTap: () {},
    child: const Icon(
      Icons.chevron_right_rounded,
      // color: Colors.white,
    ),
  ),
  GestureDetector(
    onTap: () {},
    child: const Icon(
      Icons.chevron_right_rounded,
      // color: Colors.white,
    ),
  ),
  IconButton(
    onPressed: () {},
    icon: const Icon(
      Icons.toggle_off_outlined,
      // color: Colors.white,
    ),
  ),
  IconButton(
    onPressed: () {},
    icon: const Icon(
      Icons.toggle_off_outlined,
      // color: Colors.white,
    ),
  ),
  GestureDetector(
    onTap: () {},
    child: const Icon(
      Icons.chevron_right_rounded,
      // color: Colors.white,
    ),
  ),
];
