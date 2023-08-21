// import 'package:expense_manager/Balance.dart';
import 'package:expensemanager/helper/button_view.dart';
import 'package:expensemanager/helper/assets_helper.dart';
import 'package:expensemanager/mvc/view/auth/sign_up.dart';
import 'package:expensemanager/style/app_color.dart';
import 'package:flutter/material.dart';

import '../../../helper/navigator_helper.dart';
import '../../../localization/AppLocalizations.dart';
import '../../../style/fonts.dart';



class Onbording extends StatefulWidget {
  const Onbording({Key? key}) : super(key: key);

  @override
  State<Onbording> createState() => _OnbordingState();
}

class _OnbordingState extends State<Onbording> {
  final int _numPages = 3;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  bool lastPage = false;

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 3.0),
      height: 8.0,
      width: isActive ? 15.0 : 7.0,
      decoration: BoxDecoration(
        color: isActive ? AppColor.Buttoncolor : AppColor.Buttoncolor,
        borderRadius: const BorderRadius.all(Radius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                height: 0.8*h,
                //color: Colors.amber,
                child: PageView(
                  physics:  NeverScrollableScrollPhysics(),
                  controller: _pageController,
                 onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height:0.0658*h),
                          Image(image:AssetsHelper.getOnboarding1("Group 90.png")),
                          SizedBox(height: 0.06*h),
                          Text(
                            buildTranslate(context, "getYourMoneyUnderControl"),
                            textAlign: TextAlign.center,
                            style: Fonts.onBoarding,
                          ),
                           SizedBox(height: 20.0),
                          Text(
                            buildTranslate(context, "createAccount"),
                            textAlign: TextAlign.center,
                            style: Fonts.textDescription,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height:0.0658*h),
                          Image(image:AssetsHelper.getOnboarding2("Group 159.png")),
                          SizedBox(height: 0.06*h),
                          Text(
                            buildTranslate(context, "recordTransaction"),
                            style: Fonts.onBoarding,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 20.0),
                          Text(
                            buildTranslate(context, "recordBudget"),
                            textAlign: TextAlign.center,
                            style: Fonts.textDescription,
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(40.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height:0.0658*h),
                          Image(image:AssetsHelper.getOnboarding3("Group 453.png")),
                           SizedBox(height: 100.0),
                          Text(
                            buildTranslate(context, "customizeBudget"),
                            style: Fonts.onBoarding,
                            textAlign: TextAlign.center,
                          ),
                           SizedBox(height: 20.0),
                          Text(
                            buildTranslate(context, "setYourBudget"),
                            style: Fonts.textDescription,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildPageIndicator(),
              ),
              Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    TextButton(
                      child:
                      Text(
                        buildTranslate(context, "skip"),
                          style: Fonts.bottomText,
                      ),
                      onPressed: () => {
                        NavigatorHelper.add(Signup())
                      },
                    ),
                    _currentPage != _numPages - 1
                        ? Expanded(
                      child:    Container(
                       margin: const EdgeInsets.fromLTRB(200.0, 8.0, 10.0, 0.0),
                      // margin: new EdgeInsets.symmetric(horizontal: 110.5,vertical: 20),
                        child: ButtonView(
                          buttonTextName:
                          buildTranslate(context, "next"),
                         onPressed: () {
                          _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                           curve: Curves.ease,
                          );
                        },
                        ),
                      ),
                    )
                        : const Text(''),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1 ?
        Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.fromLTRB(200.0, 8.0, 10.0, 10.0),
            height: 100,
            child: ButtonView(


              buttonTextName: buildTranslate(context, "getStarted"),
              onPressed: () => {
                NavigatorHelper.add(Signup())
              },
            )
        )
          : const Text(''),
    );
  }
}