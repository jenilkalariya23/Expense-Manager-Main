
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:expensemanager/style/fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:get/get.dart';
import '../../../auth/user_data.dart';
import '../../../helper/ValidationHelper.dart';
import '../../../helper/WidgetHelper.dart';
import '../../../helper/button_view.dart';
import 'package:intl/intl.dart';
import '../../../helper/navigator_helper.dart';
import '../../../localization/AppLocalizations.dart';
import '../../../style/app_color.dart';
import '../bottom_navigation/bottom_navigation.dart';
FirebaseFirestore firestore = FirebaseFirestore.instance;
final CollectionReference users = firestore.collection('Expense');
FirebaseAuth auth = FirebaseAuth.instance;
String uid = auth.currentUser!.uid.toString();
var now = new DateTime.now();
var formatter = new DateFormat("MMMM");
var formatteryear = new DateFormat('yyyy');
String Year = formatteryear.format(now);
int timestamp = DateTime.now().millisecondsSinceEpoch;
var FullDate = new DateTime.fromMicrosecondsSinceEpoch(timestamp * 1000);

class addexpense extends StatefulWidget {
  const addexpense({Key? key}) : super(key: key);

  @override
  State<addexpense> createState() => _addexpenseState();
}

class _addexpenseState extends State<addexpense> {
  final _formKey = GlobalKey<FormState>();

  final Title = TextEditingController();
  final Description = TextEditingController();
  final Date = TextEditingController();
  final imagestring = TextEditingController();
  final Amount = TextEditingController();

  final format = DateFormat("yyyy-MM-dd");
  final format1 = DateFormat("MMMM");

  String Month = formatter.format(now);
  final Time = DateFormat('hh:mm:ss').format(now);
  int? PaymentType = 1;
  String? _radioVal;
  String? _myActivity;
  String? Category;
  String? _myActivityResult;
  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
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
  String? category;
  List months =
  ['jan', 'feb', 'mar', 'apr', 'may','jun','jul','aug','sep','oct','nov','dec'];

  var current_mon = now.month;
  String abc="";
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: WidgetHelper.getHeader(
            context,
            buildTranslate(context, "addExpense"),
            showSearchIcon: false,
            background: false,
            showNotificationIcon: false,
            onAddressClick: (){
              NavigatorHelper.remove();
            }
        ),
        backgroundColor: AppColor.BodyColor,
        body: Form(
          key: _formKey,
          child: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              Container(
                  margin: EdgeInsets.fromLTRB(30.0, 8.0, 30.0, 2),
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('categories').where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(),
                      builder: (context, snapshot){
                        if (!snapshot.hasData) {
                          return const Center(
                          child:  CupertinoActivityIndicator(),
                        );
                        }
                        var length = snapshot.data!.docs.length;
                        DocumentSnapshot ds = snapshot.data!.docs[length - 1];
                        // Category = snapshot.data!.docs as String?;
                        return  Container(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          // width: screenSize.width*0.9,
                          child:  Row(
                            children: <Widget>[

                              Expanded(
                                flex: 4,
                                child: DropdownSearch<String>(
                                  dropdownDecoratorProps: DropDownDecoratorProps(dropdownSearchDecoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(borderSide:BorderSide(color: Colors.grey),
                                    ),
                                  ),),
                                  popupProps: PopupProps.menu(
                                    showSelectedItems: true,
                                    isFilterOnline: true,
                                    showSearchBox: true,
                                  ),
                                  items: snapshot.data!.docs.map((DocumentSnapshot document) {
                                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                                    return data['categoryName'];
                                  }).toList().cast<String>(),
                                  selectedItem: buildTranslate(context, "chooseanCategory"),
                                  // popupItemDisabled: (String s) => s.startsWith('I'),
                                  onChanged: (val){
                                    category = val;
                                    print("jenil");
                                    print(category);

                                    // selecteditem = val!;
                                    // getUserData(context);
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                  )
              ),
              Padding(
                padding:  EdgeInsets.only(left:30, bottom: 0, right: 20, top:18), //apply padding to some sides only
                child: Text(
                  buildTranslate(context, "title"),
                  style: Fonts.Textform,
                ),
              ),
              Container(
                margin:  EdgeInsets.fromLTRB(30.0, 8.0, 30.0, 5.0),
                child: TextFormField(
                  style: Fonts.fieldStyle,
                  decoration:  InputDecoration(
                    hintText: buildTranslate(context, "title"),
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  controller: Title,
                  inputFormatters: [LengthLimitingTextInputFormatter(100)],
                  validator: (value) => ValidationHelper.checkBlankValidation(context, value!, "nameValidation"),
                ),
              ),
              Padding(
                padding:  EdgeInsets.only(left:30, bottom: 0, right: 20, top:15), //apply padding to some sides only
                child: Text(
                  buildTranslate(context, "description"),
                    style: Fonts.Textform,
                )
              ),
              Container(
                margin:  EdgeInsets.fromLTRB(30.0, 8.0, 30.0, 5.0),
                child: TextFormField(
                  style: Fonts.fieldStyle,
                  decoration:  InputDecoration(
                    hintText: buildTranslate(context, "description"),
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  controller: Description,
                  inputFormatters: [LengthLimitingTextInputFormatter(100)],
                  validator: (value) => ValidationHelper.checkBlankValidation(context, value!, "nameValidation"),
                ),
              ),
              // Container(
              //   margin:  EdgeInsets.fromLTRB(30.0, 8.0, 30.0, 2),
              //   child: TextFormField(
              //     textInputAction: TextInputAction.next,
              //     controller: Description,
              //     autofocus: false,
              //     textCapitalization: TextCapitalization.sentences,
              //     decoration: const InputDecoration(
              //       hintText: "Pay for Cheese Burger at McDonalds",
              //       errorStyle:
              //       TextStyle(color: Colors.redAccent, fontSize: 15),
              //     ),
              //     validator: (value) {
              //       if (value == null || value.isEmpty) {
              //         return 'Required';
              //       }
              //       return null;
              //     },
              //   ),
              // ),
              Padding(
                padding:  EdgeInsets.only(left:30, bottom: 0, right: 20, top:15), //apply padding to some sides only
                child: Text(
                  buildTranslate(context, "amount"),
                  style: Fonts.Textform,
                ),
              ),
              Container(
                margin:  EdgeInsets.fromLTRB(30.0, 8.0, 30.0, 1),
                child: TextFormField(
                  style: Fonts.fieldStyle,
                  decoration:  InputDecoration(
                    hintText: buildTranslate(context, "amount"),
                  ),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.number,
                  textCapitalization: TextCapitalization.words,
                  controller: Amount,
                  validator: (value) => ValidationHelper.checkMobileNoValidation(context, value!),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:30, bottom: 0, right: 20, top:15), //apply padding to some sides only
                child: Text(
                  buildTranslate(context, "paymentMode"),
                  style: Fonts.Textform,),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left:30, bottom: 0, right: 20, top:1), //
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(buildTranslate(context, "gpay")),
                          Radio(
                            value: 1,
                            groupValue: PaymentType,
                            activeColor: AppColor.Buttoncolor,
                            onChanged: (value) {
                              setState(() {
                                PaymentType = value as int?;
                                _radioVal = '';
                              });
                            },
                          ),
                          Text(buildTranslate(context, "cash")),
                          Radio(
                            value: 2,
                            groupValue: PaymentType,
                            activeColor: AppColor.Buttoncolor,
                            onChanged: (value) {
                              setState(() {
                                PaymentType = value as int?;
                                _radioVal = '';
                              });
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              Padding(
                padding: EdgeInsets.only(left:30, bottom: 0, right: 20, top:15), //apply padding to some sides only
                child: Text(
                  buildTranslate(context, "date"),
                  style: Fonts.Textform,
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(30.0, 8.0, 30.0, 1),
                child:   DateTimeField(
                  format: format,
                  controller: Date,
                  onShowPicker: (context, currentValue) {
                    // print(currentValue);
                    // print(DateFormat('MMM').format(currentValue!));
                    // DateFormat format =  DateFormat("MMM");
                    // print(format.parse(Date.toString()));
                    return showDatePicker(
                        context: context,
                        firstDate: DateTime(1900),
                        initialDate: currentValue ?? DateTime.now(),
                        lastDate: DateTime(2100));
                  },
                  validator: (value) {
                    if (value == null || value.isNull) {
                      return 'Required';
                    }
                    return null;
                  },
                ),
              ),
              Container(
                margin: new EdgeInsets.symmetric(horizontal: 120.0,vertical: 50),
                child: ButtonView(
                  buttonTextName: buildTranslate(context, "save"),
                  onPressed: (){
                    if (_formKey.currentState!.validate()) {
                      final formattedDate = DateFormat('MMM').format(format.parse(Date.text));
                      print(formattedDate);
                      // //
                      // //   abc= formattedDate;
                      // //   print(abc);
                      // final  format = new DateFormat("MM");
                      // final def = DateFormat('MMM').format(format.parse(Date.text));
                      // print(def);
                      print(Category);
                      expense(context,Title.text,
                          Description.text,
                          category.toString(),
                          // categoryID.toString(),
                          Date.text,
                          PaymentType.toString(),
                          formattedDate.toString(),
                          Year,
                          FullDate,
                          Time,
                          int.parse(Amount.text));
                      NavigatorHelper.remove();
                    }
                    // final formattedDate = DateFormat('MMM').format(format.parse(Date.text));
                    // print(formattedDate);
                    // //
                    // //   abc= formattedDate;
                    // //   print(abc);
                    // final  format = new DateFormat("MM");
                    // final def = DateFormat('MMM').format(format.parse(Date.text));
                    // print(def);
                    // expense(context,Title.text,
                    //     Description.text,
                    //     Category.toString(),
                    //     Date.text,
                    //     PaymentType.toString(),
                    //     formattedDate.toString(),
                    //     Year,
                    //     FullDate,
                    //     Time,
                    //     int.parse(Amount.text));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
