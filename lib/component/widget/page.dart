import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



class CommonPage extends StatefulWidget {
  final Widget child;

  final bool loading;
  final String backgroundImage;
  final bool showCodeRecive;
  final bool top;

  CommonPage({
    Key key,
    this.child,
    this.loading,
    this.backgroundImage,
    this.showCodeRecive,
    this.top = true,
  }) : super(key: key);

  _CommonPageState createState() => _CommonPageState();
}

class _CommonPageState extends State<CommonPage> {
  @override
  void initState() {
    super.initState();
  }

  Widget renderSpinner() {
    if (widget.loading == null) {
      return Container();
    }

   

    if (widget.loading == true) {
      return new Material(
        //創建透明層
        type: MaterialType.transparency, //透明類型
        child: new Center(
          //置中
          child: new SizedBox(
            width: 100.0,
            height: 100.0,
            child: new Opacity(
              opacity: 0.8,
              child: new Container(
                decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  borderRadius: new BorderRadius.vertical(
                      top: Radius.elliptical(10, 10),
                      bottom: Radius.elliptical(10, 10)),
                  boxShadow: <BoxShadow>[
                    new BoxShadow(
                      color: const Color(0xff777777),
                      blurRadius: 10.0,
                      spreadRadius: 1.0,
                      offset: Offset(0, 0),
                    ),
                  ],
                ),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new CircularProgressIndicator(),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
    return Container();
  }

  Decoration backgroundImage() {
    if (widget.backgroundImage == null || widget.backgroundImage == '') {
      return null;
    }

    return BoxDecoration(
      image: DecorationImage(
        image: AssetImage(widget.backgroundImage),
        fit: BoxFit.fill,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: backgroundImage(),
      child: SafeArea(
        bottom: false,
        left: false,
        right: false,
        top: false,
        child: Stack(
          children: <Widget>[
            widget.child,
            renderSpinner(),
          ],
        ),
      ),
    );
  }
}
