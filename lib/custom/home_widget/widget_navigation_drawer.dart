import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensemanager/auth/auth_controller.dart';
import 'package:expensemanager/style/app_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../helper/assets_helper.dart';
import '../../helper/navigator_helper.dart';
import '../../mvc/view/auth/changepassword.dart';
import '../../mvc/view/home/shareApp.dart';
import '../../mvc/view/home/terms&Condition.dart';
import '../../mvc/view/profile/screen_profile.dart';
import '../../style/fonts.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  String name = "";
  String email = "";
  String profileImage =
      "http://thenewcode.com/assets/images/thumbnails/sarah-parmenter.jpeg";
  void getUserData(BuildContext context) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CollectionReference users = firestore.collection('users');

    FirebaseAuth auth = FirebaseAuth.instance;

    String uid = auth.currentUser!.uid.toString();
    print("uid: $uid");
    users.doc(uid).get().then((value) {
      print("value: ${value['uid']}");
      setState(() {
        name = value['username'].toString();
        email = value['email'].toString();
        profileImage = value['profile_pic'].toString();
        print("snapshot value: $profileImage");
      });
    }).onError((error, stackTrace) {
      VxToast.show(context,
          msg: "Error: $error",
          bgColor: Colors.red.shade100,
          textColor: Colors.red.shade500,
          textSize: 14,
          position: VxToastPosition.center);
    });
  }


  _launchURLBrowser() async {
    var url = Uri.parse("https://www.geeksforgeeks.org/");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
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
    return Drawer(
      backgroundColor: AppColor.BodyColor,
      child: ListView(
        padding: const EdgeInsets.all(0.0),
        children: [
          const SizedBox(
            height: 25,
          ),
            UserAccountsDrawerHeader(
              margin:   EdgeInsets.only(left: 5),
              accountName:  Text(
                name,
              style: Fonts.navigationBarFont,
              ),
              accountEmail:  Text(
                email,
                style: Fonts.navigationBarFont,
              ),
              currentAccountPicture:CircleAvatar(
                radius: 70,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 0,
                      color: context.theme.scaffoldBackgroundColor,
                    ),
                    shape: BoxShape.circle,
                    image:  DecorationImage(
                      fit: BoxFit.cover,
                        image: AssetImage(
                          "assets/Icons/Splash_Screen/profile_Pic.png",
                        )
                    ),
                  ),
                ),
              ),
              decoration:  BoxDecoration(color: AppColor.BodyColor,),
            ),

          const Divider(
            thickness: 2,
            height: 10,
            indent: 30,
            endIndent: 30,
          ),
          const SizedBox(
            height: 1,
          ),
          getRow("Profile.png","Account", 1),
          getRow("Info.png","Help", 2),
          getRow("Share.png","Share App", 3),
          getRow("Star.png","Rate App", 4),
          getRow("Shield.png","Terms and Condition", 5),
          getRow("Setting.png","Settings", 6),
          SizedBox(
            height: 20,
          ),
          getRow("Logout.png","Log out", 7),
          // GestureDetector(
          //   onTap: () {
          //     AuthController.instance.logOut(context);
          //   },
          //   child: Container(
          //     margin: const EdgeInsets.only(left: 1, top: 50),
          //     child: ListTile(
          //         textColor: AppColor.Buttoncolor,
          //         title: "Log Out".text.lg.bold.make(),
          //         leading: Image.asset(
          //           "assets/Icons/Logout.png",
          //           height: 24,
          //           width: 24,
          //         )
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
  Widget getRow(String iconName, String label, int select){
    return Padding(
      padding: const EdgeInsets.only(left: 20, bottom: 20),
      child: GestureDetector(
        onTap: (){
          if (select==1){
            NavigatorHelper.add( ProfileScreen());
          } else if (select==2){
            NavigatorHelper.add(ChangePassword());
          }else if (select==3){
            Share.share("https://www.google.com/");
          } else if (select==4){
            NavigatorHelper.add(ChangePassword());
          }else if (select==5){
            launch('https://policies.google.com/privacy?hl=en');
          }else if (select==6){
            NavigatorHelper.add(ChangePassword());
          } else if (select==7){
            AuthController.instance.logOut(context);
          }
        },
        child: Container(
          margin: const EdgeInsets.only(top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetsHelper.getIcon(iconName),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Text(
                  label,
                  style:  Fonts.navigationBarFont
              ),
            ],
          ),
        ),
      ),
    );
  }
}
