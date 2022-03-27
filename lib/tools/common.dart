import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:weather/component/widget/common_toast.dart';
import 'package:weather/pages/until/util.dart';


class CustomException implements Exception {
  String errMsg() => 'Amount should be greater than zero';
  int code;
  String cause;
  CustomException(this.code, this.cause);

  String toString() {
    return this.cause;
  }
}

class BCToast {
  static show(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
    );
  }
}

class WidgetUtils {
  static Future<T> push<T extends Object>(BuildContext context, Widget widget) {
    return Navigator.push<T>(context,
        new CupertinoPageRoute(builder: (BuildContext context) {
      return widget;
    }));
  }
}

Future showToast(
  context,
  msg, {
  String titleMsg,
  int duration = 1, // 默認1秒
  Widget widget,
}) async {
  if (isEmpty(context)) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        backgroundColor: HexColor("#000000").withOpacity(0.6),
        textColor: Colors.white);
  } else {
    ToastWX.show(context,
        msg: msg, titleMsg: titleMsg, duration: duration, widget: widget);
  }
}

class BCDialog {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      new GlobalKey<ScaffoldState>();
  static void show(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return new LoadingView(false);
        });
  }

  static void hidden(BuildContext context) {
    Navigator.pop(context);
  }

  /// 顯示提交確認
  static void showConfirm<T>(
      {BuildContext context, Text content, List<Widget> actions}) {
    showDialog<T>(
      context: context,
      builder: (BuildContext context) => new AlertDialog(
        content: content,
        actions: actions,
      ),
    ).then<void>((T value) {
      // The value passed to Navigator.pop() or null.
      if (value != null) {
        _scaffoldKey.currentState.showSnackBar(
            new SnackBar(content: new Text('You selected: $value')));
      }
    });
  }
}

class Router1 {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  static GlobalKey<dynamic> bottomAudioKey = GlobalKey();
}

class LoadingView extends StatelessWidget {
  final bool offstage;

  LoadingView(this.offstage);

  @override
  Widget build(BuildContext context) {
    return new Offstage(
      offstage: offstage,
      child: new Container(
        child: new ConstrainedBox(
          constraints: new BoxConstraints.expand(),
          child: new Center(
            child: new Container(
              padding: new EdgeInsets.all(25.0),
              child: CupertinoActivityIndicator(
                radius: 20.0,
              ),
              decoration: new BoxDecoration(
                  color: new Color.fromRGBO(0, 0, 0, 0.5),
                  borderRadius: new BorderRadius.all(new Radius.circular(5.0))),
            ),
          ),
        ),
      ),
    );
  }
}
