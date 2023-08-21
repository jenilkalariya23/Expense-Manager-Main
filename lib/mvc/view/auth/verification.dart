import 'package:expensemanager/helper/button_view.dart';
import 'package:expensemanager/style/app_color.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_text_field.dart';
import '../../../helper/navigator_helper.dart';
import '../../../localization/AppLocalizations.dart';
import '../../../style/fonts.dart';
import 'sign_up.dart';
import 'package:otp_text_field/style.dart';

class Verification extends StatefulWidget {
  const Verification({Key? key}) : super(key: key);

  @override
  VerificationState createState() => VerificationState();
}

class VerificationState extends State<Verification> {
  final _formKey = GlobalKey<FormState>();

  var email = "";
  var password = "";
  var confirmPassword = "";
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final firstnameController = TextEditingController();
  final lastnameController = TextEditingController();
  final phoneNoController = TextEditingController();
  OtpFieldController otpController = OtpFieldController();

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
              Container(
                margin:  EdgeInsets.fromLTRB(0.0, 180.0, 3.0, 4.0),
                child: Text(
                    buildTranslate(context, "forgotPassword"),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppColor.Buttoncolor,
                        fontWeight: FontWeight.bold,
                        fontSize: 30)),
              ),
              Text(
                buildTranslate(context, "weSendYouCode"),
                textAlign: TextAlign.center,
                style: Fonts.textDescription,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(50.0, 20.0, 30.0, 5.0),
                child: Text(
                    buildTranslate(context, "enterOtp"),
                    textAlign: TextAlign.left,
                    style: TextStyle(color: AppColor.TextColor, fontSize: 15)),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(30.0, 8.0, 30.0, 5.0),
                child: OTPTextField(
                    controller: otpController,
                    length: 4,
                    width: MediaQuery.of(context).size.width,
                    textFieldAlignment: MainAxisAlignment.spaceAround,
                    fieldWidth: 45,
                    fieldStyle: FieldStyle.box,
                    outlineBorderRadius: 12,
                    style: const TextStyle(fontSize: 15),
                    onChanged: (pin) {
                      //print("Changed: " + pin);
                    },
                    onCompleted: (pin) {
                      //print("Completed: " + pin);
                    }),
              ),
              Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 100.0, vertical: 20),
                child: ButtonView(
                  buttonTextName: "Continue",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Navigator.pushAndRemoveUntil(
                      //     context,
                      //     PageRouteBuilder(
                      //       pageBuilder: (context, a, b) => const Bottombar(),
                      //       transitionDuration: const Duration(seconds: 0),
                      //     ),
                      //     (route) => false);
                    }
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    buildTranslate(context, "dntReceivecode"),
                    style: Fonts.textDescription,
                  ),
                  TextButton(
                    style:
                        TextButton.styleFrom(primary: AppColor.Buttoncolor),
                    onPressed: () => {
                    NavigatorHelper.add(Signup())
                    },
                    child:  Text(
                      buildTranslate(context, "sendAgain"),
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
