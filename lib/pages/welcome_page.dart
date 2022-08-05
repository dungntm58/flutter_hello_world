import 'package:flutter/material.dart';
import 'package:flutter_hello_world/misc/colors.dart';
import 'package:flutter_hello_world/widgets/app_large_text.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hello_world/widgets/app_text.dart';
import 'package:flutter_hello_world/widgets/responsive_button.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WelcomeState();
}

class _WelcomeState extends State<WelcomePage> {
  List imageNames = [
    "welcome-one",
    "welcome-two",
    "welcome-three",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        itemCount: imageNames.length,
        scrollDirection: Axis.vertical,
        itemBuilder: buildPageViewItem,
      ),
    );
  }

  Widget buildPageViewItem(BuildContext context, int index) {
    AssetImage assetImage = AssetImage(getAssetNamePath(imageNames[index]));
    final localizations = AppLocalizations.of(context)!;

    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      decoration: BoxDecoration(
        image: DecorationImage(image: assetImage, fit: BoxFit.cover),
      ),
      child: Container(
        margin: EdgeInsets.only(top: 150, left: 20, right: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppLargeText(text: localizations.welcome_title),
                AppText(text: localizations.welcome_subtitle, size: 30),
                SizedBox(height: 20),
                Container(
                  width: 250,
                  child: AppText(
                    text: getLocalizationDesc(localizations, index),
                    color: AppColors.textColor2,
                    size: 14,
                  ),
                ),
                SizedBox(height: 40),
                ResponsiveButton(
                  width: 120,
                )
              ],
            ),
            Column(children: List.generate(3, (i) => generateDots(i, index))),
          ],
        ),
      ),
    );
  }

  String getAssetNamePath(String name) {
    return "img/$name.png";
  }

  String getLocalizationDesc(AppLocalizations localizations, int index) {
    switch (index) {
      case 0:
        return localizations.welcome_one_desc;
      case 1:
        return localizations.welcome_two_desc;
      case 2:
        return localizations.welcome_three_desc;
      default:
        return "";
    }
  }

  Widget generateDots(int index, int pageIndex) {
    final isCurrent = index == pageIndex;
    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      width: 8,
      height: isCurrent ? 25 : 8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: isCurrent
            ? AppColors.mainColor
            : AppColors.mainColor.withOpacity(0.3),
      ),
    );
  }
}
