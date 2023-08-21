
import 'package:expensemanager/style/app_color.dart';
import 'package:flutter/material.dart';

class DividerView extends StatelessWidget {

  const DividerView({
    Key? key,
    this.color,
    this.width,
    this.height,
  }) : super(key: key);

  final Color? color;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? 1,
      color: color ?? AppColor.appDividerColor,
    );
  }
}