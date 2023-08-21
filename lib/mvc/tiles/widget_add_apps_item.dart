// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:expensemanager/helper/dialog_helper.dart';
import 'package:flutter/material.dart';

import '../../helper/WidgetHelper.dart';
import '../../helper/assets_helper.dart';
import '../../style/fonts.dart';

// ignore: must_be_immutable
class ItemAddApps extends StatelessWidget {
  final String title;
  final String imageString;

  ItemAddApps({
    Key? key,
    required this.title,
    required this.imageString,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    // print(imageString);
    return Center(
      child: Container(
        width: 100,
        height: 100,
        margin: const EdgeInsets.only(left: 5, right: 5, bottom: 10, top: 10),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey.shade300),
          borderRadius: const BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: Column(
          children: [
            WidgetHelper.getFieldSeparator(),
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetsHelper.getOnboarding1(imageString),
                ),
              ),
            ),
            WidgetHelper.getDividerSeparator(),
            Expanded(
              child: Text(
                title,
                style: Fonts.categoryFont,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
