import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../localization/AppLocalizations.dart';
import '../style/app_color.dart';

class MultiImageBottomSheet extends StatefulWidget {
  const MultiImageBottomSheet({Key? key, this.callBack, this.name})
      : super(key: key);

  @override
  MultiImageBottomSheetState createState() => MultiImageBottomSheetState();
  final Function? callBack;
  final String? name;

}

class MultiImageBottomSheetState extends State<MultiImageBottomSheet> {

  TextStyle titleStyle = const TextStyle(
      fontFamily: 'AppMPRegular',
      fontSize: 16.0,
      color: Colors.indigo);

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
              decoration:  BoxDecoration(
                  color: AppColor.BodyColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0))),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    buildTranslate(context, "uploadImage")!,

                  ),
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
                                Icons.camera_alt,
                                color:  Colors.indigo,
                              ),
                            ),
                            Positioned.fill(
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(buildTranslate(context, "takeAPhoto")!,
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
                                    buildTranslate(context, "selectAnImage")!,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
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
                                child: Text(buildTranslate(context, "cancel")!,
                                   ),
                              ),
                            ),
                          ],
                        ),
                        onPressed: () {
                          Navigator.pop(context);
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
    List<XFile> images = [];
    if (index == 0) {
     images = (await ImagePicker().pickMultiImage())!;
      // xFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    } else {
      xFile = await ImagePicker().pickImage(source: ImageSource.camera);
    }

    setState(() {
      if (xFile != null) {
        //print("Picked File = " + xFile.path);
        imageFiles.add(File(xFile.path));
        widget.callBack!(imageFiles);

        Navigator.pop(context);

      } else if(images.isNotEmpty){
        for (int i = 0; i < images.length; i++) {
          imageFiles.add(File(images[i].path));
        }

        if (imageFiles.isNotEmpty) {
          widget.callBack!(imageFiles);

          Navigator.pop(context);

        }
      }
      //print("Picked File = null");
    });
  }

}