import 'package:expensemanager/helper/button_view.dart';
import 'package:expensemanager/helper/navigator_helper.dart';
import 'package:expensemanager/mvc/view/auth/sign_in.dart';
import 'package:expensemanager/style/app_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../helper/WidgetHelper.dart';
import '../../../localization/AppLocalizations.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();

  var newPassword = "";

  final newPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {

    newPasswordController.dispose();
    super.dispose();
  }

  final currentUser = FirebaseAuth.instance.currentUser;
  changePassword()  {
    try {
      currentUser!.updatePassword(newPassword);
      print(currentUser);
      FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SignIn()),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColor.Buttoncolor,
          content: Text(
            buildTranslate(context, "yourPasswordhasbeenChanged"),
            style: TextStyle(fontSize: 18.0,color: AppColor.BodyColor,),
          ),
        ),
      );
    } catch (e) {}
  }

  RegExp pass_valid = RegExp(r"(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*\W)");
  bool validatePassword(String pass) {
    String _password = pass.trim();
    if(pass_valid.hasMatch(_password)){
      return true;
    }else{
      return false;
    }
  }
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.BodyColor,
      appBar: WidgetHelper.getHeader(
          context,
          "Change Password",
          showSearchIcon: false,
          showBackIcon: true,
          background: false,
          showNotificationIcon: false,
          onAddressClick: (){
            NavigatorHelper.remove();
          }
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: [
              WidgetHelper.getFieldSeparator(),
              Container(
                margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: newPasswordController,
                  obscureText: _isObscure,
                  decoration: InputDecoration(
                    hintText: buildTranslate(context, "password"),
                    suffixIcon: IconButton(
                        icon: Icon(
                            _isObscure ? Icons.visibility : Icons.visibility_off),
                        onPressed: () {
                          setState(() {
                            _isObscure = !_isObscure;
                          });
                        }),
                    errorStyle:
                    TextStyle(color: AppColor.appRedColor, fontSize: 15),
                  ),
                  validator:(val){
                    if(val == null || val.isEmpty){
                      return "Required";
                    }else{
                      bool result = validatePassword(val);
                      if(result){
                        return null;
                      }else{
                        return " Password should contain Capital, small letter & Number & Special";
                      }
                    }
                  },
                ),
              ),
              WidgetHelper.getFieldSeparator(),
              Container(
                margin: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
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
                    if (val != newPasswordController.value.text) {
                      return "Password do no match!";
                    }
                    return null;
                  },
                ),
              ),
              WidgetHelper.getLogoSeparator(),
              Container(
                margin:
                EdgeInsets.symmetric(horizontal: 60.0),
                child: ButtonView(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        newPassword = newPasswordController.text;
                      });
                      changePassword();
                      // NavigatorHelper.add(SignIn());
                    }
                  },
                  buttonTextName: buildTranslate(context, "changePassword"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}