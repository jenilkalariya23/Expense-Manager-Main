import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensemanager/mvc/view/bottom_navigation/bottom_navigation.dart';
import 'package:expensemanager/style/app_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../helper/WidgetHelper.dart';
import '../../../helper/button_view.dart';
import '../../../helper/navigator_helper.dart';
import '../../../localization/AppLocalizations.dart';
import '../../../style/fonts.dart';
import '../../tiles/profile_screen_design_tiles.dart';

class AccountInformation extends StatefulWidget {
  const AccountInformation({Key? key}) : super(key: key);

  @override
  State<AccountInformation> createState() => _AccountInformationState();
}

class _AccountInformationState extends State<AccountInformation> {
  final _formKey = GlobalKey<FormState>();

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final mailController = TextEditingController();
  String profilePic = "";

  void getUserData(BuildContext context) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CollectionReference users = firestore.collection('users');

    FirebaseAuth auth = FirebaseAuth.instance;
String temp="";
    String uid = auth.currentUser!.uid.toString();
    print("uid: $uid");
    users.doc(uid).get().then((value) {
      print("value: ${value['username']}");
      setState(() {
        temp = value['username'].toString();
        mailController.text = value['email'].toString();
        phoneController.text = value['phone'].toString();
        lastNameController.text = value['userLast'].toString();
      });
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

  Future<void> setUserData(BuildContext context) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CollectionReference users = firestore.collection('users');

    FirebaseAuth auth = FirebaseAuth.instance;

    String uid = auth.currentUser!.uid.toString();
    print("uid: $uid");
    users.doc(uid).update({
      'username': firstNameController.text.toString(),
      'email': mailController.text.toString(),
      'phone': phoneController.text.toString(),
      'userLast': lastNameController.text.toString(),
    }).then((value) {
      //print("success");
      VxToast.show(context,
          msg: "Update Successful",
          bgColor: Colors.green.shade100,
          textColor: Colors.green.shade500,
          textSize: 14,
          position: VxToastPosition.center);
      //print("$userFirstName \n $userLastName \n $userMail \n $userPhone");
    }).catchError((error) {
      //print("error");
      VxToast.show(context,
          msg: "Error: $error",
          bgColor: Colors.red.shade100,
          textColor: Colors.red.shade500,
          textSize: 14,
          position: VxToastPosition.center);
    });
    return;
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
    double h = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: WidgetHelper.getHeader(
            context,
            buildTranslate(context, "accountInfo"),
            showBackIcon: true,
            showSearchIcon: false,
            showEditProfile: true,
            background: true,
            showEditIcon: true,
            showNotificationIcon: false,
            onAddressClick: (){
              NavigatorHelper.remove();
            }
        ),
        body: Form(
          key: _formKey,
          child: ListView(
            children: [
              designTileProfileWidget(),

              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users').where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    // .where('Date',isEqualTo :selectedDate)
                    // .where('Date',isLessThan:'2022-08-01')
                    .snapshots(),
                // stream: fetchData(abc,def),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CupertinoActivityIndicator(),
                      // .centered()
                      // .expand()
                    );
                  }

                  else {
                      // return hello(holder);


                    return Column(
                      children:
                      snapshot.data!.docs.map((user)
                      {
                        return Padding(
                          // padding: const EdgeInsets.only(left: 50,bottom: 8, top: 8,right: 25),
                          padding: const EdgeInsets.only(left: 35,right: 35,top: 10,bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 20),

                              Text(
                                buildTranslate(context, "name"),
                                style: Fonts.bodyText,
                              ),
                              SizedBox(height: 10),
                              Text(
                                user['username'],
                                style: Fonts.Textform,
                              ),
                              WidgetHelper.getFieldSeparator(),
                              Divider(
                                thickness: 1,
                                height: 5,
                                indent: 1,
                                endIndent: 1,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              WidgetHelper.getFieldSeparator(),

                              Text(
                                buildTranslate(context, "email"),
                                style: Fonts.bodyText,
                              ),
                              SizedBox(height: 10),
                              Text(
                                user['email'],
                                style: Fonts.Textform,
                              ),
                              WidgetHelper.getFieldSeparator(),
                              Divider(
                                thickness: 1,
                                height: 5,
                                indent: 1,
                                endIndent: 1,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              WidgetHelper.getFieldSeparator(),
                              Text(
                                buildTranslate(context, "phoneNo"),
                                style: Fonts.bodyText,
                              ),
                              SizedBox(height: 10),

                              Text(
                                user['phone'].toString(),
                                style: Fonts.Textform,
                              ),
                              WidgetHelper.getFieldSeparator(),
                              Divider(
                                thickness: 1,
                                height: 5,
                                indent: 1,
                                endIndent: 1,
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              WidgetHelper.getFieldSeparator(),
                            ],
                          ),
                        );
                      }).toList(),
                    );
                  }
                },
              ),
              // Container(
              //     alignment: Alignment.center,
              //     child: ElevatedButton(
              //       onPressed: () => {
              //       if (_formKey.currentState!.validate()) {
              //         setUserData(context)
              //       }
              //         // Navigator.pushAndRemoveUntil(
              //         //     context,
              //         //     PageRouteBuilder(
              //         //       pageBuilder: (context, a, b) => const BottomBar(),
              //         //     ),
              //         //         (route) => false)
              //
              //       },
              //       // color: Colors.indigo,
              //       // shape: RoundedRectangleBorder(
              //       //     borderRadius: BorderRadius.circular(20)),
              //       child: const Text(
              //         "Update",
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontSize: 18.0,
              //           fontWeight: FontWeight.w600,
              //         ),
              //       ),
              //     )),
            ],
          ),
        ),
      ),
    );
  }
}
