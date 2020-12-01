import 'package:flutter/material.dart';

import '../../services/utils.dart';
import '../component/component.dart';

class ServicePages extends StatefulWidget{
  ServicePages({Key key});
  _ServicePages createState() => _ServicePages();
}

class _ServicePages extends State {
  @override
  initState() {
    super.initState();
  }
  Widget build(BuildContext context) {
    Screen.init(context);
    // TODO: implement build
    return Scaffold(
      appBar: HeadersComponent.Appbars(Text('客服中心', style: TextStyle(fontSize: Screen.width(32)),), showLeading: false,),
      body: Container(
        color: Colors.white,
        child: ListView(
          children: <Widget>[
            SizedBox(height: Screen.width(70),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    children: <Widget>[
                      Image.asset('images/service/service_01.png', width: Screen.width(100),),
                      SizedBox(height: Screen.width(15),),
                      Text('联系我们', style: TextStyle(fontSize: Screen.width(28)),),
                    ],
                  ),
                  onTap: () {Navigator.pushNamed(context, '/contact');},
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    children: <Widget>[
                      Image.asset('images/service/service_02.png', width: Screen.width(100),),
                      SizedBox(height: Screen.width(15),),
                      Text('在线客服', style: TextStyle(fontSize: Screen.width(28)),),
                    ],
                  ),
                  onTap: () {},
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Column(
                    children: <Widget>[
                      Image.asset('images/service/service_03.png', width: Screen.width(100),),
                      SizedBox(height: Screen.width(15),),
                      Text('意见反馈', style: TextStyle(fontSize: Screen.width(28)),),
                    ],
                  ),
                  onTap: () {Navigator.pushNamed(context, '/proposal');},
                ),
              ],
            ),
            SizedBox(height: Screen.width(70),),
            ListTitleComponent(
              height: 200,
              title: Text('如何开通网上银行', style: TextStyle(fontSize: Screen.width(30), color: Colors.red)),
              subTitle: Text('开通银行卡网上支付功能，包括网上开通和现场开通两种方式：1.网上开通：登录各大银行的官方网站在线开...', style: TextStyle(fontSize: Screen.width(26), color: Colors.grey), overflow: TextOverflow.ellipsis, maxLines: 2,),
              onTap: () {
                Navigator.pushNamed(context, '/details', arguments: {
                  'title': '活动详情',
                  'contentTitle': Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only( top: Screen.width(15)),
                    child: Text('标题', style: TextStyle(fontSize: Screen.width(30)),),
                  ),
                  'time': Container(
                    alignment: Alignment.bottomRight,
                    margin: EdgeInsets.only(top: Screen.width(30), right: Screen.width(30)),
                    child: Text('2020-01-01 15:00:00', style: TextStyle(fontSize: Screen.width(28)),),
                  ),
                  'content': ''
                });
              },
            ),
            Divider(height: 0,),
          ],
        ),
      )
    );
  }
}