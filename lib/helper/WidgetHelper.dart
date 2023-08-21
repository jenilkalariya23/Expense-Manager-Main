
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

import '../custom/home_widget/widget_navigation_drawer.dart';
import '../localization/AppLocalizations.dart';
import '../mvc/view/auth/changepassword.dart';
import '../mvc/view/home/Calender Search.dart';
import '../mvc/view/home/screen_filter.dart';
import '../mvc/view/home/search.dart';
import '../mvc/view/profile/update_profile.dart';
import '../style/app_color.dart';
import '../style/fonts.dart';
import 'assets_helper.dart';
import 'dialog_helper.dart';
import 'navigator_helper.dart';

class WidgetHelper {

  static Widget getFieldSeparator({double? height}) {
    return SizedBox(
      height: height??15,
    );
  }
  static Widget getLogoSeparator({double? height}) {
    return SizedBox(
      height: height??40,
    );
  }
  static Widget getDividerSeparator({double? height}) {
    return SizedBox(
      height: height??10,
    );
  }

  static Widget getIndicator(String str,Color color){
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(width: 5,),
        Container(
          height: 10,
          width: 10,
          color:color,
        ),
        SizedBox(width: 5,),
        Text(str),
      ],
    );
  }

  static Widget getDivider({double? width}) {
    return Container(
      height: 1,
      width: width ?? 30,
      decoration: BoxDecoration(
        color: AppColor.Buttoncolor,
      ),
    );
  }

  static AppBar getHeader(
      BuildContext context,
      String title, {
        bool showBackIcon=false,
        bool showSearchIcon=true,
        bool showSearch=false,
        bool showNotificationIcon=true,
        bool showWallet=false,
        bool showMenu=false,
        bool showNotificationMenu=false,
        bool showRadius=true,
        bool showElevation=false,
        Function? onRemoveAllClick,
        Function? onReadAllClick,
        Function? onAddressClick,
        Function? onMenuClick,
        bool showAddIcon=false,
        bool showEditIcon=false,
        bool showCalenderIcon=false,
        bool showFilterIcon=false,
        bool centerTitle=true,
        bool showEditProfile=true,
        bool background=true,
        bool background1=true,
      }
      )
  {

    return AppBar(
      title: FittedBox(
          child: Row(
            children: [
              Builder(
                  builder: (context){
                    return InkWell(
                      onTap: (){
                        onMenuClick!(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        // child: !showBackIcon?Icon(Icons.menu_rounded, size: 30,color: Colors.black,):null
                      ),
                    );}
              ),
              SizedBox(width: showBackIcon?5:15,),
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: background?Text(
                  title,
                  style: Fonts.appbarFontWhite,
                ):Text(
                  title,
                  style: Fonts.appbarFontBlack,
                ),
              ),

            ],
          )
      ),

      titleSpacing: showBackIcon?0:5,
      backgroundColor: background?AppColor.Buttoncolor:Colors.white,
      leading: showBackIcon?GestureDetector(
        child:Padding(
            padding: const EdgeInsets.all(15),
            child: Icon(Icons.arrow_back,color:background?Colors.white:Colors.black)
        ),
        onTap: () {
          NavigatorHelper.remove(value: true);
        },
      ):null,
      //leading: null,
      automaticallyImplyLeading: false,
      elevation: showElevation?2:0,

      actions: <Widget>[
        !showBackIcon?
        Visibility(
          visible: showSearchIcon,
          child: GestureDetector(
            onTap: (){
              NavigatorHelper.add(Search());
            },
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  "assets/Icons/Search.png",
                  color: AppColor.Black,
                  height: 22,
                  width: 20,
                )
            ),
          ),
        ):Container(),
        Visibility(
          visible: showCalenderIcon,
          child: GestureDetector(
            onTap: (){
              NavigatorHelper.add(calendersearch());
            },
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  "assets/Icons/Calender.png",
                  color: AppColor.Black,
                  height: 22,
                  width: 20,
                )
            ),
          ),
        ),
        Visibility(
          visible: showFilterIcon,
          child: GestureDetector(
            onTap: (){
              NavigatorHelper.add(FilterHomeRedirectWidget(CallBack: (){},));
            },
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  "assets/Icons/filter.png",
                  color: AppColor.Black,
                  height: 22,
                  width: 20,
                )
            ),
          ),
        ),
        Visibility(
          visible: showEditIcon,
          child: GestureDetector(
            onTap: (){
              NavigatorHelper.add(UpdateScreen());
            },
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(Icons.edit)
            ),
          ),
        ),
        Visibility(
          visible: showAddIcon,
          child: GestureDetector(
            onTap: (){
              NavigatorHelper.add(DialogHelper.showConfirmDialog(context,  buildTranslate(context, "addCategory"), () {
              }),);
            },
            child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(Icons.add, color: AppColor.Black)
            ),
          ),
        ),
      ],
      centerTitle: true,
    );

  }
}