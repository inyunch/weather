
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/component/new/custom_scaffold.dart';
import 'package:weather/component/widget/page.dart';
import 'package:weather/pages/mine/detail.dart';
import 'package:weather/pages/until/util.dart';
import 'package:weather/tools/common.dart';
import 'package:weather/tools/event.dart';

class MinePage extends StatefulWidget {
  @override
  _MinePageState createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  bool isLoading = false;
  String locationName = '';
  Map MaxT = {};
  Map MinT = {};
  Map PoP12h = {};
  @override
  void initState() {
    load();
    super.initState();
  }

  showLoading() {
    setState(() {
      isLoading = true;
    });
  }

  hideLoading() {
    setState(() {
      isLoading = false;
    });
  }

  load() async {
    showLoading();
    Dio dio = Dio();

    dio.options.headers = {
      'Authorization': 'CWB-AF051CEE-9972-4C1E-92FB-FF0604BAED32',
      'Content-Type': 'application/json;charset=UTF-8'
    };
    try {
      var res = await dio.get(
          'https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-D0047-063?limit=1&format=JSON');
      hideLoading();
      List weatherElement =
          res.data['records']['locations'][0]['location'][0]['weatherElement'];
      setState(() {
        MaxT =  {
          'elementName': res.data['records']['locations'][0]['location'][0]
              ['weatherElement'][12]['elementName'],
          'description': res.data['records']['locations'][0]['location'][0]
              ['weatherElement'][12]['description'],
         'time': res.data['records']['locations'][0]['location'][0]['weatherElement']
              [12]['time']
        };
        MinT =  {
          'elementName': res.data['records']['locations'][0]['location'][0]
              ['weatherElement'][8]['elementName'],
          'description': res.data['records']['locations'][0]['location'][0]
              ['weatherElement'][8]['description'],
         'time': res.data['records']['locations'][0]['location'][0]['weatherElement']
              [8]['time']
        };
        PoP12h = {
          'elementName': res.data['records']['locations'][0]['location'][0]
              ['weatherElement'][0]['elementName'],
          'description': res.data['records']['locations'][0]['location'][0]
              ['weatherElement'][0]['description'],
         'time': res.data['records']['locations'][0]['location'][0]['weatherElement']
              [0]['time']
        };
        locationName =
            res.data['records']['locations'][0]['location'][0]['locationName'];
      });
    } catch (e) {
      hideLoading();
      BCToast.show('網路異常');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
        appBar: AppBar(
          title: Text(
            locationName,
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0.01,
          backgroundColor: Colors.white,
        ),
        body: CommonPage(
            loading: isLoading,
            child: SingleChildScrollView(
                // loading: false,
                child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
           
                Column(children: [
                  SizedBox(
                    height: 10,
                  ),
                  item( PoP12h),
                  item( MaxT),
                  item( MinT),
                  SizedBox(
                    height: 20,
                  ),
                
                ])
              ],
            ))));
  }

  item(
  Map map
  ) {
    return GestureDetector(
        onTap: () {
           Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DetailPage(map);
            }));
        },
        child: Container(
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
              text(color: Colors.black, str: map['elementName']??'', size: 16.sp,fontWeight: FontWeight.bold),
              SizedBox(height: 10,),
               text(color: Colors.black, str: map['description']??'', size: 16.sp),
            ],
          ), 
          text(str:'>',color:Colors.grey, size: 16.sp)
           ],),
        ));
  }

}
