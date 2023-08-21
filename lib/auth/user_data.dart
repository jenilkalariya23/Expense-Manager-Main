import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
// import 'package:flutter/material.dart';


Future<void> userSetup(BuildContext context, String username, email, password, profilePic, int phoneNumber) async {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = "";
  uid = auth.currentUser!.uid.toString();
  try {
    users.doc(uid).set({
      'username': username,
      'email': email,
      'password': password,
      'phone': phoneNumber,
      'uid': uid,
      'userLast': "",
      'profile_pic': profilePic,
    });
  } catch (error) {
    VxToast.show(context,
        msg: "User Data Upload Error!",
        bgColor: Colors.green.shade100,
        textColor: Colors.green.shade500,
        textSize: 14,
        position: VxToastPosition.center);
  }
  return;
}



Future<void> Budget(BuildContext context, String a_monthbudget,formattedDate) async {

  CollectionReference users = FirebaseFirestore.instance.collection('Budget');
  // FirebaseFirestore
  //     .instance
  //     .collection('Budget')
  //     .doc('Budget'.uid)
  //     .collection(
  //     "user_orders")
  //     .add({
  //   //add your data that you want to upload
  // });

  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = "";
  uid = auth.currentUser!.uid.toString();
  try {
    users.doc(uid).collection(formattedDate).doc(uid).set({
      'JAN' : a_monthbudget,
      'FEB' : a_monthbudget,
      'MAR' : a_monthbudget,
      'APR' : a_monthbudget,
      'MAY' : a_monthbudget,
      'JUN' : a_monthbudget,
      'JUL' : a_monthbudget,
      'AUG' : a_monthbudget,
      'SEP' : a_monthbudget,
      'OCT' : a_monthbudget,
      'NOV' : a_monthbudget,
      'DEC' : a_monthbudget,
    });
  } catch (error) {
    VxToast.show(context,
        msg: "User Data Upload Error!",
        bgColor: Colors.green.shade100,
        textColor: Colors.green.shade500,
        textSize: 14,
        position: VxToastPosition.center);
  }
  return;
}



// void getUserData(BuildContext context,String s_monthbudget,selecteditem) async {
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//   final CollectionReference users = firestore.collection('Budget');
//
//   FirebaseAuth auth = FirebaseAuth.instance;
//
//   String uid = auth.currentUser!.uid.toString();
//   try {
//
//     users.doc(uid).collection('2022').doc(uid).get().then((value){
//       s_monthbudget = value[selecteditem].toString();
//     });
//   } catch (error) {
//     VxToast.show(context,
//         msg: "User Data Upload Error!",
//         bgColor: Colors.green.shade100,
//         textColor: Colors.green.shade500,
//         textSize: 14,
//         position: VxToastPosition.center);
//   }
//   return;
// }


Future<void> singleBudget(BuildContext context, String s_monthbudget,selecteditem, formattedDate) async {
  CollectionReference users = FirebaseFirestore.instance.collection('Budget');
  // FirebaseFirestore
  //     .instance
  //     .collection('Budget')
  //     .doc('Budget'.uid)
  //     .collection(
  //     "user_orders")
  //     .add({
  //   //add your data that you want to upload
  // });
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = "";
  uid = auth.currentUser!.uid.toString();
  try {
    users.doc(uid).collection(formattedDate).doc(uid).set({
      selecteditem : s_monthbudget,
    });
  } catch (error) {
    VxToast.show(context,
        msg: "User Data Upload Error!",
        bgColor: Colors.green.shade100,
        textColor: Colors.green.shade500,
        textSize: 14,
        position: VxToastPosition.center);
  }
  return;
}
Future<void> expense(BuildContext context, String Title,Description,category,Date,PaymentType,Month,Year,FullDate,Time,int Amount,) async {
  CollectionReference users = FirebaseFirestore.instance.collection('Expense');
  // FirebaseFirestore
  //     .instance
  //     .collection('Budget')
  //     .doc('Budget'.uid)
  //     .collection(
  //     "user_orders")
  //     .add({
  //   //add your data that you want to upload
  // });
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = "";
  uid = auth.currentUser!.uid.toString();
  try {
    users.add({
      'Title' : Title,
      'Description': Description,
      'Amount':Amount,
      'Date':Date,
      'PaymentType':PaymentType,
      // 'Month':Month,
      'Month':Month,
      'Year':Year,
      'UserId':uid,
      'FullDate':FullDate,
      'category':category,
      // 'categoryID':categoryID,
      'Time':Time,
    });
  } catch (error) {
    VxToast.show(context,
        msg: "User Data Upload Error!",
        bgColor: Colors.green.shade100,
        textColor: Colors.green.shade500,
        textSize: 14,
        position: VxToastPosition.center);
  }
  return;
}


// Future<void> expense(BuildContext context, String Title,Description,Date,category,PaymentType,Month,Year,FullDate,int Amount) async {
//   CollectionReference users = FirebaseFirestore.instance.collection('Expense');
//   // FirebaseFirestore
//   //     .instance
//   //     .collection('Budget')
//   //     .doc('Budget'.uid)
//   //     .collection(
//   //     "user_orders")
//   //     .add({
//   //   //add your data that you want to upload
//   // });
//   FirebaseAuth auth = FirebaseAuth.instance;
//   String uid = "";
//   uid = auth.currentUser!.uid.toString();
//   try {
//     users.add({
//       'Title' : Title,
//       'Description': Description,
//       'Amount':Amount,
//       'Date':Date,
//       'category':category,
//       'PaymentType':PaymentType,
//       // 'Month':Month,
//       'Month':Month,
//       'Year':Year,
//       'UserId':uid,
//       'FullDate':FullDate,
//     });
//   } catch (error) {
//     VxToast.show(context,
//         msg: "User Data Upload Error!",
//         bgColor: Colors.green.shade100,
//         textColor: Colors.green.shade500,
//         textSize: 14,
//         position: VxToastPosition.center);
//   }
//   return;
// }


// Future<void> Category(BuildContext context, String category) async {
//   CollectionReference users = FirebaseFirestore.instance.collection('Category');
//   FirebaseAuth auth = FirebaseAuth.instance;
//   String uid = "";
//   uid = auth.currentUser!.uid.toString();
//   try {
//     users.doc(uid).collection('add_category').add({
//       'category' : category,
//       'uid': uid,
//     });
//   } catch (error) {
//     VxToast.show(context,
//         msg: "User Data Upload Error!",
//         bgColor: Colors.green.shade100,
//         textColor: Colors.green.shade500,
//         textSize: 14,
//         position: VxToastPosition.center);
//   }
//   return;
// }
