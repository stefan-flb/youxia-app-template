import 'dart:convert';

import 'package:flutter/material.dart';
import '../../../../services/utils.dart';
import '../../../component/component.dart';

class AboutPages extends StatefulWidget{
  createState() => _AboutPages();
}

class _AboutPages extends State {
  Map userInfo = {};
  @override
  initState() {
    super.initState();
    Storage.getString('userDetail').then((response) {
      if(response != null) {
        setState(() {
          userInfo = json.decode(response);
        });
      }
    });
  }
  Widget build(BuildContext context) {
    Screen.init(context);
    // TODO: implement build
    return Scaffold(
        appBar: HeadersComponent.Appbars(Text('关于我们', style: TextStyle(fontSize: Screen.width(32)),)),
        body: Container(
          padding: EdgeInsets.all(15),
          width: double.infinity,
          color: ColorGather.colorBg(),
          child: ListView(
            children: <Widget>[
              SizedBox(height: Screen.width(80),),
              Text('logo', style: TextStyle(fontSize: Screen.width(32)), textAlign: TextAlign.center,),
              SizedBox(height: Screen.width(5),),
              Text('v1.1', style: TextStyle(fontSize: Screen.width(28), color: Colors.grey), textAlign: TextAlign.center,),
              SizedBox(height: Screen.width(20),),
              Text('logologologologologologologologologologologologologologologologologologologologologologologologologologologologologologologologologologologologologologologologologologologologologologologologo', style: TextStyle(fontSize: Screen.width(28)),),
            ],
          ),
        )
    );
  }
}