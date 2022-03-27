
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/pages/until/util.dart';

enum ToastPosition { top, center, bottom }

class ToastWX {
  static OverlayEntry _overlayEntry;
  static bool _showing = false;
  static ToastPosition toastPosition;
  static DateTime _startTime;
  static String _msg;
  static String _titleMsg;
  static Widget _widget;
  static void show(
    BuildContext context, {
    String msg,
    String titleMsg,
    int duration = 1, // 默認1秒
    ToastPosition toastPosition,
    Color background = const Color.fromRGBO(0, 0, 0, 0.65),
    TextStyle textStyle = const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w300,
        color: Colors.white,
        backgroundColor: Colors.transparent),
    TextStyle titleTextStyle = const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        backgroundColor: Colors.transparent),
    double backgroundRadius,
    Border border,
    Widget widget,
  }) async {
    OverlayState overlayState = Overlay.of(context);
    toastPosition = ToastPosition.center;
    _startTime = DateTime.now();
    _showing = true;
    _msg = msg;
    _titleMsg = titleMsg;
    _widget = widget;
    if (_overlayEntry == null) {
      _overlayEntry = OverlayEntry(
        builder: (BuildContext context) => ToastWidget(
            widget: _widget ??
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 90.w),
                  constraints: BoxConstraints(maxHeight: 1334.h),
                  width: 570.w ?? MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        child: Container(
                          constraints: BoxConstraints(
                            maxWidth:
                                570.w ?? MediaQuery.of(context).size.width,
                          ),
                          decoration: BoxDecoration(
                            color: background,
                            borderRadius:
                                BorderRadius.circular(backgroundRadius ?? 30.w),
                            border: border,
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 39.w, horizontal: 20),
                          child: Column(
                            children: [
                              !isEmpty(_titleMsg)
                                  ? Padding(
                                      padding: EdgeInsets.only(bottom: 30.w),
                                      child: Text(
                                        _titleMsg,
                                        softWrap: true,
                                        style: titleTextStyle,
                                        textAlign: TextAlign.center,
                                      ),
                                    )
                                  : SizedBox(),
                              Text(
                                _msg,
                                softWrap: true,
                                style: textStyle,
                                textAlign: TextAlign.center,
                              )
                            ],
                          ),
                        )),
                  ),
                ),
            toastPosition: toastPosition),
      );
      overlayState.insert(_overlayEntry);
    } else {
      _overlayEntry.markNeedsBuild();
    }
    await Future.delayed(Duration(seconds: duration));
    if (DateTime.now().difference(_startTime).inSeconds >= duration) {
      dismiss();
    }
  }

  static dismiss() async {
    if (!_showing) {
      return;
    }
    _showing = false;
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}

class ToastWidget extends StatelessWidget {
  ToastWidget({
    Key key,
    @required this.widget,
    this.toastPosition,
  }) : super(key: key);

  final Widget widget;
  final ToastPosition toastPosition;

  @override
  Widget build(BuildContext context) {
    return Positioned(
        // top: buildToastPosition(context),
        child: Material(
            color: Colors.transparent,
            child: Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[widget],
            ))));
  }

  double buildToastPosition(context) {
    var top;
    if (toastPosition == ToastPosition.top) {
      top = MediaQuery.of(context).size.height * 1 / 4;
    } else if (toastPosition == ToastPosition.center) {
      top = MediaQuery.of(context).size.height * 2 / 5;
    } else {
      top = MediaQuery.of(context).size.height * 3 / 4;
    }
    return top;
  }
}
