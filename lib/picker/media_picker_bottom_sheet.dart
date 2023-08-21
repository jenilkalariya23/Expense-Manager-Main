import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../style/app_color.dart';


class MediaPickerBottomSheet extends StatefulWidget {

  @override
  MediaPickerBottomSheetState createState() => MediaPickerBottomSheetState();

  final Function? callBack;
  final String? name;

  const MediaPickerBottomSheet({Key? key, this.callBack, this.name}) : super(key: key);
}

class MediaPickerBottomSheetState extends State<MediaPickerBottomSheet> {
  TextStyle textStyle = const TextStyle(
      fontFamily: 'AppSemiBold',
      fontSize: 16.0,
      color: Colors.indigo,
  );

  List<File> imageFiles = [];

  bool isTips = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Wrap(
      children: [
        Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                  color:Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0))),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Text(
                  //   buildTranslate(context, "uploadImage"),
                  //   style: textStyle,
                  // ),
                  // SizedBox(
                  //   height: 20,
                  // ),
                  SizedBox(
                      width: double.infinity,
                      child: MaterialButton(
                        elevation: 0,
                        // color: AppColor.appColor,
                        padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                        splashColor: Colors.indigo,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side:
                          const BorderSide(color:  Colors.indigo),
                        ),
                        child: Stack(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Icon(
                                Icons.camera_alt,
                                color:  Colors.indigo,
                              ),
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                    "dhaidha",
                                    style: textStyle
                                ),
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          pickImage(1);
                          // _showCamera();
                        },
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: MaterialButton(
                        elevation: 0,
                        // color: AppColor.appColor,
                        padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                        splashColor:  Colors.indigo,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side:
                          const BorderSide(color:  Colors.indigo),
                        ),
                        child: Stack(
                          children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Icon(
                                Icons.image,
                                color:  Colors.indigo,
                              ),
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "dhaidha",
                                    style: textStyle
                                ),
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          //Navigator.pop(context);
                          //widget.callback(widget.indexMy,tmp.length>0?true:false);
                          pickImage(0);
                          // loadAssets();
                        },
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: MaterialButton(
                        elevation: 0,
                        color:  Colors.indigo,
                        padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
                        splashColor:  Colors.indigo,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side:
                          const BorderSide(color:  Colors.indigo),
                        ),
                        child: Stack(
                          children: [
                             Align(
                              alignment: Alignment.centerLeft,
                              child: Icon(
                                Icons.cancel,
                                color: AppColor.BodyColor,
                              ),
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                    "dhaidha",
                                    style: textStyle
                                ),
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          //widget.callback(widget.indexMy,tmp.length>0?true:false);
                        },
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Future pickImage(int index) async {
    XFile? xFile;
    if (index == 0) {
      xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    } else {
      xFile = await ImagePicker().pickImage(source: ImageSource.camera);
    }

    setState(() {
      if (xFile != null) {
        //print("Picked File = " + xFile.path);
        Navigator.pop(context);
        widget.callBack!(File(xFile.path));
        // cropImage(File(pickedFile.path));
      } else {
        //print("Picked File = null");
      }
    });
  }

  // cropImage(File imageFile) async {
  //   File croppedFile = await ImageCropper.cropImage(
  //       sourcePath: imageFile.path,
  //       aspectRatioPresets: [q
  //         CropAspectRatioPreset.square,
  //         CropAspectRatioPreset.ratio3x2,
  //         CropAspectRatioPreset.original,
  //         CropAspectRatioPreset.ratio4x3,
  //         CropAspectRatioPreset.ratio16x9
  //       ],
  //       androidUiSettings: AndroidUiSettings(
  //           toolbarTitle: 'Cropper',
  //           toolbarColor: AppColor.appColor,
  //           toolbarWidgetColor: Colors.white,
  //           statusBarColor: AppColor.appColor,
  //           initAspectRatio: CropAspectRatioPreset.original,
  //           lockAspectRatio: false),
  //       iosUiSettings: IOSUiSettings(
  //         minimumAspectRatio: 1.0,
  //       ));
  //
  //   if (croppedFile != null) {
  //     Navigator.pop(context);
  //     widget.callBack(croppedFile);
  //   }
  // }
}
