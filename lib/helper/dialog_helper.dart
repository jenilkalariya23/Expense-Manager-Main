

import 'dart:async';
import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensemanager/auth/storage_service.dart';
import 'package:expensemanager/style/app_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../localization/AppLocalizations.dart';
import '../style/fonts.dart';
import 'WidgetHelper.dart';

final Storage storage = Storage();
final textInputController = TextEditingController();
final _formKey = GlobalKey<FormState>();
int name1 = 0;
List<String> categoryName = [];



class DialogHelper {
  static showConfirmDialog(
      BuildContext context, String title, Function callback) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          title: Center(
            child: Text(
              title,
              style: Fonts.appbarFontBlack,
            ),
          ),
          actions: <Widget>[
            Form(
              key: _formKey,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  //  color: AppColor.TitleTextColor,
                ),
                margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Column(
                  children: [

                    Container(
                      margin: const EdgeInsets.fromLTRB(20.0, 8.0, 10.0, 5.0),
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        controller: textInputController,
                        autofocus: false,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]"))
                        ],
                        decoration: InputDecoration(
                            hintText: buildTranslate(context, "categoryName"),
                            errorStyle: Fonts.Errordesign
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Required';
                          }
                          return null;
                        },
                      ),
                    ),
                    WidgetHelper.getDividerSeparator(),
                    SizedBox(
                      height: 25.0,
                    ),
                    GestureDetector(
                      onTap: ()  async{
                        await getCategoryID(context);
                        if (_formKey.currentState!.validate()) {
                          await existingdata(context);
                          Navigator.pop(context);
                          textInputController.clear();
                        }
                        // print(imageAccessToken);
                        // callback(true);
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColor.Buttoncolor,
                        ),
                        child: Text(
                          buildTranslate(context, "add"),
                          style: Fonts.dialogActionTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30.0,
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      },
    );
  }
}

existingdata(BuildContext context)  async{
  await  FirebaseFirestore.instance.collection('categories')
      .where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .where('categoryName', isEqualTo: textInputController.text.toString().capitalizeFirst)
      .get().then((event) {
    if (event.docs.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: AppColor.Buttoncolor,
          content: Text(
            "Already This Category is Existing",
            style: TextStyle(fontSize: 18.0, color: AppColor.BodyColor,),
          ),
        ),
      );   }
    else {
      pushCategoryToFirestore(
        context,
        textInputController.text.toString(),
        true,
      );
    }
  }).catchError((e) => print("error fetching data: $e"));

}



// Future<String> pickFile(BuildContext context) async {
//   final results = await FilePicker.platform
//       .pickFiles(allowMultiple: false, type: FileType.image);
//
//   if (results == null) {
//     VxToast.show(context,
//         msg: "Invalid Image!!",
//         bgColor: Colors.red.shade100,
//         textColor: Colors.red.shade500,
//         textSize: 14,
//         position: VxToastPosition.center);
//     return "null";
//   }
//   final path = results.files.single.path;
//   final fileName = results.files.single.name;
//
//   //upload image to firebase storage
//   storage.uploadImage(context, path!, fileName).then((value) {
//     VxToast.show(context,
//         msg: "Upload Successful",
//         bgColor: Colors.green.shade100,
//         textColor: Colors.green.shade500,
//         textSize: 14,
//         position: VxToastPosition.center);
//   }).onError((error, stackTrace) {
//     VxToast.show(context,
//         msg: "Error: $error",
//         bgColor: Colors.red.shade100,
//         textColor: Colors.red.shade500,
//         textSize: 14,
//         position: VxToastPosition.center);
//   });
//
//   //get download url of image
//   final firebase_storage.FirebaseStorage firebaseStorage =
//       firebase_storage.FirebaseStorage.instance;
//   String imageUrl = await firebaseStorage
//       .ref('categoryIconsCustom/$fileName')
//       .getDownloadURL();
//
//   return imageUrl;
// }


getCategoryID(BuildContext context)  async{


  await FirebaseFirestore.instance.collection('categories').where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid).orderBy('cid', descending: true).limit(1).get()
      .then((value) {
    value.docs.forEach((element) {
      name1  = element.data()['cid'];
      print(name1);
    });
    return name1;
  } );
}


// int count = 0;

Future<void> pushCategoryToFirestore(BuildContext context, String name,  bool isCustom ) async {
  CollectionReference users = FirebaseFirestore.instance.collection('categories');

  FirebaseAuth auth = FirebaseAuth.instance;

  String uid = "";
  // count = int.parse(name1);
  // count++;
  name1++;
  print(name1);
  uid = auth.currentUser!.uid.toString();
  //   FirebaseFirestore.instance.collection('categories').where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid).orderBy('cid', descending: true).limit(1).get()
  //     .then((value) {
  //   print("name1");
  //   value.docs.forEach((element) {
  //     name1  = element.data()['cid'];
  //     print(name1);
  //
  //   });
  // } );
  //   count = name1;
  //   print("jnbjsavf");
  //   print(count);
  //   count++;

  try {
    users.doc().set({
      'categoryName': name.capitalizeFirst,
      'isCustom': isCustom,
      "uid": uid,
      "cid": name1
    });
  } catch (error) {
    VxToast.show(context,
        msg: "Error: $error",
        bgColor: Colors.red.shade100,
        textColor: Colors.red.shade500,
        textSize: 14,
        position: VxToastPosition.center);
  }
  return;
}






// void getCategoryID(BuildContext context) async {
//   FirebaseFirestore firestore = FirebaseFirestore.instance;
//   final Future<QuerySnapshot<Map<String, dynamic>>> users = firestore.collection('categories').where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid).orderBy('cid', descending: true).limit(1).get().;
//   FirebaseAuth auth = FirebaseAuth.instance;
//   String uid = auth.currentUser!.uid.toString();
//   users.doc().get().then((value) {
//     name1 = value['cid'];
//     print(name1);
//     // _cnt = value['_cnt'].toString();
//   });
// }


// Future<void> pushCategoryToFirestore(
//     BuildContext context, String name, bool isCustom) async {
//   CollectionReference users =
//       FirebaseFirestore.instance.collection('categorie');
//   FirebaseAuth auth = FirebaseAuth.instance;
//
//   String uid = "";
//   count++;
//   uid = auth.currentUser!.uid.toString();
//
//   try {
//     users.doc("z_${uid}_$count").set({
//       'categoryName': name,
//       'isCustom': isCustom,
//       "uid": uid,
//     });
//   } catch (error) {
//     VxToast.show(context,
//         msg: "Error: $error",
//         bgColor: Colors.red.shade100,
//         textColor: Colors.red.shade500,
//         textSize: 14,
//         position: VxToastPosition.center);
//   }
//   return;
// }