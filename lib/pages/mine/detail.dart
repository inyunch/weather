import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/component/new/custom_scaffold.dart';
import 'package:weather/component/widget/page.dart';
import 'package:weather/pages/until/util.dart';
class DetailPage extends StatefulWidget {
  final Map map;
  const DetailPage(this.map) ;

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List list = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      list = widget.map['time'];
    });
  }
  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        appBar: AppBar(
          leading: GestureDetector(onTap: (){
            Navigator.pop(context);
          },child: Image.asset('assets/images/return@2x.png'),),
          title: Text(
            '未來7天'+widget.map['description']??'',
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0.01,
          backgroundColor: Colors.white,
        ),
        body:  SingleChildScrollView(
                
                child: Column(
              children: getList(),
            )));
  }

  getList(){
    List<Widget>listWidgets = [];
    for (var i in list) {
      listWidgets.add(item(i));
    }
    return listWidgets;
  }

   item(
  Map map
  ) {
    return Container(
          width: MediaQuery.of(context).size.width-20,
          padding: EdgeInsets.all(20),
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.2),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              text(color: Colors.black, str: map['startTime']??'', size: 16.sp,fontWeight: FontWeight.bold),
              SizedBox(height: 10,),
              text(str: '至',size: 16.sp,fontWeight: FontWeight.bold),
              SizedBox(height: 10,),
               text(color: Colors.black, str: map['endTime']??'', size: 16.sp,fontWeight: FontWeight.bold),
               //text(color: Colors.black, str: map['elementValue'][0]['value']+map['elementValue'][0]['measures'], size: 16.sp),
            ],
          ), 
         text(color: Colors.black, str: map['elementValue'][0]['value']+map['elementValue'][0]['measures'], size: 16.sp),
           ],),
        );
  }

}