// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../helper/assets_helper.dart';
import '../../style/fonts.dart';

class HomeTileItemWidget extends StatelessWidget {
   String? Category;
   String Date;
   String image;
   int cost;

   HomeTileItemWidget({
    Key? key,
    required this.cost,
    required this.Date,
    required this.image,
    required this.Category

  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    //double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    // print(Category);
    return GestureDetector(
      onTap: () {
        //add on click gestures here
      },
      child: Container(
        height: 60,
        margin: EdgeInsets.only(
            left: w * 0.0464 - 5, right: w * 0.0464 - 5, top: 10, bottom: 4),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(33),
          ),
          color: Colors.grey.shade100,
        ),
        child: Row(
          children: [
            Container(
              height: 57,
              width: 57,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.cover,
                    image: AssetsHelper.getOnboarding1(image),
                ),
              ),
            ),
            Container(
              width: w / 3,
              height: 60,
              margin:  EdgeInsets.only(left: 6),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 0, right: 2, top: 10),
                      child: Text(
                        Category!,
                        style: Fonts.expenseTitle,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 0, right: 0, top: 5),
                      child: Text(
                        Date,
                        style: Fonts.expenseTitle,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 50),
              child: Text(
                "\$$cost",
                style: Fonts.expenseTitle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
