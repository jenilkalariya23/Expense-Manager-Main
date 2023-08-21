// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_print
import 'package:expensemanager/style/app_color.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:velocity_x/velocity_x.dart';

// ignore: must_be_immutable
class RowContainerCal extends StatefulWidget {
  int? selectedIndex=1;
  Function callBack;

  RowContainerCal({
    Key? key,
    required this.selectedIndex,
    required this.callBack,
  }) : super(key: key);

  @override
  State<RowContainerCal> createState() => _RowContainerCalState();
}

class _RowContainerCalState extends State<RowContainerCal> {
  final months = [
    'JAN',
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
    'DEC'
  ];
  final month = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];
  int index = 0;


  final ItemScrollController itemScrollController = ItemScrollController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    double paddingTop = (h > 750) ? 16: 0;

    return SingleChildScrollView(
      child: Container(
        child: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_sharp,
              ),
              color: AppColor.Black,
              onPressed: () {
                setState(() {
                  widget.selectedIndex = index ;
                  if (index > 0) {
                    index--;
                  }
                  itemScrollController.scrollTo(
                      index: index,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOutCubic);
                });
                widget.callBack(months[index],month[index],index);
              },
            ),
            SizedBox(
              height: h / 11,
              width: w - 100, // play with height
              child: ScrollablePositionedList.builder(
                  scrollDirection: Axis.horizontal,
                  // physics: const NeverScrollableScrollPhysics(),
                  itemCount: months.length,
                  itemScrollController: itemScrollController,
                  itemPositionsListener: itemPositionsListener,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 8.0, right: 4.0),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () {
                          setState(() {
                            widget.selectedIndex == index;
                          });
                          widget.callBack(months[index],month[index],index);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: w * 0.2,
                          height: h * 0.075,
                          // padding: EdgeInsets.only(top: paddingTop),
                          decoration: BoxDecoration(
                            border:
                            Border.all(width: 1, color: Colors.grey.shade300),
                            borderRadius: const BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: (widget.selectedIndex == index)
                                ? AppColor.Buttoncolor
                                : Colors.white,
                          ),
                          child: Container(
                            // margin: const EdgeInsets.only(bottom: 8),
                            child: months[index]
                                .text
                                .center
                                .color((widget.selectedIndex == index)
                                ? Colors.white
                                : Colors.black)
                                .bold
                                .make(),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            IconButton(
              icon: const Icon(
                Icons.arrow_forward_ios_sharp,
              ),
              color: AppColor.Black,
              onPressed: () {
                setState(() {
                  if (index < 11) {
                    widget.selectedIndex = index;
                    index++;
                  }
                  if (index == 11) {
                    widget.selectedIndex = 10;
                  }
                  if (index == 11) {
                    widget.selectedIndex = 11;
                  }
                  itemScrollController.scrollTo(
                      index: index,
                      duration: const Duration(milliseconds: 400),
                      curve: Curves.easeInOutCubic);
                });
                widget.callBack(months[index],month[index],index);
              },
            ),
      ]
        ),
      ),
    );
  }
}
