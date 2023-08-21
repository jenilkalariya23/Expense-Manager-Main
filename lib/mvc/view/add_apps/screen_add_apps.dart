import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensemanager/helper/dialog_helper.dart';
import 'package:expensemanager/mvc/model/category/category_notifier.dart';
import 'package:expensemanager/style/app_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:velocity_x/velocity_x.dart';

import '../../../helper/WidgetHelper.dart';
import '../../../helper/navigator_helper.dart';
import '../../../localization/AppLocalizations.dart';
import '../../../style/fonts.dart';
import '../../model/category/categroy_items.dart';
import '../../tiles/widget_add_apps_item.dart';

class AddAppsScreen extends StatefulWidget {
  const AddAppsScreen({Key? key}) : super(key: key);

  @override
  State<AddAppsScreen> createState() => _AddAppsScreenState();
}

class _AddAppsScreenState extends State<AddAppsScreen> {
  @override

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: AppColor.BodyColor,
      appBar: WidgetHelper.getHeader(

          context,
          buildTranslate(context, "Category"),
          showAddIcon: true,
          showSearchIcon: false,
          background: false,
          showNotificationIcon: false,
          onAddressClick: (){
            NavigatorHelper.remove();
          }
      ),
      body: Container(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('categories').where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                // .where('categoryName', isEqualTo: )
                .snapshots(),
            builder: (context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData) {
                return Center(
                    child: CircularProgressIndicator().centered());
              }
              if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text(
                    buildTranslate(context, "yetnotaddedcategory"),
                    textAlign: TextAlign.center,
                    style: Fonts.valueNotAdd,
                  ),
                );
              }
              return GridView.builder(
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                itemBuilder: (BuildContext context, int index) {
                  DocumentSnapshot events = snapshot.data.docs[index];
                  return ItemAddApps(
                    title:
                    events["categoryName"],
                    imageString: 'random_2.png',
                  );
                },
                itemCount: snapshot.data?.docs.length,
              );
            },
          )
      ),
    );
  }
}