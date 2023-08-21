import 'package:expensemanager/mvc/view/add_apps/screen_add_apps.dart';
import 'package:expensemanager/mvc/view/budget/setBudget.dart';
import 'package:expensemanager/mvc/view/home/screen_home.dart';
import 'package:expensemanager/mvc/view/profile/screen_profile.dart';
import 'package:expensemanager/mvc/view/profile/update_profile.dart';
import 'package:expensemanager/style/app_color.dart';
import 'package:flutter/material.dart';

import '../../../helper/navigator_helper.dart';
import '../home/Add Expense .dart';


class BottomBar extends StatefulWidget {

   BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}
class _BottomBarState extends State<BottomBar> {
  int currentIndex = 0;
  // List? screens;
  List screens = [
    Dashboard(),
    SetBudget(),
    AddAppsScreen(),
    ProfileScreen(),
    // UpdateScreen()
  ];




  final PageStorageBucket bucket = PageStorageBucket();

  void onTap(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: bottomBar(),
      floatingActionButton: floatingButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget bottomBar() => BottomAppBar(
    shape: const CircularNotchedRectangle(),
    notchMargin: 2,
    child: SizedBox(
      height: 70,
      child: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/Icons/home.png",
                color: (currentIndex == 0)
                    ? AppColor.Buttoncolor
                    : Colors.black,
                height: 24,
                width: 24,
              ),
              label: "Home"),
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/Icons/Budget.png",
                color: (currentIndex == 1)
                    ? AppColor.Buttoncolor
                    : Colors.black,
                height: 24,
                width: 24,
              ),
              label: "Donate"),
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/Icons/Category.png",
                color: (currentIndex == 2)
                    ? AppColor.Buttoncolor
                    : Colors.black,
                height: 24,
                width: 24,
              ),
              label: "Apps Add"),
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/Icons/Profile.png",
                color: (currentIndex == 3)
                    ? AppColor.Buttoncolor
                    : Colors.black,
                height: 24,
                width: 24,
              ),
              label: "User Profile"),
        ],
        backgroundColor: Colors.transparent,
        selectedItemColor: AppColor.Buttoncolor,
        unselectedItemColor: AppColor.Black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedFontSize: 0,
        selectedFontSize: 0,
        currentIndex: currentIndex,
        onTap: onTap,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
      ),
    ),
  );

  Widget floatingButton() => Container(
    margin: const EdgeInsets.all(4),
    height: 50,
    width: 50,
    alignment: Alignment.center,
    child: FloatingActionButton(
      backgroundColor: AppColor.Buttoncolor,
      onPressed: () {
        NavigatorHelper.add(addexpense());
      },
      child:  Icon(
        Icons.add,
        size: 24,
        color: AppColor.BodyColor,
      ),

    ),
  );
}
