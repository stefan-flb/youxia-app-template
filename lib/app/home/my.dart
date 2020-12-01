import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../services/utils.dart';
import '../../services/state.dart';
import '../component/component.dart';
import '../home.dart';

import '../pages/my/myFollow/myFollow.dart';
import '../pages/my/settings/settings.dart';

class MyPages extends StatefulWidget{
  MyPages({Key key});
  _MyPages createState() => _MyPages();
}

class _MyPages extends State {
  // 获取昵称
  var userDetail = Map();
  @override
  initState() {
    super.initState();
    _init();
  }

  // 返回上一页刷新
  deactivate() {
    super.deactivate();
    var bool = ModalRoute.of(context).isCurrent;
    if (bool) {
      _init();
    }
  }
  Widget build(BuildContext context) {
    Screen.init(context);
    // TODO: implement build
    return Scaffold(
        appBar: HeadersComponent.Appbars(
            Text('logo', style: TextStyle(fontSize: Screen.width(32)),),
            showLeading: false,
            actions: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Container(
                  alignment: Alignment.centerRight,
                  padding: EdgeInsets.only(right: Screen.width(20)),
                  width: Screen.width(100),
                  height: double.infinity,
                  child: Text('设置', style: TextStyle(fontSize: Screen.width(30)),),
                ),
                onTap: () {
                  Navigator.pushNamed(context, '/setting').then((val) {
//                    if(val != null) {
//                    }
                  });
                },
              ),
            ]
        ),
        body: Container(
          color: ColorGather.colorBg(),
          child: ListView(
            children: <Widget>[
              Container(
                height: Screen.width(180),
                decoration: BoxDecoration(
                    color: ColorGather.colorMain()
                ),
                child: ListTitleComponent(
                  color: null,
                  leading: ClipOval(
                    child: Image.asset('images/home/banner_01.jpg', width: Screen.width(118), height: Screen.width(118), fit: BoxFit.cover,),
                  ),
                  title: Text('账号: ${userDetail["username"]}', style: TextStyle(fontSize: Screen.width(28), color: Colors.white)),
                  subTitle: Row(
                    children: <Widget>[
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: Text('编辑个人资料', style: TextStyle(fontSize: Screen.width(24), color: Colors.white)),
                        onTap: () {
                          Navigator.pushNamed(context, '/setting');
                        },
                      ),
                      Icon(Icons.mode_edit, size: Screen.width(36), color: Colors.white,),
                    ],
                  ),
                  trailing: Image.asset('images/tem/tem_02.png', width: Screen.width(145),),
                ),
              ),

              GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: ListTitleComponent(
                  color: null,
                  leadingRight: 5,
                  height: 150,
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('images/tem/tem_02.png', width: Screen.width(60),),
                      SizedBox(height: Screen.width(10),),
                      Text('0', style: TextStyle(fontSize: Screen.width(26))),
                    ],
                  ),
                  title: Container(
                    margin: EdgeInsets.only(bottom: Screen.width(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Text('我的积分: ', style: TextStyle(fontSize: Screen.width(24), color: ColorGather.colorFont()),),
                            Text('1000', style: TextStyle(fontSize: Screen.width(24)),),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Text('距升级差: ', style: TextStyle(fontSize: Screen.width(24), color: ColorGather.colorFont()),),
                            Text('3999', style: TextStyle(fontSize: Screen.width(24)),),
                          ],
                        ),
                      ],
                    ),
                  ),
                  subTitle: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      LinearPercentIndicator(
                        width: Screen.width(510),
                        lineHeight: Screen.width(15),
                        percent: .1,
                        backgroundColor: Colors.grey,
                        progressColor: ColorGather.colorMain(),
                      )
                    ],
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset('images/tem/tem_03.png', width: Screen.width(60),),
                      SizedBox(height: Screen.width(10),),
                      Text('4999', style: TextStyle(fontSize: Screen.width(26))),
                    ],
                  ),
                ),
                onTap: () {Navigator.pushNamed(context, '/memberLevel');},
              ),

              Column(
                  children: <Widget>[
//                    ListTitleComponent(
//                      leading: Image.asset('images/my/my_1.png', width: Screen.width(55)),
//                      title: Text('我的关注', style: TextStyle(fontSize: Screen.width(30))),
//                      onTap: () {
//                        Navigator.of(context).push(CupertinoPageRoute(builder: (context) => FollowPages()));
//                      },
//                    ),
//                    Divider(height: 0,),
                    ListTitleComponent(
                      leading: Image.asset('images/my/my_2.png', width: Screen.width(55)),
                      title: Text('我的钱包', style: TextStyle(fontSize: Screen.width(30))),
                      onTap: () { Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context) => HomePages(currentIndex: 1,)), (route) => route == null); },
                    ),
                    Divider(height: 0,),
                    ListTitleComponent(
                      leading: Image.asset('images/my/my_5.png', width: Screen.width(52)),
                      title: Text('订单记录', style: TextStyle(fontSize: Screen.width(30))),
                      onTap: () {Navigator.pushNamed(context, '/orderType');},
                    ),
                    Divider(height: 0,),
                    ListTitleComponent(
                      leading: Image.asset('images/my/my_6.png', width: Screen.width(55)),
                      title: Text('团队管理', style: TextStyle(fontSize: Screen.width(30))),
                      onTap: () {Navigator.pushNamed(context, '/team');},
                    ),
                    SizedBox(height: Screen.width(20)),

                    ListTitleComponent(
                      leading: Image.asset('images/my/my_7.png', width: Screen.width(50)),
                      title: Text('任务中心', style: TextStyle(fontSize: Screen.width(30))),
                      onTap: () {Navigator.pushNamed(context, '/taskCenter');},
                    ),
                    Divider(height: 0,),
                    ListTitleComponent(
                      leading: Image.asset('images/my/my_8.png', width: Screen.width(52)),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('活动中心', style: TextStyle(fontSize: Screen.width(30))),
                          Text('精彩好礼等你拿', style: TextStyle(fontSize: Screen.width(30), color: Colors.grey)),
                        ],
                      ),
                      onTap: () {Navigator.pushNamed(context, '/activity');},
                    ),
                    SizedBox(height: Screen.width(20)),
                  ]
              ),
            ],
          ),
        )
    );
  }

  _init() async{
    userDetail["username"] = '';
    // var userDetails = await Storage.getString('userDetail');
    // if(userDetails != null) {
    //   setState(() {
    //     userDetail = json.decode(userDetails);
    //   });
    // }
  }
}