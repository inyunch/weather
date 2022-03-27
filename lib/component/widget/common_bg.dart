
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loading_animations/loading_animations.dart';

class CommonBg extends StatelessWidget {
  const CommonBg({
    Key key,
    this.childContent,
    this.radiusNum,
    this.reverse,
    this.appBar,
    this.purityColor,
    this.isLoading,
    this.height,
    this.colors,
    this.followGrade,
  }) : super(key: key);
  final Widget childContent;
  final double radiusNum;
  final bool reverse;
  final Widget appBar;
  final Color purityColor;
  final bool isLoading;
  final double height;
  final List<Color> colors;
  final bool followGrade;
  @override
  Widget build(BuildContext context) {
    double radius = radiusNum == null ? 0.0 : radiusNum;
    bool reverseMark = reverse == null ? false : reverse;
    bool loading = isLoading == null ? false : isLoading;
    bool gradeBg = followGrade == null ? false : followGrade;
    List colorRepeat() {
      if (reverseMark) {
        if (colors != null && colors.length > 0) {
          return [
            [colors[0], colors[1]],
            [colors[2], colors[3]]
          ];
        } else {
          return [
            [
              Color.fromRGBO(230, 231, 237, 1),
              Color.fromRGBO(247, 248, 250, 1)
            ],
            [
              Color.fromRGBO(64, 72, 93, 0.04),
              Color.fromRGBO(96, 106, 130, 0.04)
            ]
          ];
        }
      } else {
        return [
          [Color.fromRGBO(247, 248, 250, 1), Color.fromRGBO(230, 231, 237, 1)],
          [Color.fromRGBO(96, 106, 130, 0.04), Color.fromRGBO(64, 72, 93, 0.04)]
        ];
      }
    }

    return Stack(children: [
      height != null
          ? Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: purityColor,
              decoration: purityColor == null
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(radius),
                      gradient: LinearGradient(
                        colors: gradeBg
                            ? [Colors.transparent, Colors.transparent]
                            : colorRepeat()[0],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    )
                  : null,
            )
          : Container(
              width: MediaQuery.of(context).size.width,
              color: purityColor,
              decoration: purityColor == null
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(radius),
                      gradient: LinearGradient(
                        colors: gradeBg
                            ? [Colors.transparent, Colors.transparent]
                            : colorRepeat()[0],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    )
                  : null,
            ),
      height != null
          ? Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              color: purityColor,
              decoration: purityColor == null
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(radius),
                      gradient: LinearGradient(
                        colors: colorRepeat()[1],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    )
                  : null,
              child: childContent)
          : Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
              color: purityColor,
              decoration: purityColor == null
                  ? BoxDecoration(
                      borderRadius: BorderRadius.circular(radius),
                      gradient: LinearGradient(
                        colors: colorRepeat()[1],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    )
                  : null,
              child: childContent),
      // context.watch<UserInfo>().userInfo['isLoading']
      //  loadingDialog  加载中 组件：  LoadingDialog();
      loading
          ? Positioned(
              top: 0,
              left: 0,
              child: Container(
                color: Color.fromRGBO(0, 0, 0, 0),
                width: 750.w,
                height: 1334.h,
                alignment: Alignment.center,
                child: LoadingBouncingGrid.square(
                  backgroundColor: Color(0xff26CAD3),
                  size: 30.0,
                  inverted: true,
                ),
              ),
            )
          : Container(),
    ]);
  }
}
