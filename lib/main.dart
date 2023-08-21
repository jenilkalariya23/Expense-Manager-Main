import 'package:expensemanager/auth/auth_controller.dart';
import 'package:expensemanager/localization/AppLocalizations.dart';
import 'package:expensemanager/mvc/model/category/category_notifier.dart';
import 'package:expensemanager/mvc/view/splash_screen/splash_screen.dart';
import 'package:expensemanager/utils/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp().then((value) {
    Get.put(AuthController());
  });

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => CategoryNotifier(),
      )
    ],
    child:  const MyApp(),
  ));
}
class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        dividerColor: Colors.transparent,
      ),
      debugShowCheckedModeBanner: false,
      home:  Splashscreen(),
      navigatorKey: navigatorKey,
      localizationsDelegates: const [
        MyLocalizationsDelegate(),
      ],
      supportedLocales: const [
        Locale("en"),
      ],
    );
  }
}

