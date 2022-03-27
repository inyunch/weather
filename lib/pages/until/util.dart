
import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather/component/widget/common_bg.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'dart:io';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:convert' as convert;

/*
 * @description: 清除Timeout計時器
 * @param {int} timer
 */
void clearTimeout(Timer timer) {
  try {
    timer.cancel();
  } catch (e) {}
}

/*
 * @description: setTimeout計時器
 * @param {VoidCallback} fn 執行函式
 * @param {int} millis 時間ms
 */
Timer setTimeout(VoidCallback fn, int millis) {
  Timer timer;
  if (millis > 0)
    timer = new Timer(new Duration(milliseconds: millis), fn);
  else
    fn();
  return timer;
}

/*
 * @description: 情除Interval計時器
 * @param {int} timer
 */
void clearInterval(Timer timer) {
  try {
    timer.cancel();
  } catch (e) {}
}

/*
 * @description:setInterval計時器
 * @param {VoidCallback} fn 執行函式
 * @param {int} millis 時間ms
 */
Timer setInterval(VoidCallback fn, int millis) {
  Timer timer;
  if (millis > 0)
    timer = new Timer.periodic(new Duration(milliseconds: millis), (timer) {
      fn();
    });
  else
    fn();
  return timer;
}

/*
 * @description: 顏色轉換
 * @param {String} hexColor
 * @return: Color
 */
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

void jumpPage(BuildContext context, String methodName, Widget nextPage,
    {Map data, Function fn}) {
  Route _createRoute(Tween<Offset> tween) {
    return PageRouteBuilder(
        transitionDuration: Duration(milliseconds: 100),
        settings: new RouteSettings(
          name: '$nextPage',
        ),
        pageBuilder: (context, animation, secondaryAnimation) => nextPage,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return SlideTransition(
            position:
                animation.drive(tween.chain(CurveTween(curve: Curves.ease))),
            child: child,
          );
        });
  }

  final Tween<Offset> rightin =
      Tween(begin: Offset(1.0, 0.0), end: Offset.zero);
  final Tween<Offset> leftin =
      Tween(begin: Offset(-1.0, 0.0), end: Offset.zero);
  final Tween<Offset> bottomin =
      Tween(begin: Offset(0.0, 1.0), end: Offset.zero);
  final Tween<Offset> topin = Tween(begin: Offset(0.0, -1.0), end: Offset.zero);

  switch (methodName) {
    case 'push':
      Navigator.of(context)
          .push(_createRoute(rightin))
          .then((value) => {fn != null ? fn(value) : ''});
      break;
    case 'pop':
      Navigator.of(context).pop(_createRoute(leftin));
      break;
    case 'replace':
      Navigator.of(context)
          .pushReplacement(_createRoute(rightin))
          .then((value) => {fn != null ? fn(value) : ''});
      break;
    case 'replaceT':
      Navigator.of(context)
          .pushReplacement(_createRoute(topin))
          .then((value) => {fn != null ? fn(value) : ''});
      break;
    case 'replaceB':
      Navigator.of(context)
          .pushReplacement(_createRoute(bottomin))
          .then((value) => {fn != null ? fn(value) : ''});
      break;
    case 'pushT':
      Navigator.of(context)
          .push(_createRoute(topin))
          .then((value) => {fn != null ? fn(value) : ''});
      break;
    case 'pushL':
      Navigator.of(context)
          .push(_createRoute(leftin))
          .then((value) => {fn != null ? fn(value) : ''});
      break;
    case 'pushB':
      Navigator.of(context)
          .push(_createRoute(bottomin))
          .then((value) => {fn != null ? fn(value) : ''});
      break;
    case 'relaunch':
      Navigator.of(context).pushAndRemoveUntil(
          _createRoute(leftin), (Route<dynamic> route) => false);
      break;
  }
}

// ignore: non_constant_identifier_names
dynamic ShadowBox = (
    {String type = 'outside',
    double radius = 15.0,
    bool isPress = false,
    bool reverse = true,
    List<Color> colors,
    bool followGrade = false,
    List<Color> insideBg = const [Colors.transparent, Colors.transparent],
    Color borderColor}) {
  dynamic inside = BoxDecoration(
    gradient: LinearGradient(
      colors: isEmpty(insideBg)
          ? [Colors.transparent, Colors.transparent]
          : [insideBg[0], insideBg[1]],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(radius),
    border:
        !isEmpty(borderColor) ? Border.all(color: borderColor, width: 1) : null,
    boxShadow: [
      BoxShadow(
        offset: Offset(1.0, 1.0),
        color: Color.fromRGBO(255, 255, 255, 0.8),
        spreadRadius: 2.0,
        // blurRadius: 1.0,
      ),
      BoxShadow(
        offset: Offset(-1.0, -1.0),
        color: Color.fromRGBO(189, 193, 209, 1),
        // color: Color.fromRGBO(0, 0, 0, 0.2),
        spreadRadius: 2.0,
        // blurRadius: 1.0,
      ),
      BoxShadow(
        offset: Offset(1.8, 1.8),
        color: Color.fromRGBO(235, 236, 240, 1),
        spreadRadius: 2.0,
        blurRadius: 4,
      ),
    ],
  );
  dynamic commonBgColor = BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: reverse
              ? [HexColor('#F7F8FA'), HexColor('#E6E7ED')]
              : [HexColor('#E6E7ED'), HexColor('#F7F8FA')]),
      borderRadius: BorderRadius.circular(radius));
  var result = {
    "commonBgColor": commonBgColor,
    "inside": inside,
    "outside": {
      "decoration": isPress
          ? inside
          : BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [HexColor('#E6E7ED'), HexColor('#F7F8FA')]),
              borderRadius: BorderRadius.circular(radius),
              boxShadow: [
                BoxShadow(
                  offset: Offset(-4.0, -4.0),
                  blurRadius: 5.0, //陰影範圍
                  spreadRadius: 1.0, //陰影深淺
                  color: Color.fromRGBO(255, 255, 255, 0.8), //陰影顏色
                ),
                BoxShadow(
                  offset: Offset(5.0, 4.0),
                  blurRadius: 5.0, //陰影範圍
                  spreadRadius: 2.0, //陰影深淺
                  // color: Color.fromRGBO(0, 0, 0, 0.15), //陰影顏色
                  color: Color.fromRGBO(96, 106, 130, 0.15), //陰影顏色
                ),
              ],
            ),
      "child": (childContent) {
        return isPress
            ? childContent
            : CommonBg(
                colors: colors,
                reverse: reverse,
                radiusNum: radius,
                childContent: childContent,
                followGrade: followGrade);
      }
    }
  };
  return result[type];
};

/*
 * @description: 判斷是否為空
 * @param {type} 值
 * @return: bool 
 */
bool isEmpty(val, {checkList}) {
  checkList = checkList ?? [null, '', false];
  return checkList.any((e) => e == val);
}

/*
 * @description:
 * @param {String} str "['example','example_2']"
 * @return {List} 
 */
List fixLightText(str) {
  return json
      .decode(str)
      .map((e) => ({
            'light': new RegExp('^##').hasMatch(e),
            'bold': new RegExp('^@@').hasMatch(e),
            'content': e.replaceAll('##', '').replaceAll('@@', '')
          }))
      .toList();
}

/*
 * @description:
 * @param {String} key
 * @param {callback} callback
 */
Future spLimit(key, callback, {milliseconds = 2}) async {
  dynamic sp = await SharedPreferences.getInstance();
  if (sp.get(key) != true) {
    callback();
    sp.setBool(key, true);
    Future.delayed(Duration(milliseconds: milliseconds), () {
      sp.setBool(key, false);
    });
  }
}

/// wbf==============================>

/// <zxb==============================
Widget getDayImg(day, height) {
  var dayStr = day.toString();
  Map<String, List> spaceMap = {
    "10": [500, 190],
    "11": [500, 200],
    "12": [520, 190],
    "13": [520, 190],
    "14": [520, 185],
    "15": [520, 185],
    "16": [520, 185],
    "17": [520, 185],
    "18": [520, 185],
    "19": [520, 185],
    "20": [550, 240],
    "21": [550, 240],
    "22": [550, 240],
    "23": [550, 240],
    "24": [550, 240],
    "25": [550, 240],
    "26": [550, 240],
    "27": [550, 240],
    "28": [550, 240],
    "29": [550, 240],
    "30": [550, 240],
    "31": [500, 230],
  };
  return Center(
    child: Container(
      width: dayStr.length > 1
          ? ScreenUtil().setWidth(spaceMap[day.toString()][0])
          : 500.w,
      child: Stack(
        children: <Widget>[
          dayStr.length == 1
              ? Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    'images/number/${dayStr[0]}@2x.png',
                    height: height,
                  ),
                )
              : Image.asset(
                  'images/number/${dayStr[0]}@2x.png',
                  height: height,
                ),
          Positioned(
            left: ScreenUtil().setWidth(spaceMap[day.toString()][1]),
            child: dayStr.length == 2
                ? Image.asset(
                    'images/number/${dayStr[1]}@2x.png',
                    height: height,
                  )
                : Container(),
          )
        ],
      ),
    ),
  );
}

// 根據key得到值
String getValueByKey(List targetList, key) {
  Map<String, dynamic> resultMap;
  for (int i = 0; i < targetList.length; i++) {
    if (targetList[i]['key'] == key) {
      resultMap = targetList[i];
      break;
    }
  }
  return resultMap['name'];
}

// 周天轉換
Map formatWeek(curTime) {
  String weekDayStr = '';
  String enWeekDayStr = '';
  switch (curTime.weekday) {
    case 1:
      weekDayStr = '周一';
      enWeekDayStr = 'Mon';
      break;
    case 2:
      weekDayStr = '周二';
      enWeekDayStr = 'Tue';
      break;
    case 3:
      weekDayStr = '周三';
      enWeekDayStr = 'Wed';
      break;
    case 4:
      weekDayStr = '周四';
      enWeekDayStr = 'Thu';
      break;
    case 5:
      weekDayStr = '周五';
      enWeekDayStr = 'Fri';
      break;
    case 6:
      weekDayStr = '周六';
      enWeekDayStr = 'Sat';
      break;
    case 7:
      weekDayStr = '周日';
      enWeekDayStr = 'Sun';
      break;
  }
  return {'cnWeekStr': weekDayStr, 'enWeekStr': enWeekDayStr};
}

class TimeUtil {
  /*
   * 是否是閏年
   */
  static bool isLeapYear(int year) {
    return ((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0);
  }

  /*
   * 判斷一个日期是否是周末，即周六日
   */
  static bool isWeekend(DateTime dateTime) {
    return dateTime.weekday == DateTime.saturday ||
        dateTime.weekday == DateTime.sunday;
  }

  /*
   * 某年的天數
   */
  static int getYearDaysCount(int year) {
    if (isLeapYear(year)) {
      return 366;
    }
    return 365;
  }

  /*
   * 某月的天數
   *
   * @param year  年
   * @param month 月
   * @return 某月的天數
   */
  static int getMonthDaysCount(int year, int month) {
    int count = 0;
    //判斷大月份
    if (month == 1 ||
        month == 3 ||
        month == 5 ||
        month == 7 ||
        month == 8 ||
        month == 10 ||
        month == 12) {
      count = 31;
    }

    //判斷小月
    if (month == 4 || month == 6 || month == 9 || month == 11) {
      count = 30;
    }

    //判斷平年與閏年
    if (month == 2) {
      if (isLeapYear(year)) {
        count = 29;
      } else {
        count = 28;
      }
    }
    return count;
  }

  /*
   * 是否是今天
   */
  static bool isCurrentDay(int year, int month, int day) {
    DateTime now = DateTime.now();
    return now.year == year && now.month == month && now.day == day;
  }
}

dynamic formatFontFamily(String fontFamily) {
  return Platform.isAndroid ? null : fontFamily;
}

String getStatusKeyByAct(int statusVal) {
  String statusStr;
  if (0 <= statusVal && statusVal < 25) {
    statusStr = '不願意';
  } else if (25 <= statusVal && statusVal < 50) {
    statusStr = '較免強';
  } else if (50 <= statusVal && statusVal < 75) {
    statusStr = '願意';
  } else {
    statusStr = '非常願意';
  }
  return statusStr;
}

// 性别map
String getGenderStrByValue(int gender) {
  switch (gender) {
    case 0:
      return '未知';
    case 1:
      return '男';
    case 2:
      return '女';
    default:
      return '未说明';
  }
}

/// 轉議ssUrl中的特殊字符
String encodeFileName(String ossUrl) {
  List ossUrlAry = ossUrl.split('/');
  int lastIndex = ossUrlAry.length - 1;
  String nameStr = ossUrlAry[lastIndex];
  String encodeNameStr = Uri.encodeComponent(nameStr);
  ossUrlAry[lastIndex] = encodeNameStr;
  String url = ossUrlAry.join('/');
  return url;
}

/// zxb==============================>

/// <yh==============================
/*
  * @description:
  * @param {type} 
  * @return: 
  */

Function throttle(
  Future Function() func,
) {
  if (func == null) {
    return func;
  }
  bool enable = true;
  Function target = () {
    if (enable == true) {
      enable = false;
      func().then((_) {
        enable = true;
      });
    }
  };
  return target;
}

text({String str, Color color, num size = 30,FontWeight fontWeight = FontWeight.normal}) {
  return Text(
    str,
    style: TextStyle(
      fontSize: size,
       fontWeight: fontWeight,
      color: color,
    ),
  );
}

/// yh==============================>
class Time {
  // 获取时间戳
  static int currentTimeMillis() {
    return new DateTime.now().millisecondsSinceEpoch;
  }

  // 特定时间年的时间戳
  static int appointTimeMillis(year) {
    var dentistAppointment = new DateTime(year, 9, 1);
    return dentistAppointment.millisecondsSinceEpoch;
  }
}

/*
 * @description: 30天之后删除紀錄
 * @param {type} 
 * @return: 
 */
// ignore: non_constant_identifier_names
Future DeleteReport() async {
  dynamic time = Time.currentTimeMillis();
  dynamic sp = await SharedPreferences.getInstance();
  dynamic curTime;
  Map<String, dynamic> record =
      sp.get("record") != null ? convert.jsonDecode(sp.get("record")) : {};
  print('當前時間$record');
  record.removeWhere((key, value) {
    curTime =
        ((time - int.parse(value['timestamp'].toString())) / (24 * 3600 * 1000))
            .toStringAsFixed(0);
    return int.parse(curTime) >= 30;
  });
  sp.setString("record", convert.jsonEncode(record));
  print('之後時間');
  print(sp.get("record"));
}

/// <hjl==============================
/*
 * @description: 日期得到format后的日期 
 * @param {date} 
 * @return: 返回指定類型的日期時間
 */
String getDate(String dateOriginal) {
  //現在的日期
  var today = DateTime.now();
  //今天的23:59:59
  var standardDate = DateTime(today.year, today.month, today.day, 23, 59, 59);
  //傳入的日期與今天的23:59:59秒進行比較
  Duration diff = standardDate.difference(DateTime.parse(dateOriginal));
  if (diff < Duration(days: 1)) {
    //今天 09:20
    return dateOriginal.substring(11, 16);
  } else if (diff >= Duration(days: 1) && diff < Duration(days: 2)) {
    //昨天  昨天09:20
    return "昨天 " + dateOriginal.substring(11, 16);
  } else if (diff >= Duration(days: 2) && diff < Duration(days: 3)) {
    //前天 前天09:20
    return "前天 " + dateOriginal.substring(11, 16);
  } else if (diff < Duration(days: 355) &&
      today.year.toString() == dateOriginal.substring(0, 4)) {
    //當前年之内 01-23 09:20
    return dateOriginal.substring(5, 16);
  } else {
    //當前年之外 2019-01-23 09:20
    return dateOriginal.substring(0, 16);
  }
}

/*
 * @description: 格式化日期字符串，包括未来的日期
 * @param {date}
 * @return: 返回指定類型的日期時間
 */
String parseBeforeAndAfterDate(String dateOriginal) {
  //現在的日期
  var today = DateTime.now();
  //今天的23:59:59
  var standardDate = DateTime(today.year, today.month, today.day, 23, 59, 59);
  //傳入的日期與今天的23:59:59秒進行比較
  Duration diff = standardDate.difference(DateTime.parse(dateOriginal));
  if (diff < Duration(seconds: 1)) {
    if (today.year.toString() == dateOriginal.substring(0, 4)) {
      // 當年，取日期和时间
      return dateOriginal.substring(5, 16);
    } else {
      // 未来年，取 年+日期+时间
      return dateOriginal.substring(0, 16);
    }
  } else if (diff < Duration(days: 1)) {
    //今天 09:20
    return dateOriginal.substring(11, 16);
  } else if (diff >= Duration(days: 1) && diff < Duration(days: 2)) {
    //昨天  昨天09:20
    return "昨天 " + dateOriginal.substring(11, 16);
  } else if (diff >= Duration(days: 2) && diff < Duration(days: 3)) {
    //前天 前天09:20
    return "前天 " + dateOriginal.substring(11, 16);
  } else if (diff < Duration(days: 355) &&
      today.year.toString() == dateOriginal.substring(0, 4)) {
    //當前年之内 01-23 09:20
    return dateOriginal.substring(5, 16);
  } else {
    //當前年之外 2019-01-23 09:20
    return dateOriginal.substring(0, 16);
  }
}
