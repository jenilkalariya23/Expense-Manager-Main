import 'package:expensemanager/auth/auth_controller.dart';
import 'package:expensemanager/helper/button_view.dart';
import 'package:expensemanager/helper/assets_helper.dart';
import 'package:expensemanager/style/app_color.dart';
import 'package:flutter/material.dart';
import '../../../helper/ValidationHelper.dart';
import '../../../helper/WidgetHelper.dart';
import '../../../helper/navigator_helper.dart';
import '../../../localization/AppLocalizations.dart';
import '../../../style/fonts.dart';
import 'sign_in.dart';
import 'package:flutter/services.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  SignupState createState() => SignupState();
}

class SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  var email = "";
  var password = "";
  var confirmPassword = "";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  FocusNode emailNode = FocusNode();
  FocusNode nameNode = FocusNode();
  FocusNode mobileNumberNode = FocusNode();
  FocusNode addressLineOneNode = FocusNode();
  FocusNode addressLineTwoNode = FocusNode();
  FocusNode pinCodeNode = FocusNode();
  final phoneNoController = TextEditingController();
  RegExp passValid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");

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

  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: ListView(
            children: [
              WidgetHelper.getLogoSeparator(),
              Image(
                image: AssetsHelper.getIcon("Logo.png"),
                height: 100,
              ),
              Text(
                buildTranslate(context, "signUp"),
                textAlign: TextAlign.center,
                style: Fonts.textTitleTextStyle,
              ),
              WidgetHelper.getFieldSeparator(),
              Container(
                margin: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: Text(
                  buildTranslate(context, "signUpMessage"),
                  textAlign: TextAlign.center,
                  style: Fonts.textDescription,
                ),
              ),
              WidgetHelper.getFieldSeparator(),
              Container(
                margin: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                child: TextFormField(
                  style: Fonts.fieldStyle,
                  focusNode: nameNode,
                  decoration:  InputDecoration(
                    hintText: buildTranslate(context, "name"),
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  controller: firstnameController,
                  inputFormatters: [LengthLimitingTextInputFormatter(100)],
                  validator: (value) => ValidationHelper.checkBlankValidation(context, value!, "nameValidation"),
                ),
              ),
              Container(
                margin:  EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 5.0),
                child: TextFormField(
                  style: Fonts.fieldStyle,
                  focusNode: mobileNumberNode,
                  decoration:  InputDecoration(
                    hintText: buildTranslate(context, "phoneNo"),
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  textCapitalization: TextCapitalization.words,
                  controller: phoneNoController,
                  inputFormatters: [LengthLimitingTextInputFormatter(14)],
                  validator: (value) => ValidationHelper.checkMobileNoValidation(context, value!),
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
                  textInputAction: TextInputAction.next,
                  controller: passwordController,
                  obscureText: _isObscure,
                  obscuringCharacter: "*",
                  decoration: InputDecoration(
                    hintText: buildTranslate(context, "password"),
                    suffixIcon: IconButton(
                        icon: Icon(_isObscure
                            ? Icons.visibility
                            : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        }),
                    errorStyle:
                     TextStyle(color: AppColor.appRedColor, fontSize: 15),
                  ),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Required";
                    } else {
                      bool result = validatePassword(val);
                      if (result) {
                        return null;
                      } else {
                        return " Password should contain Capital, small letter & Number & Special";
                      }
                    }
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10.0, 8.0, 10.0, 5.0),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: confirmPasswordController,
                  obscureText: true,
                  obscuringCharacter: "*",
                  decoration:  InputDecoration(
                    hintText: buildTranslate(context, "confirmPassword"),
                    errorStyle:
                    TextStyle(color: AppColor.appRedColor, fontSize: 15),
                  ),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return "Required";
                    }
                    if (val != passwordController.value.text) {
                      return "Password do no match!";
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin:
                 EdgeInsets.symmetric(horizontal: 100.0, vertical: 20),
                child: ButtonView(
                  buttonTextName: buildTranslate(context, "signUp"),
                  onPressed: () => {
                  if (_formKey.currentState!.validate()) {
                    AuthController.instance.register(
                        context,
                        emailController.text.toString(),
                        firstnameController.text.toString(),
                        passwordController.text.toString(),
                        int.parse(phoneNoController.text)),
              }
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    buildTranslate(context, "alreadyHaveAccount"),
                    style: Fonts.textDescription,
                  ),
                  WidgetHelper.getDividerSeparator(),
                  GestureDetector(
                    onTap: (){
                      NavigatorHelper.add(SignIn());
                    },
                    child: Text(
                      buildTranslate(context, "signIn"),
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
