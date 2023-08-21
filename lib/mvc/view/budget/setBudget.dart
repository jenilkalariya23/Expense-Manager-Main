import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:expensemanager/auth/user_data.dart';
import 'package:expensemanager/mvc/view/bottom_navigation/bottom_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../../helper/WidgetHelper.dart';
import '../../../helper/button_view.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import '../../../helper/navigator_helper.dart';
import '../../../localization/AppLocalizations.dart';
import '../../../style/app_color.dart';
import '../../../style/fonts.dart';

var now = new DateTime.now();
var formatter = new DateFormat('yyyy');
String formattedDate = formatter.format(now);


class SetBudget extends StatefulWidget {
  int _selectedIndex = 0;
  SetBudget({Key? key}) : super(key: key);

  @override
  State<SetBudget> createState() => _SetBudgetState();
}

class _SetBudgetState extends State<SetBudget>
    with SingleTickerProviderStateMixin {
  List<String> title = ['All Months', 'Single Month'];

  List tabs = [
    Container(
      child: Text("1"),
    ),
    Container(
      child: Text("2"),
    )
  ];

  void _tabChange(int index) {
    setState(() {
      widget._selectedIndex = index;
    });
  }
  int _radioSelected = 1;
  String? _radioVal;
  String? _myActivity;
  String? _myActivityResult;
  final formKey = new GlobalKey<FormState>();



  @override
  void initState() {
    _cnt = SingleValueDropDownController();
    getUserData(context);
    super.initState();

    _myActivity = '';
    _myActivityResult = '';
  }

  _saveForm() {
    var form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      setState(() {
        _myActivityResult = _myActivity;
      });
    }
  }
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final a_monthbudget = TextEditingController();
  final s_monthbudget = TextEditingController();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final item = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formKey1 = GlobalKey<FormState>();
  String? selecteditem;
  late SingleValueDropDownController _cnt;
  TextEditingController _controller =TextEditingController();
  List<String> items=["JAN", "FEB", "MAR", "APR",
    "MAY", "JUN", "JUL", "AUG", "SEP",
    "OCT", "NOV", "DEC"];

  void getUserData(BuildContext context) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CollectionReference users = firestore.collection('Budget');
    FirebaseAuth auth = FirebaseAuth.instance;
    String uid = auth.currentUser!.uid.toString();
    users.doc(uid).collection(formattedDate).doc(uid).get().then((value) {
      // print("value: ${value['username']}");
      setState(() {
        s_monthbudget.text = value.data()![selecteditem].toString();
      });
    });
    //     .onError((error, stackTrace) {
    //   VxToast.show(context,
    //       msg:'',
    //       // msg: "Error ggg : $error",
    //       // bgColor: Colors.red.shade100,
    //       // textColor: Colors.red.shade500,
    //       // textSize: 14,
    //       position: VxToastPosition.center);
    // });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: AppColor.BodyColor,
        appBar: WidgetHelper.getHeader(
            context,
            buildTranslate(context, "budget"),
            showSearchIcon: false,
            background: false,
            showNotificationIcon: false,
            onAddressClick: (){
              NavigatorHelper.remove();
            }
        ),
        body: ContainedTabBarView(
          tabs: [
            Text(buildTranslate(context, "allMonths"),
              style: Fonts.monthFontBlack,
            ),
            Text(buildTranslate(context, "singleMonths"),
              style: Fonts.monthFontBlack,
            ),
          ],
          tabBarProperties: TabBarProperties(

            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 8.0,
            ),
            indicator: ContainerTabIndicator(

              radius: BorderRadius.circular(12.0),
              color: AppColor.Buttoncolor,
              borderWidth: 2.0,
              borderColor: AppColor.BodyColor,
            ),
            labelColor: AppColor.BodyColor,
            unselectedLabelColor: Colors.grey[400],
          ),
          views: [
          Container(child: containerOne()),
            Container(child: containerTwo()),
          ],
          onChange: (index) => print(index),
        ),
      // body: Column(
      //   key: _formKey,
      //   children: [
      //     SizedBox(
      //       height: 60,// play with height
      //       child: ListView.builder(
      //         itemCount: 2, //number of item you like show
      //         scrollDirection: Axis.horizontal,
      //         itemBuilder: (context, index) {
      //           return Padding(
      //             padding: const EdgeInsets.all(10),
      //             child: InkWell(
      //               borderRadius: BorderRadius.circular(12),
      //               onTap: () {
      //                 setState(() {
      //                   widget._selectedIndex = index;
      //                 });
      //               },
      //               child: Container(
      //                 alignment: Alignment.center,
      //                 height: 100,
      //                 width: 100,
      //                 decoration: BoxDecoration(
      //                   borderRadius: BorderRadius.circular(12),
      //                   color: widget._selectedIndex == index
      //                       ? AppColor.Buttoncolor
      //                       : Colors.grey.shade200,
      //                 ),
      //                 child: Text(
      //                   title[index],
      //                   style: TextStyle(
      //                     color: widget._selectedIndex == index
      //                         ? Colors.white
      //                         : Colors.black,
      //                   ),
      //                 ),
      //               ),
      //             ),
      //           );
      //         },
      //       ),
      //     ),
      //     Container(
      //       child:
      //       (widget._selectedIndex == 0) ? containerOne() : containerTwo(),
      //     ),
      //   ],
      // ),
    ),
    );
  }

  Widget containerOne() => Container(
    child: SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 5.0),
              child: TextFormField(
                controller: a_monthbudget,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                autofocus: false,
                style: Fonts.fieldStyle,
                decoration:  InputDecoration(
                  hintText: buildTranslate(context, "enterAmount"),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: ButtonView(
                buttonTextName: buildTranslate(context, "save"),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Budget(context, a_monthbudget.text,formattedDate);
                    NavigatorHelper.add(BottomBar());
                  }
                },
              ),
            ),
          ],
        ),
      ),//apply padding to some sides only
    ),
  );



  Widget containerTwo() => Container(
    child: SingleChildScrollView(
      child: Form(
        key: _formKey1,
        child: Column(
          children: [
            Container(
              margin:  EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 5.0),
              child:DropdownSearch<String>(
                dropdownDecoratorProps: DropDownDecoratorProps(dropdownSearchDecoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(borderSide:BorderSide(color: Colors.grey),
                  ),
                ),),
                popupProps: PopupProps.menu(
                  showSelectedItems: true,
                  isFilterOnline: true,
                  showSearchBox: true,
                ),
                items: ['JAN',
                  'FEB',
                  'MAR',
                  'APR',
                  'MAY',
                  'JUN',
                  'JUL',
                  'AUG',
                  'SEP',
                  'OCT',
                  'NOV',
                  'DEC'],
                onChanged: (val){
                  selecteditem = val!;
                  getUserData(context);
                },
                selectedItem: buildTranslate(context, "selectMonth"),
              ),

            ),
            Container(
              margin: const EdgeInsets.fromLTRB(20.0, 8.0, 20.0, 5.0),
              child: TextFormField(
                controller: s_monthbudget,
                keyboardType: TextInputType.number,
                textInputAction: TextInputAction.next,
                autofocus: false,
                decoration:  InputDecoration(
                  hintText: buildTranslate(context, "enterAmount"),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              child: ButtonView(
                  buttonTextName: buildTranslate(context, "save"),
                  onPressed: () {
                    if (_formKey1.currentState!.validate()) {
                      singleBudget(
                          context, s_monthbudget.text, selecteditem.toString(), formattedDate);
                      NavigatorHelper.add(BottomBar());
                    }

                  }
              ),

            ),
          ],
        ),
      ),
    ),
  );
}
