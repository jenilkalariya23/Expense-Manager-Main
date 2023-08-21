import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class Storage {
  final firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;

  Future<void> uploadImage(
      BuildContext context, String filePath, fileName) async {
    File file = File(filePath);

    try {
      storage.ref('categoryIconsCustom/$fileName').putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      VxToast.show(context,
          msg: "Error: $e",
          bgColor: Colors.red.shade100,
          textColor: Colors.red.shade500,
          textSize: 14,
          position: VxToastPosition.center);
    }
  }
}
