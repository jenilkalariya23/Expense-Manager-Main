import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensemanager/mvc/model/category/categroy_items.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class CategoryNotifier with ChangeNotifier {
  List<Category> _itemsList = [];
  late Category _currentCategory;


  UnmodifiableListView<Category> get itemsList =>
      UnmodifiableListView(_itemsList);

  Category get cureentCategory => _currentCategory;

  set itemsList(List<Category> itemsList) {
    _itemsList = itemsList;
    notifyListeners();
  }

  set cureentCategory(Category category) {
    _currentCategory = category;
    notifyListeners();
    // print(_currentCategory);
  }
}

getCategory(CategoryNotifier categoryNotifier) async {
  QuerySnapshot snapshot =
  await FirebaseFirestore.instance.collection('categories').where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser!.uid.toString();

  List<Category> itemsList = [];

  for (var element in snapshot.docs) {
    Category category =
    Category.fromMap(element.data() as Map<String, dynamic>);
    if (category.uid == "" || category.uid.toString().contains(uid)) {
      itemsList.add(category);
    }
  }
  categoryNotifier.itemsList = itemsList;
}

