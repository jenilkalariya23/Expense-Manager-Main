import 'package:expensemanager/mvc/view/budget/setBudget.dart';
import 'package:flutter/material.dart';

import '../../../helper/button_view.dart';
import '../../../helper/navigator_helper.dart';
import '../../../localization/AppLocalizations.dart';
import '../../../style/app_color.dart';
import '../bottom_navigation/bottom_navigation.dart';

class Balance extends StatefulWidget {
  const Balance({Key? key}) : super(key: key);

  @override
  State<Balance> createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:  <Widget>[
                        SizedBox(height: 120.0),
                        Center(
                          child: Image(
                            image: AssetImage(
                              'assets/Icons/Splash_Screen/Piggy_bank_perspective_matte.png',
                            ),
                          ),
                        ),
                        SizedBox(height: 50.0),
                        Text(
                          buildTranslate(context, "welcomeMessage"),
                          style: TextStyle(
                            color: AppColor.Black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
            // Container(
            //   child: ButtonView(
            //     buttonTextName: "Set Budget",
            //     onPressed: () {
            //       Navigator.pop(context);
            //       }
            //   ),
            // ),
            Container(
              margin: new EdgeInsets.symmetric(horizontal: 100.0),
              child: ButtonView(
                buttonTextName: "Set Budget",
                onPressed: (){
                  NavigatorHelper.add(SetBudget());
                },
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  style: TextButton.styleFrom(primary: Colors.indigo),
                  onPressed: () => {
                    NavigatorHelper.add(BottomBar())
                  },
                  child:   Text(
                      buildTranslate(context, "skip"),
                      style: TextStyle(
                        color: Colors.indigo,
                        fontSize: 15.0,
                        fontWeight: FontWeight.w400,
                      )
                  ),
                ),
              ],
            )
                ],
            ),
        ),
    );
  }
}
