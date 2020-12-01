import 'dart:convert';
import 'package:flutter/material.dart';

import '../../../../services/utils.dart';
import '../../../../api/api.dart';
import '../../../component/component.dart';

class TeamPages extends StatefulWidget{
  createState() => _TeamPages();
}

class _TeamPages extends State {
  var bonusercentage = 0;
  var salaryPercentage = 0;
  @override
  initState() {
    super.initState();
    // 代理分红 和 日工资报表权限
    // Api.userDetail().then((response) {
    //   if(response['success']) {
    //     var data = response['data'];
    //     // 获取权限
    //     setState(() {
    //       bonusercentage = int.parse(data['bonus_percentage'].substring(0, data['bonus_percentage'].indexOf('.')));
    //       salaryPercentage = int.parse(data['salary_percentage'].substring(0, data['salary_percentage'].indexOf('.')));
    //     });
    //     Storage.setString('userDetail', json.encode(response['data']));
    //   }
    // });
  }
  Widget build(BuildContext context) {
    Screen.init(context);
    // TODO: implement build
    return Scaffold(
        appBar: HeadersComponent.Appbars(Text('团队管理', style: TextStyle(fontSize: Screen.width(32)),)),
        body: Container(
          width: double.infinity,
          color: ColorGather.colorBg(),
          child: ListView(
            children: <Widget>[
              SizedBox(height: Screen.width(20),),
              ListTitleComponent(
                title: Text('代理首页', style: TextStyle(fontSize: Screen.width(30))),
                onTap: () {Navigator.pushNamed(context, '/statistical');},
              ),
              Divider(height: 0,),
              ListTitleComponent(
                title: Text('团队管理', style: TextStyle(fontSize: Screen.width(30))),
                onTap: () {Navigator.pushNamed(context, '/teamManage');},
              ),
              Divider(height: 0,),
              ListTitleComponent(
                title: Text('团队盈亏', style: TextStyle(fontSize: Screen.width(30))),
                onTap: () {Navigator.pushNamed(context, '/teamProfit');},
              ),
              Divider(height: 0,),
              Offstage(
                offstage: bonusercentage == 0,
                child: Divider(height: 0,),
              ),
              Offstage(
                offstage: bonusercentage == 0,
                child: ListTitleComponent(
                  title: Text('日工资报表', style: TextStyle(fontSize: Screen.width(30))),
                  onTap: () {Navigator.pushNamed(context, '/dailyWages');},
                ),
              ),
              Offstage(
                offstage: salaryPercentage == 0,
                child: Divider(height: 0,),
              ),
              Offstage(
                offstage: salaryPercentage == 0,
                child: ListTitleComponent(
                  title: Text('代理分红报表', style: TextStyle(fontSize: Screen.width(30))),
                  onTap: () {Navigator.pushNamed(context, '/shareMoney');},
                ),
              ),
              SizedBox(height: Screen.width(20),),
              ListTitleComponent(
                title: Text('下级开户', style: TextStyle(fontSize: Screen.width(30))),
                onTap: () {Navigator.pushNamed(context, '/openAccount');},
              ),
            ],
          ),
        )
    );
  }
}