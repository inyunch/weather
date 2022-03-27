import 'package:flutter/material.dart';

/// 設備螢幕高度
double getDeviceHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}
//

/// 設備螢幕寬度
double getDeviceWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

/// 設備頂部狀態欄寬度
double getDeviceTopHeight(BuildContext context) {
  return MediaQuery.of(context).padding.top;
}

/// 設備底部Bar寬度
double getDeviceBottomHeight(BuildContext context) {
  return MediaQuery.of(context).padding.bottom;
}
