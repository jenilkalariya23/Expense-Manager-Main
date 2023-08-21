
import 'package:expensemanager/auth/auth_controller.dart';
import 'package:expensemanager/helper/button_view.dart';
import 'package:expensemanager/mvc/view/auth/sign_in.dart';
import 'package:expensemanager/mvc/view/auth/verification.dart';
import 'package:expensemanager/style/app_color.dart';
import 'package:flutter/material.dart';

import '../../../helper/WidgetHelper.dart';
import '../../../helper/navigator_helper.dart';
import '../../../localization/AppLocalizations.dart';
import '../../../style/fonts.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  ForgotPasswordState createState() => ForgotPasswordState();
}

class ForgotPasswordState extends State<ForgotPassword> {
  final _formKey = GlobalKey<FormState>();

  var email = "";
  var password = "";
  var confirmPassword = "";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final phoneNoController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }


  RegExp passValid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  bool validatePassword(String pass) {
    String password = pass.trim();
    if(passValid.hasMatch(password)){
      return true;
    }else{
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: ()=> FocusScope.of(context).unfocus(),
    child: Scaffold(
      appBar: WidgetHelper.getHeader(
          context,
          "",
          showSearchIcon: false,
          showBackIcon: true,
          background: false,
          showNotificationIcon: false,
          onAddressClick: (){
            NavigatorHelper.remove();
          }
      ),
      backgroundColor: AppColor.BodyColor,
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Container(
              margin: const EdgeInsets. fromLTRB(0.0, 180.0, 3.0, 4.0),
              child:   Text(
                  buildTranslate(context, "forgotPassword"),
                  textAlign: TextAlign.center,
                style: Fonts.textTitleTextStyle,
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(30.0, 8.0, 30.0, 5.0),
              child:   Text(
                buildTranslate(context, "forgotPasswordDesc"),
                  textAlign: TextAlign.center,
                style: Fonts.textDescription,
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(30.0, 8.0, 30.0, 5.0),
              child: TextFormField(
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.emailAddress,
                autofocus: false,
                decoration:  InputDecoration(
                  hintText: buildTranslate(context, "email"),
                  errorStyle:
                  TextStyle(color: AppColor.appRedColor, fontSize: 15),
                ),
                controller: emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  } else if (!value.contains('@')) {
                    return 'Please Enter Valid Email';
                  }
                  return null;
                },
              ),
            ),

            Container(
              margin: const EdgeInsets.symmetric(horizontal: 100.0,vertical: 20),
              child: ButtonView(
                buttonTextName: buildTranslate(context, "Continue"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    AuthController.instance.otpVerificationSend(context, emailController.text.toString());
                  }
                },
              ),
            ),

          ],
        ),
      ),
    ),
    );
  }
}