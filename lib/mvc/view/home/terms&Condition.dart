import 'package:expensemanager/helper/button_view.dart';
import 'package:expensemanager/style/app_color.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

import '../../../helper/WidgetHelper.dart';
import '../../../helper/navigator_helper.dart';
import '../../../localization/AppLocalizations.dart';


class termsCondition extends StatefulWidget {
  @override
  _termsConditionAppState createState() => _termsConditionAppState();
}

class _termsConditionAppState extends State<termsCondition> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.BodyColor,
      appBar: WidgetHelper.getHeader(
          context,
          buildTranslate(context, "termsCondition"),
          showBackIcon: true,
          showSearchIcon: false,
          showEditProfile: true,
          background: false,
          showNotificationIcon: false,
          onAddressClick: (){
            NavigatorHelper.remove();
          }
      ),
      body: Container(
        alignment: Alignment.topCenter,
        margin: EdgeInsets.only(top: 20),
        child: TextButton.icon(
          icon:  Icon(Icons.share),
          onPressed: () {
            Share.share("https://www.google.com/");
          },
          label: Text(buildTranslate(context, "shareApp")),
        ),
      ),
    );
  }

}