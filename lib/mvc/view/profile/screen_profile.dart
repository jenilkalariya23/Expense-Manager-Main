import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensemanager/mvc/tiles/widget_profile_list_tile.dart';
import 'package:expensemanager/mvc/view/profile/update_profile.dart';
import 'package:expensemanager/style/app_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../helper/WidgetHelper.dart';
import '../../../helper/assets_helper.dart';
import '../../../helper/navigator_helper.dart';
import '../../../localization/AppLocalizations.dart';
import '../../../style/fonts.dart';
import '../../tiles/profile_screen_design_tiles.dart';
import '../auth/changepassword.dart';
import 'AccountInformation.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key,}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String userData = "";
  String userMail = "";
  String userProfile = "";

  void getUserData(BuildContext context) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CollectionReference users = firestore.collection('users');

    FirebaseAuth auth = FirebaseAuth.instance;

    String uid = auth.currentUser!.uid.toString();
    print("uid: $uid");
    users.doc(uid).get().then((value) {
      print("value: ${value['uid']}");
      setState(() {
        userData = value['username'].toString();
        userMail = value['email'].toString();
      });
    }).onError((error, stackTrace) {
      userData = "Something went wrong... $error";
    });
  }

  @override
  void initState() {
    setState(() {
      getUserData(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetHelper.getHeader(
          context,
          buildTranslate(context, "profile"),
          showSearchIcon: false,
          showEditIcon: true,
          showNotificationIcon: false,
          onAddressClick: (){
            NavigatorHelper.remove();
          }
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Container(
            //   height: MediaQuery.of(context).size.height * .3,
            //   child: Stack(
            //     children: [
            //       Padding(
            //         padding: const EdgeInsets.only(bottom: 50.0),
            //         child: Container(
            //           height: MediaQuery.of(context).size.height,
            //           decoration: BoxDecoration(
            //             color: AppColor.Buttoncolor,
            //             borderRadius: BorderRadius.only(
            //               bottomLeft: Radius.elliptical(
            //                   MediaQuery.of(context).size.width * 0.2, 100.0),
            //               bottomRight: Radius.elliptical(
            //                   MediaQuery.of(context).size.width * 0.2, 100.0),
            //             ),
            //           ),
            //         ),
            //       ),
            //       Align(
            //         alignment: Alignment.bottomCenter,
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //           children: [
            //             CircleAvatar(
            //               child: Container(
            //                 decoration: BoxDecoration(
            //                   border: Border.all(
            //                     width: 0,
            //                     color: context.theme.scaffoldBackgroundColor,
            //                   ),
            //                   shape: BoxShape.circle,
            //                   image: DecorationImage(
            //                     fit: BoxFit.cover,
            //                     image: NetworkImage(userProfile),
            //                   ),
            //                 ),
            //               ),
            //               radius: 70,
            //             ),
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            designTileProfileWidget(),
            SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 12, bottom: 10),
                    child: Column(
                      children: [
                        userData.text.size(20).normal.bold.center.make(),
                        WidgetHelper.getDividerSeparator(),
                        userMail.text.center.normal.bold.center.make(),
                      ],
                    )
                  ),
                  WidgetHelper.getFieldSeparator(),
                  getRow("user-add.png",buildTranslate(context, "inviteFriends"), 1),
                  getRow("information.png",buildTranslate(context, "accountInfo"), 3),
                  getRow("key.png",buildTranslate(context, "changePassword"), 4),
                  getRow("lock.png",buildTranslate(context, "dataAndPrivacy"), 5),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  Widget getRow(String iconName, String label, int select){
    return Padding(
      padding: const EdgeInsets.only(left: 80, bottom: 10),
      child: GestureDetector(
        onTap: (){
          if (select==1){
            Share.share("https://www.google.com/");
          }else if (select==3){
            NavigatorHelper.add(AccountInformation());
          }else if (select==4){
            NavigatorHelper.add(ChangePassword());
          }else if (select==5){
            NavigatorHelper.add(ChangePassword());
          }
        },
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetsHelper.getIcon(iconName),
                  ),
                ),
              ),
              SizedBox(width: 20),
              Text(
                  label,
                style: Fonts.budgetexpenseTitle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

