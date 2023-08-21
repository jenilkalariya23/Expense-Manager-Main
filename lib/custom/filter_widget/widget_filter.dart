// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:expensemanager/style/app_color.dart';
// import 'package:flutter/material.dart';
// import 'package:velocity_x/velocity_x.dart';
//
// class FilterTileWidget extends StatefulWidget {
//    String title;
//    Color color;
//    Color backgroundColor;
//    final double marginLeft;
//    final double marginRight;
//    final double? h;
//    final double? w;
//    Function Callback;
//
//   FilterTileWidget({
//     Key? key,
//      required this.title,
//     this.color = Colors.black,
//     this.backgroundColor = Colors.white,
//      required this.marginLeft,
//      required this.marginRight,
//      required this.Callback,
//      this.h,
//      this.w,
//   }) : super(key: key);
//
//   @override
//   State<FilterTileWidget> createState() => _FilterTileWidgetState();
// }
//
// class _FilterTileWidgetState extends State<FilterTileWidget> {
//
//
//   @override
//   Widget build(BuildContext context) {
//     //double w = MediaQuery.of(context).size.width;
//     return Center(
//
//       child: GestureDetector(
//
//         onTap: () {
//           setState(() {
//             //print(w);
//             if ((widget.color == Colors.white) &&
//                 (widget.backgroundColor == AppColor.Buttoncolor)) {
//                  widget.color = Colors.black;
//                  widget.backgroundColor = Colors.white;
//
//             } else {
//               widget.color = Colors.white;
//               widget.backgroundColor = AppColor.Buttoncolor;
//               widget.title;
//               print(widget.title);
//             }
//           });
//
//         },
//
//
//         child: Container(
//           height: widget.h,
//           width: widget.w,
//           decoration: BoxDecoration(
//             border: Border.all(width: 1, color: Colors.grey.shade300),
//             borderRadius: const BorderRadius.all(
//               Radius.circular(10),
//             ),
//             color: widget.backgroundColor,
//           ),
//           child: Container(
//             padding: const EdgeInsets.only(top: 10),
//             child: widget.title.text.center.color(widget.color).bold.xl2.make(),
//           ),
//         ),
//       ),
//     );
//   }
// }
