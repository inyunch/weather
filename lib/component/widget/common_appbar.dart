import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CLAppBar extends StatelessWidget implements PreferredSizeWidget {
  CLAppBar(this.pageTitle,
      {this.isHasReturn = true,
      this.returnParams,
      this.onBackPress,
      this.bottom,
      this.actions})
      : assert(pageTitle != null, 'title must not be null'),
        preferredSize = Size.fromHeight(
            kToolbarHeight + (bottom?.preferredSize?.height ?? 0.0));
  final String pageTitle;
  final bool isHasReturn;
  final Map returnParams;
  final VoidCallback onBackPress;
  final PreferredSizeWidget bottom;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) => AppBar(
        title: Text(
          pageTitle,
          style: const TextStyle(
              fontSize: 18,
              color: Color(0xFF333330),
              fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.white,
        brightness: Brightness.light,
        centerTitle: true,
        elevation: 0,
        leading: Offstage(
          offstage: !isHasReturn,
          child: IconButton(
              icon: Icon(
                CupertinoIcons.left_chevron,
                color: const Color(0xFFFF3742),
              ),
              onPressed: onBackPress ??
                  () {
                    Navigator.of(context).pop();
                  }),
        ),
        bottom: bottom,
        actions: actions,
      );

  @override
  final Size preferredSize;
}
