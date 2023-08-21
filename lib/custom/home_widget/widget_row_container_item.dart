// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:velocity_x/velocity_x.dart';
//
// class RowContainerItem extends StatefulWidget {
//
//   String budget;
//
//   RowContainerItem({Key? key, required this.budget}) : super(key: key);
//
// @override
// State<RowContainerItem> createState() => _RowContainerItemState();
// }
//
// class _RowContainerItemState extends State<RowContainerItem> {
//   @override
//   Widget build(BuildContext context) {
//     //double h = MediaQuery.of(context).size.height;
//     double w = MediaQuery.of(context).size.width;
//     return Container(
//       width: w,
//       margin: const EdgeInsets.only(top: 30, bottom: 15),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Container(
//             width: 140,
//             height: 120,
//             margin: const EdgeInsets.only(left: 20),
//             decoration: BoxDecoration(
//               borderRadius: const BorderRadius.all(
//                 Radius.elliptical(5, 5),
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   spreadRadius: 2,
//                   blurRadius: 10,
//                   color: Colors.black.withOpacity(0.2),
//                 )
//               ],
//               color: Colors.white,
//             ),
//             child: Column(
//               children: [
//                 Container(
//                   margin: const EdgeInsets.only(top: 25),
//                   child: "Budget".text.center.bold.xl.make(),
//                 ),
//                 Container(
//                   margin: const EdgeInsets.only(top: 25),
//                   child: widget.budget.text.purple700.bold.xl2.make(),
//                 ),
//               ],
//             ),
//           ),
//           Container(
//             width: 140,
//             height: 120,
//             margin: const EdgeInsets.only(right: 20),
//             decoration: BoxDecoration(
//               borderRadius: const BorderRadius.all(
//                 Radius.elliptical(5, 5),
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   spreadRadius: 2,
//                   blurRadius: 10,
//                   color: Colors.black.withOpacity(0.2),
//                 )
//               ],
//               color: Colors.white,
//             ),
//             child: Column(
//               children: [
//                 Container(
//                   margin: const EdgeInsets.only(top: 25),
//                   child: "Expenses".text.center.bold.xl.make(),
//                 ),
//                 Container(
//                   margin: const EdgeInsets.only(top: 25),
//                   child: "\$1250.00".text.center.green600.bold.xl2.make(),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
