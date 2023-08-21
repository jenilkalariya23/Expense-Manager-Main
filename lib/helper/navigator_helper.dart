import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import '../utils/constants.dart';

class NavigatorHelper {

  static add(Widget widget, {Function? callback}) {

    navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (context) {
            return widget;
          },
        )
    ).then((value) {
      if(callback!=null && value!=null)
        callback(value);
    });

    // navigatorKey.currentState.push(
    //     PageRouteBuilder(
    //       pageBuilder: (context, animation, secondaryAnimation) => widget,
    //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //         return child;
    //       },
    //     )
    // ).then((value) {
    //   if(callback!=null && value!=null)
    //     callback(value);
    // });
  }

  static replace(Widget widget, {Function? callback}) {

    navigatorKey.currentState!.pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return widget;
          },
        )
    ).then((value) {
      if(callback!=null && value!=null)
        callback(value);
    });

    // navigatorKey.currentState.pushReplacement(
    //     PageRouteBuilder(
    //       pageBuilder: (context, animation, secondaryAnimation) => widget,
    //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
    //         return child;
    //       },
    //     )
    // ).then((value) {
    //   if(callback!=null && value!=null)
    //     callback(value);
    // });
  }



  static addWithAnimation(Widget widget, {Function? callback}) {

    navigatorKey.currentState!.push(
      PageTransition(
          duration: Duration(milliseconds: 100),
          type: PageTransitionType.fade,
          child: widget
      ),
    ).then((value) {
      if(callback!=null && value!=null)
        callback(value);
    });
  }

  static replaceWithAnimation(Widget widget, {Function? callback}) {
    navigatorKey.currentState?.pushReplacement(
      PageTransition(
          duration: Duration(milliseconds: 2000),
          type: PageTransitionType.fade,
          child: widget
      ),
    ).then((value) {
      if(callback!=null && value!=null)
        callback(value);
    });
  }



  static remove({bool? value}) {
    navigatorKey.currentState?.pop(value??false);
  }

  static removeAllAndOpen(Widget widget) {
    navigatorKey.currentState?.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => widget),
          (Route<dynamic> route) => false,
    );
  }

  static openDialog(Widget widget, {Function? callback}) {
    navigatorKey.currentState?.push(PageRouteBuilder(
      opaque: false,
      pageBuilder: (context, animation , _) {
        return widget;
      },
    )).then((value) {
      if(callback!=null)
        callback(value);
    });
  }

  static void openBottomSheet(BuildContext context, Widget widget, {Function? callback}) {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) {
          return widget;
        });
  }

  static void openBottomSheet2(BuildContext context, Widget widget, {Function? callback}) {
    showModalBottomSheet(
        enableDrag: false,
        isScrollControlled: true,
        isDismissible: false,
        context: context,
        builder: (context) {
          return widget;
        });
  }
}