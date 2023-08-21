// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:expensemanager/models/week_data.dart';
import 'package:expensemanager/models/year_data.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../localization/AppLocalizations.dart';
import '../../../style/app_color.dart';

class DonateScreen extends StatefulWidget {
  const DonateScreen({Key? key}) : super(key: key);

  @override
  State<DonateScreen> createState() => _DonateScreenState();
}

class _DonateScreenState extends State<DonateScreen> {
  List<charts.Series<dynamic, String>> weeklyList = [];
  List<charts.Series<dynamic, String>> yearlyList = [];

  final ItemScrollController itemScrollControllerOne = ItemScrollController();
  final ItemPositionsListener itemPositionsListenerOne =
      ItemPositionsListener.create();

  int indexOne = weeks.length - 1;

  final ItemScrollController itemScrollControllerTwo = ItemScrollController();
  final ItemPositionsListener itemPositionsListenerTwo =
      ItemPositionsListener.create();

  int indexTwo = years.length - 1;

  static List<charts.Series<WeeklyExpense, String>> _createData() {
    final weeklyData = [
      WeeklyExpense(day: "SUN", expense: 20),
      WeeklyExpense(day: "MON", expense: 42),
      WeeklyExpense(day: "TUE", expense: 25),
      WeeklyExpense(day: "WED", expense: 48),
      WeeklyExpense(day: "THU", expense: 05),
      WeeklyExpense(day: "FRI", expense: 37),
      WeeklyExpense(day: "SAT", expense: 07),
    ];
    final weeklyDataNew = [
      WeeklyExpense(day: "SUN", expense: 50),
      WeeklyExpense(day: "MON", expense: 30),
      WeeklyExpense(day: "TUE", expense: 15),
      WeeklyExpense(day: "WED", expense: 48),
      WeeklyExpense(day: "THU", expense: 45),
      WeeklyExpense(day: "FRI", expense: 10),
      WeeklyExpense(day: "SAT", expense: 19),
    ];

    return [
      charts.Series<WeeklyExpense, String>(
        id: 'Expense',
        domainFn: (WeeklyExpense expense, _) => expense.day!,
        measureFn: (WeeklyExpense expense, _) => expense.expense,
        data: weeklyData,
        fillColorFn: (WeeklyExpense expense, _) =>
            charts.MaterialPalette.blue.shadeDefault,
      ),
      charts.Series<WeeklyExpense, String>(
        id: 'Expense',
        domainFn: (WeeklyExpense expense, _) => expense.day!,
        measureFn: (WeeklyExpense expense, _) => expense.expense,
        data: weeklyDataNew,
        fillColorFn: (WeeklyExpense expense, _) =>
            charts.MaterialPalette.deepOrange.shadeDefault,
      )
    ];
  }

  static List<charts.Series<YearlyExpense, String>> _createNewData() {
    final yearlyData = [
      YearlyExpense(month: "JAN", expense: 19),
      YearlyExpense(month: "FEB", expense: 20),
      YearlyExpense(month: "MAR", expense: 45),
      YearlyExpense(month: "APR", expense: 08),
      YearlyExpense(month: "MAY", expense: 55),
      YearlyExpense(month: "JUN", expense: 60),
      YearlyExpense(month: "JUL", expense: 19),
      YearlyExpense(month: "AUG", expense: 10),
      YearlyExpense(month: "SEP", expense: 12),
      YearlyExpense(month: "OCT", expense: 31),
      YearlyExpense(month: "NOV", expense: 22),
      YearlyExpense(month: "DEC", expense: 05),
    ];
    final yearlyDataNew = [
      YearlyExpense(month: "JAN", expense: 08),
      YearlyExpense(month: "FEB", expense: 60),
      YearlyExpense(month: "MAR", expense: 05),
      YearlyExpense(month: "APR", expense: 34),
      YearlyExpense(month: "MAY", expense: 11),
      YearlyExpense(month: "JUN", expense: 06),
      YearlyExpense(month: "JUL", expense: 42),
      YearlyExpense(month: "AUG", expense: 17),
      YearlyExpense(month: "SEP", expense: 01),
      YearlyExpense(month: "OCT", expense: 14),
      YearlyExpense(month: "NOV", expense: 60),
      YearlyExpense(month: "DEC", expense: 47),
    ];

    return [
      charts.Series<YearlyExpense, String>(
        id: 'Expense',
        domainFn: (YearlyExpense expense, _) => expense.month!,
        measureFn: (YearlyExpense expense, _) => expense.expense,
        data: yearlyData,
        fillColorFn: (YearlyExpense expense, _) =>
            charts.MaterialPalette.blue.shadeDefault,
      ),
      charts.Series<YearlyExpense, String>(
        id: 'Expense',
        domainFn: (YearlyExpense expense, _) => expense.month!,
        measureFn: (YearlyExpense expense, _) => expense.expense,
        data: yearlyDataNew,
        fillColorFn: (YearlyExpense expense, _) =>
            charts.MaterialPalette.deepOrange.shadeDefault,
      )
    ];
  }

  barChartWeek() {
    return charts.BarChart(
      weeklyList,
      animate: true,
      vertical: true,
    );
  }

  barChartYear() {
    return charts.BarChart(
      yearlyList,
      animate: true,
      vertical: true,
    );
  }

  @override
  void initState() {
    weeklyList = _createData();
    yearlyList = _createNewData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.BodyColor,
      appBar: AppBar(
        title: "Report".text.lg.bold.make(),
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColor.BodyColor,
        foregroundColor: AppColor.Black,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_sharp),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(
            top: 20,
            left: 0,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 60,
                width: double.infinity,
                color: Colors.grey.shade300,
                padding: const EdgeInsets.only(top: 20, left: 20),
                margin: const EdgeInsets.only(bottom: 20),
                child:  Text(
                  buildTranslate(context, "weekly"),
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColor.Black
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_sharp,
                    ),
                    color: AppColor.Black,
                    onPressed: () {
                      setState(() {
                        print(indexOne);
                        if (indexOne > 0) {
                          indexOne--;
                        }
                        itemScrollControllerOne.scrollTo(
                            index: indexOne,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOutCubic);
                      });
                    },
                  ),
                  SizedBox(
                    height: 40,
                    width: 200,
                    child: ScrollablePositionedList.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: weeks.length,
                      initialScrollIndex: weeks.length - 1,
                      itemBuilder: (context, index) => SizedBox(
                        height: 40,
                        width: 200,
                        child: Center(
                          child: Text(
                            weeks[index].toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      itemScrollController: itemScrollControllerOne,
                      itemPositionsListener: itemPositionsListenerOne,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_forward_ios_sharp,
                    ),
                    color: AppColor.Black,
                    onPressed: () {
                      setState(() {
                        print(indexOne);
                        if (indexOne < weeks.length - 1) {
                          indexOne++;
                        }
                        itemScrollControllerOne.scrollTo(
                            index: indexOne,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOutCubic);
                      });
                    },
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  height: 290,
                  width: MediaQuery.of(context).size.width + 100,
                  padding: const EdgeInsets.all(20),
                  child: barChartWeek(),
                ),
              ),
              Container(
                height: 60,
                width: double.infinity,
                color: Colors.grey.shade300,
                padding: const EdgeInsets.only(top: 20, left: 20),
                margin: const EdgeInsets.only(bottom: 20),
                child:  Text(
                  buildTranslate(context, "yearly"),
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColor.Black,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_sharp,
                    ),
                    color: AppColor.Black,
                    onPressed: () {
                      setState(() {
                        print(indexTwo);
                        if (indexTwo > 0) {
                          indexTwo--;
                        }
                        itemScrollControllerTwo.scrollTo(
                            index: indexTwo,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOutCubic);
                      });
                    },
                  ),
                  SizedBox(
                    height: 40,
                    width: 200,
                    child: ScrollablePositionedList.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: years.length,
                      initialScrollIndex: years.length - 1,
                      itemBuilder: (context, index) => SizedBox(
                        height: 40,
                        width: 200,
                        child: Center(
                          child: Text(
                            years[index].toString(),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      itemScrollController: itemScrollControllerTwo,
                      itemPositionsListener: itemPositionsListenerTwo,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_forward_ios_sharp,
                    ),
                    color: AppColor.Black,
                    onPressed: () {
                      setState(() {
                        print(indexTwo);
                        if (indexTwo < years.length - 1) {
                          indexTwo++;
                        }
                        itemScrollControllerTwo.scrollTo(
                            index: indexTwo,
                            duration: const Duration(milliseconds: 400),
                            curve: Curves.easeInOutCubic);
                      });
                    },
                  ),
                ],
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                  height: 290,
                  width: MediaQuery.of(context).size.width + 400,
                  padding: const EdgeInsets.all(20),
                  child: barChartYear(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WeeklyExpense {
  final String? day;
  final int? expense;
  WeeklyExpense({
     this.day,
     this.expense,
  });
}

class YearlyExpense {
  final String? month;
  final int? expense;
  YearlyExpense({
     this.month,
     this.expense,
  });
}
