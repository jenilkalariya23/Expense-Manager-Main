import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../style/app_color.dart';
import '../../tiles/widget_home_tile_item.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String? name;

  fetchData(name) {
    Stream<QuerySnapshot <Object>> query =  (name != "" && name != null)
        ? FirebaseFirestore.instance
          .collection('Expense').where('UserId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .where('category', isGreaterThanOrEqualTo: name)
        .where('category', isLessThan: name +'z')
        .snapshots()
        : FirebaseFirestore.instance.collection('Expense')
        .where('UserId', isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots();
    return query;
  }

  // getExpenseData(name)  {
  //   FirebaseFirestore.instance
  //       .collection('Expense').where('UserId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  //       .where('category', isLessThanOrEqualTo: name)
  //       .snapshots();
  // }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.BodyColor,
        iconTheme: IconThemeData(
          color: AppColor.Black,//change your color here
        ),
        title: TextField(
          // controller: _searchController,
          onChanged: (val) {
            setState(() {
              name = val;
            });
          },
          decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
          ),
        ),
        elevation: 0,
      ),
      backgroundColor: AppColor.BodyColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot >(
                  // stream: fetchData(name),
                  stream: fetchData(name),
                  builder: (context, snapshot) {
                    return (snapshot.connectionState == ConnectionState.waiting)
                        ? Center(child: CircularProgressIndicator()):Column(
                      children: snapshot.data!.docs.map((user) {
                        return Center(
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            selected: true,
                            title: HomeTileItemWidget(
                              Category: user['category'],
                              cost: user['Amount'],
                              Date: user['Date'],
                              image:   'random_2.png',
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }
              ),
            ],
          ),
        ),
    );
  }

}