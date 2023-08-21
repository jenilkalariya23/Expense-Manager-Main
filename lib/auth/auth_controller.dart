// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensemanager/auth/user_data.dart';
import 'package:expensemanager/mvc/view/auth/sign_in.dart';
import 'package:expensemanager/mvc/view/bottom_navigation/bottom_navigation.dart';
import 'package:expensemanager/mvc/view/bottom_navigation/on_boarding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:velocity_x/velocity_x.dart';

import '../helper/dialog_helper.dart';
import '../helper/navigator_helper.dart';
import '../mvc/view/budget/Balance.dart';

class AuthController extends GetxController {
  static AuthController instance =
      Get.find(); // auth controller instance; will be called in other widgets
  // user instance
  late Rx<User?> _user;
  // get user data like name, email, password etc
  FirebaseAuth auth = FirebaseAuth.instance; // firebase auth instance

  String profile =
      "assets/Icons/Splash_Screen/profile_Pic.png";

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser); // getting current user
    _user.bindStream(
      auth.userChanges(),
    ); //notifies app about user login and logout

    ever(_user,
        _initialScreen); //this function will make sure user gets to correct screen
  }

  _initialScreen(User? user) {
    if (user == null) {
      Get.offAll(() =>  SignIn());
    } else {
      Get.offAll(() =>  BottomBar());
    }
  }

  Future<void> register(BuildContext context, String email, username, password,
      int phoneNumber) async {
    try {
      await auth.createUserWithEmailAndPassword(email: email, password: password);
      emailVerification(context, email);
      Future.delayed(
          const Duration(
            seconds: 1,
          ), () {
        userSetup(context, username, email, password, profile, phoneNumber);

        VxToast.show(context,
            msg: "Registration Successful",
            bgColor: Colors.green.shade100,
            textColor: Colors.green.shade500,
            textSize: 14,
            position: VxToastPosition.center);
      });
    } catch (e) {
      VxToast.show(context,
          msg: "Error: $e",
          bgColor: Colors.red.shade100,
          textColor: Colors.red.shade500,
          textSize: 14,
          position: VxToastPosition.center);
    }
  }

  Future<void> login(BuildContext context, String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      //await Future.delayed(const Duration(seconds: 2));
      Future.delayed(
          const Duration(
            seconds: 1,
          ), () {
        VxToast.show(context,
            msg: "Login Successful",
            bgColor: Colors.green.shade100,
            textColor: Colors.green.shade500,
            textSize: 14,
            position: VxToastPosition.center);
      });
    } on FirebaseAuthException catch (e) {
      VxToast.show(context,
          msg: "Error: $e",
          bgColor: Colors.red.shade100,
          textColor: Colors.red.shade500,
          textSize: 14,
          position: VxToastPosition.center);
    }
  }

  Future<void> logOut(BuildContext context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context,
          msg: "Error: $e",
          bgColor: Colors.red.shade100,
          textColor: Colors.red.shade500,
          textSize: 14,
          position: VxToastPosition.center);
    }
  }


  Future<void> emailVerification(BuildContext context, String email) async {
    try {
      await auth.currentUser?.sendEmailVerification().then((value) {
        VxToast.show(context,
            msg: "Check Your Mail For Verification Link",
            bgColor: Colors.grey.shade200,
            textColor: Colors.grey.shade500,
            textSize: 14,
            position: VxToastPosition.center);
      });
    } catch (e) {
      VxToast.show(context,
          msg: "Could Not Send Verification Email",
          bgColor: Colors.red.shade100,
          textColor: Colors.red.shade500,
          textSize: 14,
          position: VxToastPosition.center);
    }
  }

  Future<void> otpVerificationSend(BuildContext context, String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email).then((value) {
        NavigatorHelper.add(Onbording());

        VxToast.show(context,
            msg: "Password Reset Link Sent",
            bgColor: Colors.green.shade200,
            textColor: Colors.green.shade500,
            textSize: 14,
            position: VxToastPosition.center);
      });
    } catch (e) {
      VxToast.show(context,
          msg: "Error: $e",
          bgColor: Colors.red.shade100,
          textColor: Colors.red.shade500,
          textSize: 14,
          position: VxToastPosition.center);
    }
  }

  Future<void> otpVerificationReceive(
      BuildContext context, String code, newPassword) async {
    try {
      await auth
          .confirmPasswordReset(code: code, newPassword: newPassword)
          .then((value) {
        VxToast.show(context,
            msg: "Login Successful",
            bgColor: Colors.green.shade100,
            textColor: Colors.green.shade500,
            textSize: 14,
            position: VxToastPosition.center);
      });
    } catch (e) {
      VxToast.show(context,
          msg: "Error: $e",
          bgColor: Colors.red.shade100,
          textColor: Colors.red.shade500,
          textSize: 14,
          position: VxToastPosition.center);
    }
  }


  Future<void> logInWithGoogle(BuildContext context) async {
    final googleSignIn = GoogleSignIn(scopes: ['uid']);

    try {
      final googleSignInAccount = await googleSignIn.signIn();

      if (googleSignInAccount == null) {
        VxToast.show(context,
            msg: "Invalid User Account!!",
            bgColor: Colors.red.shade100,
            textColor: Colors.red.shade500,
            textSize: 14,
            position: VxToastPosition.center);
        return;
      }
      final googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);
      await FirebaseAuth.instance.signInWithCredential(credential);
      var instance = FirebaseFirestore.instance;
      bool userExist = await instance
          .collection('users')
          .where('uid', isEqualTo: googleSignInAccount.id)
          .get()
          .then((value) => value.size > 0 ? true : false);
      if (userExist == false) {
        await userSetup(
            context,
            googleSignInAccount.displayName!,
            googleSignInAccount.email,
            "",
            (googleSignInAccount.photoUrl != "")
                ? googleSignInAccount.photoUrl
                : profile,
            -1);
      }
      VxToast.show(context,
          msg: "Login Successful",
          bgColor: Colors.green.shade100,
          textColor: Colors.green.shade500,
          textSize: 14,
          position: VxToastPosition.center);
    } catch (e) {
      VxToast.show(context,
          msg: "loginWithGoogle-Error: $e",
          bgColor: Colors.red.shade100,
          textColor: Colors.red.shade500,
          textSize: 14,
          position: VxToastPosition.center);
    }
  }


  Future<bool> userExists(BuildContext context, String email) async {
    try {
      var instance = FirebaseFirestore.instance;

      return await instance
          .collection('users')
          .where('uid', isEqualTo: email)
          .get()
          .then((value) => value.size > 0 ? true : false);
    } catch (e) {
      VxToast.show(context,
          msg: "loginWithGoogle-Error: $e",
          bgColor: Colors.red.shade100,
          textColor: Colors.red.shade500,
          textSize: 14,
          position: VxToastPosition.center);
      return false;
    }
  }
}
