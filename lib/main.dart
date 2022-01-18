import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sejun_purpledog/enums/purpledog_category_enum.dart';
import 'package:sejun_purpledog/page/home_page.dart';

void main() {
  runApp(const MyApp());

  print(PurpledogCategory.askstories.toString() == 'askstories');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      home: HomePage(),
    );
  }
}
