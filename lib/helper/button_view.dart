import 'package:expensemanager/style/app_color.dart';
import 'package:flutter/material.dart';

import '../style/fonts.dart';


class ButtonView extends StatelessWidget {

  const ButtonView({
    Key? key,
    this.buttonTextName,
    this.onPressed,
    this.color,
    this.textColor,
    this.borderColor,
    this.padding,
    this.textSize,
    this.radius,
  }) : super(key: key);

  final String? buttonTextName;
  final VoidCallback? onPressed;
  final Color? textColor;
  final Color? color;
  final Color? borderColor;
  final EdgeInsets? padding;
  final double? textSize;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          color: color??AppColor.Buttoncolor,
          borderRadius: BorderRadius.circular(radius??20),
          border: Border.all(color: borderColor??AppColor.appGrayTextColor, width: 0.7),
        ),
        padding: padding??const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(
          buttonTextName!,
          style: Fonts.buttonStyle.copyWith(
              color: textColor??Colors.white,
              fontSize: textSize??15
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}