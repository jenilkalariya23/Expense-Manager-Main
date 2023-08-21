
import 'package:expensemanager/helper/divider_view.dart';
import 'package:expensemanager/style/app_color.dart';
import 'package:flutter/material.dart';

import '../localization/AppLocalizations.dart';
import '../style/fonts.dart';
import 'assets_helper.dart';

class SocialLoginButtonHelper {
  static Color googleButtonText = const Color(0xff7f7f7f);
  static Color facebookButtonColor = const Color(0xff4267b2);
  static Color twitterButtonColor = const Color(0xff63a9eb);

  static Color insta1 = const Color(0xff721FE9);
  static Color insta2 = const Color(0xffE65E61);

  static Widget appleButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        color: AppColor.Black,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  const SizedBox(
                    width: 10,
                  ),
                  Image(
                    image: AssetsHelper.getIcon("Apple.png"),
                    height: 15,
                    width: 15,
                    color: AppColor.BodyColor,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    buildTranslate(context, "continueWithApple"),
                    style:
                        Fonts.socialButtonStyle.copyWith(color: AppColor.BodyColor),
                  ),
                ],
              )),
        ],
      ),
    );
  }

  static Widget googleButton(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColor.appColor, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 10,
          ),
          Image(
            image: AssetsHelper.getIcon("Google-Icon.png"),
            height: 15,
            width: 15,
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            buildTranslate(context, "continueWithGoogle"),
            style: Fonts.socialButtonStyle.copyWith( color: AppColor.Black,),
          ),
        ],
      ),
    );
  }

  static Widget facebookButton(BuildContext context, {String? text}) {
    return Container(
      height: 40,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: AppColor.appDividerColor, width: 1),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Image(
                    image: AssetsHelper.getIcon("ic_facebook.png"),
                    height: 25,
                    width: 25,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  DividerView(
                    width: 1,
                    height: 25,
                    color: AppColor.appDividerColor,
                  ),
                ],
              )),
          Align(
            alignment: Alignment.center,
            child: Text(
              text ?? buildTranslate(context, "signInWithFacebook")!,
              style: Fonts.buttonStyle.copyWith( color: AppColor.Black,),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  static Widget twitterButton(
    BuildContext context,
  ) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: twitterButtonColor),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Image(
              image: AssetsHelper.getIcon("ic_twitter.png"),
              height: 30,
              width: 30,
              color: AppColor.BodyColor,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              buildTranslate(context, "signInWithTwitter")!,
              style: Fonts.buttonStyle.copyWith(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  static Widget instagramButton(
    BuildContext context,
  ) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [insta1, insta2],
          )),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Image(
              image: AssetsHelper.getIcon("ic_instagram.png"),
              height: 30,
              width: 30,
              color: AppColor.BodyColor,
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              buildTranslate(context, "signInWithInstagram")!,
              style: Fonts.buttonStyle.copyWith(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
