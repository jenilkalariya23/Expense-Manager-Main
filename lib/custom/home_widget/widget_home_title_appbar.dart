// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeAppBarTitleWidget extends StatefulWidget {
  const HomeAppBarTitleWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeAppBarTitleWidget> createState() => _HomeAppBarTitleWidgetState();
}

class _HomeAppBarTitleWidgetState extends State<HomeAppBarTitleWidget> {
  final yearItems = [

    '2022',
  ];
  String value = "";

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
        elevation: 0,
        icon: const Icon(Icons.keyboard_arrow_down_outlined),
        value: value,
        items: yearItems.map(buildMenuItem).toList(),
        onChanged: (value) {
          setState(() {
            this.value = value!;
          });
        });
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        child: item.text.black.bold.xl2.make(),
      );
}
