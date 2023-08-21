import 'dart:async';
import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensemanager/mvc/view/bottom_navigation/bottom_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../helper/DatePickerWidget.dart';
import '../../../helper/WidgetHelper.dart';
import '../../../helper/navigator_helper.dart';
import '../../../localization/AppLocalizations.dart';
import '../../../style/app_color.dart';
import '../../tiles/widget_home_tile_item.dart';



class calendersearch extends StatefulWidget {

  calendersearch({Key? key,}) : super(key: key);

  @override
  _calendersearchState createState() => _calendersearchState();
}

class _calendersearchState extends State<calendersearch> {
  Icon customIcon = const Icon(Icons.search);
  final DateFormat start = DateFormat('yyyy-MM-dd');
  final DateFormat end = DateFormat('yyyy-MM-dd');
  Widget customSearchBar = const Text('My Personal Journal');
  Icon actionIcon = new Icon(Icons.search);
  Widget appBarTitle = new Text("AppBar Title");
  int _i = 0;
  int _total = 0;


  //  hello(){
  //   StreamBuilder(
  //     stream: FirebaseFirestore.instance
  //         .collection('Expense').where('UserId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  //         .where('date', isLessThan: end)
  //         .orderBy('date', descending: true)
  //         .snapshots(),
  //
  //
  //     builder: (context,
  //         AsyncSnapshot<QuerySnapshot> snapshot) {
  //       snapshot.data!.docs.forEach((user) {
  //         _i = user['Amount'];
  //         total = total + _i;
  //         print(_total);
  //       });
  //       return ListView(
  //       );
  //     },
  //   );
  // }
  bool isLoading = false;

  // void onSearch() async {
  //   FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //
  //   setState(() {
  //     isLoading = true;
  //   });
  //
  //   await _firestore
  //       .collection('users')
  //       .where("Category", isEqualTo: _searchController.text)
  //       .get()
  //       .then((value) {
  //     setState(() {
  //       // userMap = value.docs[0].data();
  //       isLoading = false;
  //     });
  //     // print(userMap);
  //   });
  // }

  String bcd = "";
  String fdate = "";

  // DateTime fdate=DateTime.now();
  DateTime selectedDate = DateTime.now();


  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime? pickedDate = await showDatePicker(
  //       context: context,
  //       initialDate: DateTime.now(),
  //       firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
  //       lastDate: DateTime(2101)
  //   );
  //
  //   if(pickedDate != null ){
  //
  //     String formattedDate1 = DateFormat('yyyy-MM-dd').format(pickedDate);
  //     demoo=formattedDate1;
  //     print(demoo);
  //     setState(() {
  //       _date= pickedDate;
  //       widget.Callback(demoo);
  //     });
  //   }else{
  //     print("Date is not selected");
  //   }
  //
  //
  //
  //   // return
  //   fetchData(selectedDate);
  // }
  //
  // Stream? mydata;

  // fetchData(DateTime? dateTm){
  //  var res= FirebaseFirestore.instance
  //       .collection('Expense').where('UserId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  //   .where('Date',isEqualTo :selectedDate)
  //   // .where('Date',isLessThan:sele)
  //       .snapshots();
  //   // setstate(({mydata=res;});
  //   setState(() {
  //     mydata=res;
  //     print(mydata);
  //   });
  //
  //   }


  // Future<Stream?>  fetchData(BuildContext context) async {
  //  var res = FirebaseFirestore.instance
  //       .collection('Expense').where('UserId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  //       .where('Date',isEqualTo :selectedDate)
  //   // .where('Date',isLessThan:sele)
  //       .snapshots();
  //         setState(() {
  //    mydata=res;
  //    print(mydata);
  //  });
  // }


  Stream<QuerySnapshot<Object?>> fetchData(String fdate,bcd) {

    Stream<QuerySnapshot> query = (fdate != "" && bcd != null) ? FirebaseFirestore.instance
        .collection('Expense').where('UserId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('Date',isGreaterThanOrEqualTo: fdate)
        .where('Date',isLessThanOrEqualTo:bcd)
        .snapshots()
    :FirebaseFirestore.instance.collection('Expense').where('UserId', isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots();
    return query;
  }


  // void getBudgetData(BuildContext context) async {
  //   FirebaseFirestore.instance
  //       .collection('Expense').where('UserId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  //   .where('Date',isEqualTo :fdate)
  //   // .where('Date',isLessThan:'2022-08-01')
  //       .snapshots();
  // }

  TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    fetchData(fdate,bcd);
    _searchController.addListener(_onSearchChanged);
    // hello();
  }
  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }
  _onSearchChanged() {
    print(_searchController.text);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title:appBarTitle,
        // actions: <Widget>[
        //   IconButton(icon: actionIcon,
        //     onPressed:(){
        //       setState(() {
        //         if (this.actionIcon.icon == Icons.search){
        //           this.actionIcon = new Icon(Icons.close);
        //           this.appBarTitle = TextField(
        //             style: TextStyle(
        //               color: Colors.black,
        //             ),
        //             decoration: InputDecoration(
        //                 prefixIcon: new Icon(Icons.search,color: Colors.black),
        //                 hintText: "Search...",
        //                 hintStyle: new TextStyle(color: Colors.black)
        //             ),
        //           );
        //         }
        //         else {
        //           this.actionIcon = new Icon(Icons.search);
        //           this.appBarTitle = new Text("AppBar Title");
        //         }
        //       }
        //       );
        //     } ,),
        // ],


        backgroundColor: AppColor.BodyColor,
        leading:  IconButton(
          icon:  Icon(Icons.arrow_back,color: AppColor.Black,),
          onPressed: () {
            NavigatorHelper.add(BottomBar());
          },
        ),
        // iconTheme: IconThemeData(
        //   color: Colors.black, //change your color here
        // ),
        elevation: 0,
      ),

      body: Container(
        color: AppColor.BodyColor,
        child: Container(
          child: Column(
            children: [
              // Padding(
              //   padding:  EdgeInsets.only(left: 30.0, right: 30.0, bottom: 30.0),
              //   child: TextField(
              //     controller: _searchController,
              //     decoration: InputDecoration(
              //         prefixIcon: Icon(Icons.search)
              //     ),
              //   ),
              // ),
              Expanded(
                // fit: FlexFit.tight,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(padding: EdgeInsets.all(1)),
                              DatePickerWidget(context: context,
                                Callback: (String firstdate){
                                  setState((){
                                    fdate = firstdate;
                                  });
                                  fetchData(fdate,bcd);
                                },),
                              // RaisedButton(
                              //   onPressed: () => _selectDate(context),
                              //   child:Text(formatter.format(selectedDate).toString(),
                              //       style: const TextStyle(
                              //         height: 1.5,
                              //       )),
                              // ),
                              SizedBox(
                                child: Text(buildTranslate(context, "to")),
                              ),
                              // DatePickerWidget1(contex: context,
                              //     Callback: (String abc){
                              //   bcd = abc;
                              //   print(bcd);
                              //
                              // }
                              // ),
                              DatePickerWidget1(contex: context,
                                Callback: (String abc){
                                  setState((){
                                    bcd = abc;
                                  });
                                  fetchData(fdate,bcd);
                                },),

                              // RaisedButton(
                              //   onPressed: () => _selectDate(context),
                              //   child: Text(formatter.format(selectedDate).toString(),
                              //       style: const TextStyle(
                              //         height: 1.5,
                              //       )),
                              // ),
                            ],
                          ),

                        ),
                      ],
                    ),
                    WidgetHelper.getDividerSeparator(),

                    SizedBox(
                      height: 20,
                    ),


                    Flexible(
                      fit: FlexFit.tight,
                      child: StreamBuilder(
                        // stream: FirebaseFirestore.instance
                        //     .collection('Expense').where('UserId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                        //     // .where('Date',isEqualTo :selectedDate)
                        //     // .where('Date',isLessThan:'2022-08-01')
                        //     .snapshots(),
                        stream:   fetchData(fdate,bcd),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return Center(
                                child: CircularProgressIndicator()
                              // .centered()
                              // .expand()
                            );
                          }

                          print('skndklkhh');
                          snapshot.data!.docs.forEach((user) {
                            _i = user['Amount'];
                            _total = _total + _i;
                            print(_total);
                          });


                          return ListView(
                            physics: BouncingScrollPhysics(),
                            children: snapshot.data!.docs.map((user) {
                              return Center(
                                child: ListTile(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                                  selected: true,
                                  title: HomeTileItemWidget(
                                    Category: user['category'],
                                    cost: user['Amount'],
                                    Date: user['Date'],
                                    image:   'random_2.png',
                                  ),
                                  // onLongPress: () {
                                  //   user.reference.delete();
                                  // },
                                ),
                              );
                            }).toList(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


// List<ExpandableController> controllerList = [
//   ExpandableController(),
//   ExpandableController(),
//   ExpandableController()
// ];
// int currentIndex = -1;


// class Card1 extends StatelessWidget {
//
//   @override
//   Widget build(BuildContext context) {
//
//     return ExpandableNotifier(
//         child: Padding(
//           padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
//           child: Flexible(
//             fit: FlexFit.tight,
//             child: StreamBuilder(
//               stream: FirebaseFirestore.instance
//                   .collection('Expense').where('UserId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
//               // .orderBy('date', descending: true)
//                   .snapshots(),
//               builder: (context,
//                   AsyncSnapshot<QuerySnapshot> snapshot) {
//                 if (!snapshot.hasData) {
//                   return Center(
//                       child: CircularProgressIndicator()
//                     // .centered()
//                     // .expand()
//                   );
//                 }
//                 return ListView(
//                   physics: BouncingScrollPhysics(),
//                   // physics: BouncingScrollPhysics(),
//                   children: snapshot.data!.docs.map((user) {
//                     return Center(
//                       child: ListTile(
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
//                         selected: true,
//                         // selectedTileColor: Colors.grey.shade100,
//                         leading: Container(
//                           width: 60,
//                           height: 70,
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             image: DecorationImage(
//                               fit: BoxFit.cover,
//                               image: AssetImage(
//                                 'assets/Icons/Onboarding 1/random_2.png',
//                               ),
//                             ),
//                           ),
//                           alignment: Alignment.center,
//                         ),
//                         title: Text(
//                           user['Category'],
//                           style: const TextStyle(
//                             fontSize: 17,
//                             color: Colors.black,
//                             // fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         subtitle: Text(
//                           user['Date'],
//                           style: TextStyle(
//                             color: Colors.grey,
//                             fontSize: 14,
//                             // fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         // subtitle: Text(
//                         //   DateFormat('dd MMMM, yyyy')
//                         //       .format(
//                         //       (user['date'] as Timestamp)
//                         //           .toDate())
//                         //       .toString(),
//                         //   style: TextStyle(
//                         //     fontSize: 14,
//                         //     // fontWeight: FontWeight.bold,
//                         //   ),
//                         // ),
//                         trailing: Text(
//                           '\u{20B9}${user['Amount'].toString()}',
//                           style: const TextStyle(
//                             fontSize: 16,
//                             color: Colors.black,
//                             // fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         // onLongPress: () {
//                         //   user.reference.delete();
//                         // },
//                       ),
//                     );
//                   }).toList(),
//                 );
//               },
//             ),
//           ),
//         ));
//   }
// }
//
// class Card2 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ExpandableNotifier(
//         child: Padding(
//           padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
//           child: Card(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(28),
//             ),
//             color: Colors.grey.shade200,
//             clipBehavior: Clip.antiAlias,
//             child: Column(
//               children: <Widget>[
//                 ScrollOnExpand(
//                   scrollOnExpand: true,
//                   scrollOnCollapse: false,
//                   child: ExpandablePanel(
//                     controller: controllerList[1],
//                     theme: const ExpandableThemeData(
//                       iconColor: Colors.black,
//                       headerAlignment: ExpandablePanelHeaderAlignment.center,
//                       tapBodyToCollapse: true,
//                     ),
//                     header: InkWell(
//                       onTap: () {
//                         currentIndex = 1;
//                         for (int i = 0; i < controllerList.length; i++) {
//                           if (i == currentIndex) {
//                             controllerList[i].expanded = true;
//                           } else {
//                             controllerList[i].expanded = false;
//                           }
//                         }
//                       },
//                       child: Row(
//                         children: [
//                           Container(
//                             height: 57,
//                             width: 57,
//                             decoration: const BoxDecoration(
//                               shape: BoxShape.circle,
//                               color: Colors.white,
//                               image: DecorationImage(
//                                 fit: BoxFit.cover,
//                                 image: AssetImage(
//                                   "assets/Icons/Onboarding 1/random_3.png",
//                                 ),
//                               ),
//                             ),
//
//                             child: Padding(
//                                 padding: EdgeInsets.all(10),
//                                 child: Row(
//                                   mainAxisAlignment: MainAxisAlignment.end,
//                                   children: [
//                                     Expanded(flex: 9, child: Container()),
//
//                                   ],
//                                 )),
//                           ),
//                           Container(
//                             margin: new EdgeInsets.symmetric(horizontal: 15),
//                             child: Expanded(
//                               flex: 3,
//                               child: "Travel".text.bold.xl.make(),
//                             ),
//                           ),
//                           Container(
//                             margin: new EdgeInsets.symmetric(horizontal: 30),
//                             child: Expanded(
//                               flex: 3,
//                               child: "\$500.00".text.bold.xl.make(),
//                             ),
//                           ),
//                         ],
//
//                       ),
//
//                     ),
//                     collapsed: Container(),
//                     expanded: Container(
//                       color: Colors.white,
//                       child: Padding(
//                         padding: EdgeInsets.all(10),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: <Widget>[
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text("McDonalds",
//                                     style: TextStyle(color: Colors.black)),
//                               ],
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text(
//                                   "to",
//                                   style: TextStyle(color: Colors.black),
//                                 ),
//                               ],
//                             ),
//
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Text("5th Street Mega mall Road.",
//                                     style: TextStyle(color: Colors.black)),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//
//
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ));
//   }
// }
//
// class Card3 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return ExpandableNotifier(
//         child: Padding(
//           padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
//           child: Card(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(28),
//             ),
//             color: Colors.grey.shade200,
//             clipBehavior: Clip.antiAlias,
//             child: Column(
//               children: <Widget>[
//                 ScrollOnExpand(
//                   scrollOnExpand: true,
//                   scrollOnCollapse: false,
//                   child: ExpandablePanel(
//                     controller: controllerList[2],
//                     theme: const ExpandableThemeData(
//                       iconColor: Colors.black,
//                       headerAlignment: ExpandablePanelHeaderAlignment.center,
//                       tapBodyToCollapse: true,
//                     ),
//                     header: InkWell(
//                       onTap: ()