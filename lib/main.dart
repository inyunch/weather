
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/pages/mine/mine.dart';
import 'package:weather/tools/common.dart';


void main() =>  runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => new MyAppState();
}

class MyAppState extends State<MyApp> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('main build');
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: ScreenUtilInit(
            designSize: Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: () => MaterialApp(
                  navigatorKey: Router1.navigatorKey,
                  debugShowCheckedModeBanner: false,
                  theme: new ThemeData(
                    backgroundColor: Color(0xffF79226),
                  ),
                  home: MinePage(),
                )));
  }
}
