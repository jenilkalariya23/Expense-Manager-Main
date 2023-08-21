// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ListTileProfileWidget extends StatelessWidget {
  final String title;
  final String imageAsset;
  //final VoidCallback onPreseed;

  const ListTileProfileWidget({
    Key? key,
    required this.title,
    required this.imageAsset,
    //required this.onPreseed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //onTap: onPressed,
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(top: 10),
        alignment: Alignment.center,
        child: Center(
          child: Row(
            children: [
              Container(
                margin: const EdgeInsets.only(
                    left: 50, right: 35, top: 10, bottom: 10),
                child: Image.asset(imageAsset),
              ),
              title.text.xl.center.extraBold.make(),
            ],
          ),
        ),
      ),
    );
  }
}
