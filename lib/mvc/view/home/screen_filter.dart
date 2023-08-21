import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expensemanager/style/app_color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../helper/WidgetHelper.dart';
import '../../../helper/button_view.dart';
import '../../../helper/navigator_helper.dart';
import '../../../localization/AppLocalizations.dart';

class FilterHomeRedirectWidget extends StatefulWidget {
  Function CallBack;
  FilterHomeRedirectWidget({Key? key,required this.CallBack}) : super(key: key);

  @override
  _FilterHomeRedirectWidgetState createState() => _FilterHomeRedirectWidgetState();
}

class _FilterHomeRedirectWidgetState extends State<FilterHomeRedirectWidget> {

  List<String> arr = <String>[];
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    double w2 = (w <= 390) ? 83 : 100;
    return Scaffold(
        backgroundColor: AppColor.BodyColor,
        appBar: WidgetHelper.getHeader(
            context,
            buildTranslate(context, "filters"),
            showSearchIcon: false,
            showBackIcon: true,
            background: false,
            showNotificationIcon: false,
            onAddressClick: (){
              NavigatorHelper.remove();
            }
        ),
        body: Column(
          children: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('categories').where('uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                  .snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                      child: CircularProgressIndicator()
                  );
                }
                return Wrap( children: snapshot.data!.docs.map((user) {
                  bool isSelected = false;
                  if (arr.contains(user.get('categoryName'))) {
                    isSelected = true;
                  }
                  return GestureDetector(
                    onTap: () {

                      setState((){
                        if(isSelected){
                          arr.remove(user.get('categoryName'));
                          isSelected = false;
                        }
                        else{
                          arr.add(user.get('categoryName'));
                          isSelected = true;
                        }
                      });

                      // if (!arr!.contains(user['category'])) {
                      //     arr!.add(user['category']);
                      //     print(arr);
                      //
                      // } else {
                      //   arr!
                      //       .removeWhere((element) => element == user['category']);
                      //   print(arr);
                      //   widget.CallBack(arr);
                      // }
                    },
                    child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5, vertical: 9),
                        child: Container(

                          padding: EdgeInsets.symmetric(
                              vertical: 8, horizontal: 12),
                          decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColor.Buttoncolor
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                  color: AppColor.Buttoncolor.
                                  withOpacity(0.3),
                                  width: 2)
                          ),
                          child: Text(
                            user['categoryName'],
                            style: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 14),
                          ),
                        )
                    ),

                  );
                },
                ).toList(),
                );
              },
            ),
            SizedBox(height: 25,),
            Center(
              child: ButtonView(
                buttonTextName: buildTranslate(context, "apply"),
                onPressed: () => {
                  widget.CallBack(arr),
                  // print(arr),
                  Navigator.of(context).pop()
                  // Navigator.of(context).push(
                  //      MaterialPageRoute(
                  //      builder: (context) => Dashboard(),
                  //      settings: RouteSettings(
                  //      arguments: widget.CallBack(arr),
                  //     )),
                },
              ),
            ),
          ],
        )
    );
  }
}
// 7/25/  28%