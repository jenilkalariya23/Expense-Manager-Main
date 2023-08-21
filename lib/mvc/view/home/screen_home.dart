import 'package:expensemanager/mvc/view/home/screen_filter.dart';
import 'package:expensemanager/mvc/view/home/search.dart';
import 'package:expensemanager/style/app_color.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:velocity_x/velocity_x.dart';
import 'dart:core';
import '../../../helper/navigator_helper.dart';
import '../../../localization/AppLocalizations.dart';
import '../../../style/fonts.dart';
import '../../tiles/widget_home_row_container_calender.dart';
import '../../tiles/widget_home_tile_item.dart';
import '../../../custom/home_widget/widget_navigation_drawer.dart';
import 'Calender Search.dart';


FirebaseFirestore firestore = FirebaseFirestore.instance;
final CollectionReference users = firestore.collection('Expense');
FirebaseAuth auth = FirebaseAuth.instance;
String uid = auth.currentUser!.uid.toString();
var now = new DateTime.now();
var formatter = new DateFormat('yyyy');
var Month = new DateFormat('mm');
String formattedDate = formatter.format(now);
String formattedMonth = Month.format(now);

class Dashboard extends StatefulWidget {
  Dashboard( {Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  late DocumentSnapshot documentSnapshot;
  var today = new DateTime.now();
  var ringdate = new DateTime.now();
  String? value = '2022';
  bool loading = true;
  String budgetAmount = "";
  String _cnt = "";
  int selectedmonth= 0;
  String currentMonth="JAN";
  String currentyear=formattedDate;
  String demo="";
  String ex="";
  List<String> filterarr = <String>[];
  String checkmon="Jan";
  final yearItems = [
    '2011',
    '2012',
    '2013',
    '2014',
    '2015',
    '2016',
    '2017',
    '2018',
    '2019',
    '2020',
    '2021',
    '2022'
  ];

  String holder = "";

  getExpenseData(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CollectionReference users = firestore.collection('Expense');
    FirebaseAuth auth = FirebaseAuth.instance;
    int _i = 0;
    int _total = 0;
    users.where('UserId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('Month',isEqualTo: abc).get().then((value) {
      value.docs.forEach((value) {
        setState((){
          if(value.exists){
            _i = value['Amount'];
            _total = _total + _i;
            holder = _total.toString();
          }else{
            holder = "set Expense";
          }
        });
      });
    });
  }

  void getBudgetData(BuildContext context) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CollectionReference users = firestore.collection('Budget');
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    users.doc(uid).collection(currentyear).doc(uid).get().then((value) {
      setState(() {
        budgetAmount = '\$${value[currentMonth]}'.toString();
        // _cnt = value['_cnt'].toString();
      });
    }).onError((error, stackTrace) {
      budgetAmount = "Set Budget";
    });
  }

  //
  // void hello(String ex) {
  //   demo = ex;
  //   print(demo);
  // }

  String abc="Jan";

  // fetchData(def,abc) {
  //   Stream<QuerySnapshot> query = FirebaseFirestore.instance
  //       .collection('Expense').where('UserId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  //       .where('category',isEqualTo: def)
  //       .snapshots();
  //   return query;
  // }


  // fetchData(abc, def) {
  //   Stream<QuerySnapshot <Object>> query =  (abc != "" && def != null)
  //       ? FirebaseFirestore.instance
  //       .collection('Expense').where('UserId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  //       .where('Month',isEqualTo : abc)
  //   // .where('Category', isGreaterThanOrEqualTo: searchKey)
  //   // .where('Category', isLessThan: searchKey! +'z')
  //   // .where('Category', isLessThanOrEqualTo: name)
  //       .snapshots()
  //       : FirebaseFirestore.instance.collection('Expense').where('UserId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  //       .where('Month',isEqualTo : abc)
  //       .where('categoryName',isEqualTo:  def)
  //       .snapshots();
  //   // Stream<QuerySnapshot> query =
  //   // FirebaseFirestore.instance
  //   //     .collection('Expense').where('UserId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  //   //     .where('Category', isGreaterThanOrEqualTo: name)
  //   //     .where('Category', isLessThan: name +'z')
  //   //     .snapshots();
  //   // setState(() {
  //   //   mydata=res;
  //   //   print(mydata);
  //   // });
  //   print(def);
  //   print(uid);
  //   print("najdhahdjakdkja");
  //   return query;
  // }

  // Stream<QuerySnapshot<Object?>> fetchCategory() {
  //   Stream<QuerySnapshot> query = FirebaseFirestore.instance
  //       .collection('Expense').where('UserId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  //       .where('category', isGreaterThanOrEqualTo: filterarr)
  //       .snapshots();
  //   return query;
  // }
  fetchData(List<String> filterarr) {
    Stream<QuerySnapshot <Object>> query = !(filterarr != null && filterarr != "" && filterarr.isNotEmpty)
        ? FirebaseFirestore.instance
        .collection('Expense').where('UserId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('Month',isEqualTo : abc)
        .snapshots()
        : FirebaseFirestore.instance.collection('Expense')
        .where('UserId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .where('Month',isEqualTo : abc)
        .where('category', whereIn : filterarr)
        .snapshots();
    print(uid);
    print(abc);
    print(filterarr);
    return query;
  }


  // Stream<QuerySnapshot<Object?>> fetchData(abc) {
  //   Stream<QuerySnapshot> query =  (abc != "" && abc != null)
  //       ? FirebaseFirestore.instance
  //       .collection('Expense').where('UserId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  //       .where('Month',isEqualTo : abc)
  //       .snapshots()
  //       : FirebaseFirestore.instance .collection('Expense')
  //       .where('UserId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  //       .where('Month',isEqualTo : abc)
  //       .where('category',isEqualTo : filterarr)
  //       .snapshots();
  //   return query;
  // }

  // Stream<QuerySnapshot<Object?>> fetchData(String abc,def) {
  //
  //   Stream<QuerySnapshot> query = (abc != "" && def != null) ? FirebaseFirestore.instance
  //       .collection('Expense').where('UserId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  //       .where('Month',isEqualTo: abc)
  //       .snapshots()
  //       :FirebaseFirestore.instance.collection('Expense')
  //       .where('UserId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
  //       .where('Month',isEqualTo: abc)
  //       .where('category',isEqualTo:def)
  //       .snapshots();
  //   return query;
  // }


  @override
  void initState() {
    setState(() {
      getBudgetData(context);
      getExpenseData(context);
      // hello(demo);
      fetchData(filterarr);
      // getsBudgetData(context);
    });
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    // print(widget.arr);
    return Scaffold(
      backgroundColor: AppColor.BodyColor,
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Image.asset(
                "assets/Icons/list.png",
                color: AppColor.Black,
              ),
            );
          },
        ),
        elevation: 0,
        backgroundColor: AppColor.BodyColor,
        centerTitle: true,
        title: DropdownButton<String>(
            underline: const SizedBox(),
            elevation: 0,
            isDense: false,
            icon: const Icon(Icons.keyboard_arrow_down_outlined),
            value: value,
            items: yearItems.map(buildMenuItem).toList(),
            onChanged: (value) {
              setState(() {
                // AppColor.Buttoncolor;
                Colors.white;
                this.currentyear = value!;
                this.value = value;
                // widget.callBack(this.currentyear);
              });
              getBudgetData(context);
              getExpenseData(context);
              // getsBudgetData(context);
            }),
        actions: [
          GestureDetector(
            onTap: () {
              NavigatorHelper.add(Search());
            },
            child: Image.asset(
              "assets/Icons/Search.png",
              color: AppColor.Black,
              width: 20,
            ),
          ),
          SizedBox(
            width: 15,
          ),
          GestureDetector(
            onTap: () {
              NavigatorHelper.add(calendersearch());
            },
            child: Image.asset(
              "assets/Icons/Calender.png",
              color: AppColor.Black,
              width: 20,
            ),
          ),
          SizedBox(
            width: 15,
          ),
          GestureDetector(
            onTap: () async{
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  FilterHomeRedirectWidget(
                    CallBack: (List<String> arrdata){
                      setState((){
                        filterarr = arrdata;
                        print("-------------------------------");
                        print(filterarr);
                        print("-------------------------------");
                      });

                      fetchData(filterarr);
                    },),
                ),
              );
            },
            child: Image.asset(
              "assets/Icons/filter.png",
              color: AppColor.Black,
              height: 22,
              width: 20,
            ),
          ),
          SizedBox(
            width: 15,
          ),
        ],
      ),
      // drawer: NavigationDrawer(),
      body: SingleChildScrollView(
          child: Column(
            children: [
              RowContainerCal(
                selectedIndex: selectedmonth,
                callBack: (String monthName,name,int index ){
                  setState((){
                    currentMonth=monthName;
                    selectedmonth=index;
                    abc=name;
                  });
                  getBudgetData(context);
                  getExpenseData(context);
                  // hello(demo);
                  fetchData(filterarr);
                  // getsBudgetData(context);
                },
              ),
              SizedBox(
                height: 30,
              ),
              SingleChildScrollView(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: 140,
                      height: 120,
                      margin: const EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.elliptical(5, 5),
                        ),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.2),
                          )
                        ],
                        color: AppColor.BodyColor,
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 25),
                            child: Text(
                              buildTranslate(context, "budget"),
                              style: Fonts.budgetexpenseTitle,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 25),
                            child: Text(
                              budgetAmount,
                              textAlign: TextAlign.center,
                              style: Fonts.budgetDesc,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 140,
                      height: 120,
                      margin:  EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.elliptical(5, 5),
                        ),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.2),
                          )
                        ],
                        color: AppColor.BodyColor,
                      ),
                      child: Column(
                        children: [
                          Container(
                            margin:  EdgeInsets.only(top: 25),
                            child: Text(
                              buildTranslate(context, "expenses"),
                              style: Fonts.budgetexpenseTitle,
                            ),
                          ),
                          Container(
                            margin:  EdgeInsets.only(top: 25),
                            child: Text(
                              '\$${holder}',
                              textAlign: TextAlign.center,
                              style: Fonts.expenseDesc,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            margin:  EdgeInsets.only(left: 30, top: 20,),
                            child: Text(
                              buildTranslate(context, "recentExpenses"),
                              style: Fonts.textTitle,
                            )
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                // stream: FirebaseFirestore.instance
                //     .collection('Expense').where('UserId',isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                // // .orderBy('date', descending: true)
                //     .snapshots(),
                  stream: fetchData(filterarr),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if(!snapshot.hasData || snapshot.hasData == null) {
                      return Center(
                          child: CircularProgressIndicator());
                    }
                    else {
                      // int _i = 0;
                      // int _total = 0;
                      // snapshot.data!.docs.forEach((user) {
                      //   _i = user['Amount'];
                      //   _total = _total + _i;
                      //   String holder;
                      //   holder = _total.toString();
                      //   return hello(holder);
                      // });
                      return Column(
                        children:
                        snapshot.data!.docs.map((user)
                        {
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
                  }
              ),
            ],
          )
      ),
    );
  }
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
    value: item,
    child: item.text.black.bold.xl2.make(),
  );
}