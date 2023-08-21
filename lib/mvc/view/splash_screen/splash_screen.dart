import 'dart:async';
import 'package:expensemanager/helper/assets_helper.dart';
import 'package:expensemanager/mvc/view/bottom_navigation/on_boarding.dart';
import 'package:flutter/material.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    if (mounted) {
      setState(() => {
        Timer( Duration(seconds: 3),
                ()=>Navigator.pushReplacement(context,
                MaterialPageRoute(builder:
                    (context) =>
                 Onbording()
                )
            )
        ),
        super.initState(),
      });
    }
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        image: DecorationImage(image:AssetsHelper.getSplashScreen("1 Plash Screen.png"),fit: BoxFit.cover),
      ),
      child: Image(image:AssetsHelper.getIcon("Logo.png")),
    );
  }
}