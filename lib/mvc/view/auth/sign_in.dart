import 'package:expensemanager/auth/auth_controller.dart';
import 'package:expensemanager/helper/button_view.dart';
import 'package:expensemanager/helper/assets_helper.dart';
import 'package:expensemanager/helper/social_login_button_helper.dart';
import 'package:expensemanager/style/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../helper/ValidationHelper.dart';
import '../../../helper/WidgetHelper.dart';
import '../../../helper/navigator_helper.dart';
import '../../../localization/AppLocalizations.dart';
import '../../../style/fonts.dart';
import 'forgot_password.dart';
import 'sign_up.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  SignInState createState() => SignInState();
}

class SignInState extends State<SignIn> {


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
  RegExp passValid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  bool _isObscure = true;
  FocusNode emailNode = FocusNode();


  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }


  bool validatePassword(String pass) {
    String password = pass.trim();
    if (passValid.hasMatch(password)) {
      return true;
    } else {
      return false;
    }
  }



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: ListView(
            children: [
               SizedBox(height: 40),
              Image(image: AssetsHelper.getIcon("Logo.png"), height: 100),
              Text(
                buildTranslate(context, "signIn"),
                textAlign: TextAlign.center,
                style: Fonts.textTitleTextStyle,
              ),
              Container(
                margin:  EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 5.0),
                child: Text(
                  buildTranslate(context, "iAmSoHappy"),
                  textAlign: TextAlign.center,
                  style: Fonts.textDescription,
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 5.0),
                child: TextFormField(
                  style: Fonts.fieldStyle,
                  focusNode: emailNode,
                  decoration:  InputDecoration(
                    hintText: buildTranslate(context, "email"),
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.words,
                  controller: emailController,
                  inputFormatters: [LengthLimitingTextInputFormatter(100)],
                  validator: (value) => ValidationHelper.checkEmailValidation(context, value!),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 5.0),
                child: TextFormField(
                  style: Fonts.fieldStyle,
                  decoration: InputDecoration(
                    hintText: buildTranslate(context, "password"),
                    suffixIcon: IconButton(
                        icon: Icon(_isObscure
                            ? Icons.visibility
                            : Icons.visibility_off),
                        color: Colors.black,
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        }),
                    errorStyle:
                     TextStyle(color: AppColor.appRedColor, fontSize: 15),
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  controller: passwordController,
                  obscureText: _isObscure,
                  obscuringCharacter: "*",
                  inputFormatters: [LengthLimitingTextInputFormatter(100)],
                  validator: (value) => ValidationHelper.checkPasswordValidation(context, value!, "errorMessageKey"),
                ),
              ),
              Container(
                margin:  EdgeInsets.fromLTRB(0.0, 10.0, 10, 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: (){
                        NavigatorHelper.add(ForgotPassword());
                      },
                      child: Text(
                        buildTranslate(context, "forgotPassword"),
                        style: TextStyle(
                          fontSize: 13.0,
                          color: AppColor.TextColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin:  EdgeInsets.symmetric(horizontal: 100.0),
                child: ButtonView(
                  buttonTextName: buildTranslate(context, "signIn"),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      AuthController.instance.login(
                          context,
                          emailController.text.toString(),
                          passwordController.text.toString());
                    }
                  },
                ),
              ),
              Text(
                  buildTranslate(context, "or"),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    height: 3,
                    color: AppColor.Buttoncolor,
                    fontWeight: FontWeight.bold,
                  )),
              WidgetHelper.getDividerSeparator(),
              GestureDetector(
                onTap: () {
                  // AuthController.instance.logInWithGoogle(context);
                },
                child: Container(
                  height: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 65.0),
                  child: SocialLoginButtonHelper.googleButton(context),
                ),
              ),
              WidgetHelper.getDividerSeparator(),
              GestureDetector(
                onTap: () {
                  // AuthController.instance.logInWithGoogle(context);
                },
                child: Container(
                  height: 40,
                  margin: const EdgeInsets.symmetric(horizontal: 65.0),
                  child: SocialLoginButtonHelper.appleButton(context),
                ),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    buildTranslate(context, "don'tHaveAccount"),
                    style: Fonts.textDescription,
                  ),
                  SizedBox(width: 8),
                  GestureDetector(
                    onTap: (){
                      NavigatorHelper.add(Signup());
                    },
                    child: Text(
                      buildTranslate(context, "signUp"),
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                        color: AppColor.Buttoncolor,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
