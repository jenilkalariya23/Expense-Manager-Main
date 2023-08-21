import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensemanager/mvc/view/bottom_navigation/bottom_navigation.dart';
import 'package:expensemanager/style/app_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../helper/ValidationHelper.dart';
import '../../../helper/WidgetHelper.dart';
import '../../../helper/button_view.dart';
import '../../../helper/navigator_helper.dart';
import '../../../localization/AppLocalizations.dart';
import '../../../style/fonts.dart';
import '../../tiles/profile_screen_design_tiles.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({Key? key}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
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

    String uid = auth.currentUser!.uid.toString();
    print("uid: $uid");
    users.doc(uid).get().then((value) {
      print("value: ${value['username']}");
      setState(() {
        firstNameController.text = value['username'].toString();
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
      VxToast.show(context,
          msg: "Update Successful",
          bgColor: Colors.green.shade100,
          textColor: Colors.green.shade500,
          textSize: 14,
          position: VxToastPosition.center);
      //print("$userFirstName \n $userLastName \n $userMail \n $userPhone");
    }).catchError((error) {
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
        backgroundColor: AppColor.BodyColor,
        appBar: WidgetHelper.getHeader(
            context,
            buildTranslate(context, "editProfile"),
            showBackIcon: true,
            showSearchIcon: false,
            showEditProfile: true,
            background: true,
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
              Container(
                margin: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 5.0),
                child: TextFormField(
                  style: Fonts.fieldStyle,
                  decoration:  InputDecoration(
                    hintText: buildTranslate(context, "firstName"),
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  controller: firstNameController,
                  inputFormatters: [LengthLimitingTextInputFormatter(100)],
                  validator: (value) => ValidationHelper.checkBlankValidation(context, value!, "nameValidation"),
                ),
              ),
              // Container(
              //   margin: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 5.0),
              //   child: TextFormField(
              //     textInputAction: TextInputAction.next,
              //     autofocus: false,
              //     controller: firstNameController,
              //     //key: Key(userFirstName.toString()),
              //     //initialValue: userFirstName.toString(),
              //     textCapitalization: TextCapitalization.sentences,
              //     decoration:  InputDecoration(
              //       hintText: buildTranslate(context, "firstName"),
              //       errorStyle:
              //       TextStyle(color: AppColor.appRedColor, fontSize: 15),
              //     ),
              //     validator: (value) {
              //       if (value == null || value.isEmpty) {
              //         return 'Required';
              //       }
              //       return null;
              //     },
              //   ),
              // ),
              Container(
                margin: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 5.0),
                child: TextFormField(
                  style: Fonts.fieldStyle,
                  decoration:  InputDecoration(
                    hintText: buildTranslate(context, "lastName"),
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  controller: lastNameController,
                  inputFormatters: [LengthLimitingTextInputFormatter(100)],
                  validator: (value) => ValidationHelper.checkBlankValidation(context, value!, "nameValidation"),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 5.0),
                child: TextFormField(
                  style: Fonts.fieldStyle,
                  decoration:  InputDecoration(
                    hintText: buildTranslate(context, "phoneNo"),
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  textCapitalization: TextCapitalization.words,
                  controller: phoneController,
                  inputFormatters: [LengthLimitingTextInputFormatter(14)],
                  validator: (value) => ValidationHelper.checkMobileNoValidation(context, value!),
                ),
              ),
              // Container(
              //   margin: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 5.0),
              //   child: TextFormField(
              //     textInputAction: TextInputAction.next,
              //     keyboardType: TextInputType.number,
              //     inputFormatters: [
              //       FilteringTextInputFormatter.allow(
              //         RegExp(r'^\d+\.?\d*'),
              //       )
              //     ],
              //     autofocus: false,
              //     controller: phoneController,
              //     decoration:  InputDecoration(
              //       hintText: buildTranslate(context, "phoneNo"),
              //       counterText: "",
              //       errorStyle:
              //       TextStyle(color: AppColor.appRedColor, fontSize: 15),
              //     ),
              //     maxLength: 10,
              //     validator: (value) {
              //       if (value == null || value.isEmpty) {
              //         return 'Required';
              //       } else if (value.length < 10) {
              //         return 'Please Enter Valid Number';
              //       }
              //       return null;
              //     },
              //   ),
              // ),
              Container(
                margin:  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 5.0),
                child: TextFormField(
                  style: Fonts.fieldStyle,
                  controller: mailController,
                  decoration:  InputDecoration(
                    hintText: buildTranslate(context, "email"),
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.words,
                  inputFormatters: [LengthLimitingTextInputFormatter(100)],
                  validator: (value) => ValidationHelper.checkEmailValidation(context, value!),
                ),
              ),
              // Container(
              //   margin:  EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 5.0),
              //   child: TextFormField(
              //     textInputAction: TextInputAction.done,
              //     autofocus: false,
              //     controller: mailController,
              //     keyboardType: TextInputType.emailAddress,
              //     //key: Key(userMail.toString()),
              //     //initialValue: userMail.toString(),
              //     textCapitalization: TextCapitalization.sentences,
              //     decoration:  InputDecoration(
              //
              //       hintText: buildTranslate(context, "email"),
              //       errorStyle:
              //       TextStyle(color: AppColor.appRedColor, fontSize: 15),
              //     ),
              //     validator: (value) {
              //       if (value == null || value.isEmpty) {
              //         return 'Required';
              //       }
              //       return null;
              //     },
              //   ),
              // ),
               SizedBox(height: 30.0),
              Container(
                margin: new EdgeInsets.symmetric(horizontal: 120.0),
                child: ButtonView(
                  buttonTextName: buildTranslate(context, "update"),
                  onPressed: (){
                    if (_formKey.currentState!.validate()) {
                      setUserData(context);
                      NavigatorHelper.remove();
                    }
                  },
                ),
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
