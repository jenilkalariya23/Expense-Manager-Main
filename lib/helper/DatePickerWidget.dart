// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: depend_on_referenced_packages

import 'package:expensemanager/mvc/view/budget/setBudget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../style/app_color.dart';

class DatePickerWidget extends StatefulWidget {
  final BuildContext? context;
  Function Callback;
  DatePickerWidget({
    Key? key,
    this.context,
    required this.Callback,
  }) : super(key: key);

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  // ignore: prefer_final_fields
  DateTime _date = DateTime.now();
  final DateFormat _dateTime = DateFormat('yyyy-MM-dd');
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  var Datepikcker =  DateFormat('yyyy-MM-dd').format(now);
  DateTime selectedDate = DateTime.now();

  String formattedDate1="";
  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.fromLTRB(15.0, 8.0, 10.0, 0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: AppColor.Buttoncolor, // background// foreground
        ),
        onPressed: () async {
          // DateTime? pickedDate = await showDatePicker(
          //     context: context,
          //     initialDate: DateTime.now(),
          //     firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
          //     lastDate: DateTime(2101)
          // );
          //
          // if(pickedDate != null ){
          //
          //   String formattedDate1 = DateFormat('yyyy-MM-dd').format(pickedDate);
          //   demoo=formattedDate1;
          //   print(demoo);
          //   setState(() {
          //     _date= pickedDate;
          //     widget.Callback(demoo);
          //   });
          // }else{
          //   print("Date is not selected");
          // }
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: selectedDate, // Refer step 1
            firstDate: DateTime(2000),
            lastDate: DateTime(2025),
          );
          if (picked != null && picked != selectedDate)
            formattedDate1 = DateFormat('yyyy-MM-dd').format(picked);
          Datepikcker= formattedDate1;
          setState(() {
            selectedDate = picked!;
            _date= picked;
            widget.Callback(formattedDate1);
          });

        },
        child: Wrap(
          children: <Widget>[
             Icon(
              Icons.date_range,
              color :AppColor.BodyColor,
              size: 24.0,
            ),
            const SizedBox(
              width:10,
            ),
            Text(formatter.format(_date).toString(),
                style: const TextStyle(
                  height: 1.5,
                )),
          ],
        ),
      ),
    );
  }
}


class DatePickerWidget1 extends StatefulWidget {
  final BuildContext? contex;
  Function Callback;
  DatePickerWidget1({
    Key? key,
    this.contex,
    required this.Callback,
  }) : super(key: key);

  @override
  State<DatePickerWidget1> createState() => _DatePickerWidget1State();
}

class _DatePickerWidget1State extends State<DatePickerWidget1> {
  // ignore: prefer_final_fields
  DateTime _date1 = DateTime.now();
  final DateFormat _dateTime = DateFormat('yyyy-MM-dd');
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  var Datepikcker =  DateFormat('yyyy-MM-dd').format(now);
  DateTime selectedDate = DateTime.now();
  String formattedDate1="";

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: const EdgeInsets.fromLTRB(15.0, 8.0, 10.0, 0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary:  AppColor.Buttoncolor, // background// foreground
        ),
        onPressed: () async {
          // DateTime? pickedDate = await showDatePicker(
          //     context: context,
          //     initialDate: DateTime.now(),
          //     firstDate: DateTime(2000), //DateTime.now() - not to allow to choose before today.
          //     lastDate: DateTime(2101)
          // );
          //
          // if(pickedDate != null && pickedDate != ){
          //   String formattedDate1 = DateFormat('yyyy-MM-dd').format(pickedDate);
          //
          //   demoo=formattedDate1;
          //   print(demoo);
          //
          //   setState(() {
          //
          //     _date1= pickedDate;
          //     widget.Callback(demoo);
          //
          //   });
          // }else{
          //   print("Date is not selected");
          // }
          final DateTime? picked = await showDatePicker(
            context: context,
            initialDate: selectedDate, // Refer step 1
            firstDate: DateTime(2000),
            lastDate: DateTime(2025),
          );
          if (picked != null && picked != selectedDate)
            formattedDate1 = DateFormat('yyyy-MM-dd').format(picked);
          Datepikcker= formattedDate1;
          setState(() {
            selectedDate = picked!;
            _date1= picked;
            widget.Callback(Datepikcker);
          });
        },
        child: Wrap(
          children: <Widget>[
             Icon(
              Icons.date_range,
              color: AppColor.BodyColor,
              size: 24.0,
            ),
            const SizedBox(
              width:10,
            ),
            Text(formatter.format(_date1).toString(),
                style: const TextStyle(
                  height: 1.5,
                )),
          ],
        ),
      ),
    );
  }
}