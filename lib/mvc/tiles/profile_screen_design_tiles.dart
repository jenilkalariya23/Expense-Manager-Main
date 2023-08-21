// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../style/app_color.dart';

class designTileProfileWidget extends StatelessWidget {

   designTileProfileWidget({
    Key? key,
  }) : super(key: key);


  String profilePic = "";

   getUserData(BuildContext context)  {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CollectionReference users = firestore.collection('users');

    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    print("uid: $uid");
    users.doc(uid).get().then((value) {
        profilePic = value['profile_pic'].toString();
        print(profilePic);
    }).onError((error, stackTrace) {
      VxToast.show(context,
          msg: "Error ggg : $error",
          bgColor: Colors.red.shade100,
          textColor: Colors.red.shade500,
          textSize: 14,
          position: VxToastPosition.center
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //onTap: onPressed,
      child: Container(
        height: MediaQuery.of(context).size.height * .34,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: BoxDecoration(
                  color: AppColor.Buttoncolor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.elliptical(
                        MediaQuery.of(context).size.width * 0.2, 100.0),
                    bottomRight: Radius.elliptical(
                        MediaQuery.of(context).size.width * 0.2, 100.0),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CircleAvatar(
                    child: Container(
                      decoration: BoxDecoration(
                        // border: Border.all(
                        //   width: 0,
                        //   color: context.theme.scaffoldBackgroundColor,
                        // ),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            "assets/Icons/Splash_Screen/profile_Pic.png",
                          )
                          // image: AssetImage(
                          //   imageAsset,
                          // ),
                        ),
                      ),
                    ),
                    radius: 70,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
