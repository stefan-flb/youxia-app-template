import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../services/utils.dart';
import '../../../../services/state.dart';
import '../../../../api/api.dart';
import '../../../component/component.dart';
import '../../../component/dialog.dart';


import '../about/about.dart';
import '../changePassword/changePassword.dart';

class UserInfoPages extends StatefulWidget{
  var arguments;
  UserInfoPages({this.arguments});
  createState() => _UserInfoPages(this.arguments);
}

class _UserInfoPages extends State {
  var arguments;
  _UserInfoPages(this.arguments);
  Map userInfo;

  // 查看信息
  var listJson = {
    'nickname': '昵称',
    'real_name': '真实姓名',
    'mobile': '手机号码',
    'email': '邮箱',
    'zip_code': '邮编',
    'vip_level': '会员等级',
    'register_time': '注册时间',
  };
  var list = [];

  // 编辑信息
  var editJson = {
    'nickname': TextEditingController(),
    'real_name': TextEditingController(),
    'mobile': TextEditingController(),
    'email': TextEditingController(),
    'zip_code': TextEditingController(),
    'vip_level': TextEditingController(),
    'register_time': TextEditingController(),
  };

  // 是否编辑状态
  var isEdit = false;

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
    _init();
  }
  Widget build(BuildContext context) {
    Screen.init(context);
    // TODO: implement build
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {FocusScope.of(context).requestFocus(FocusNode());},
        child: Scaffold(
            appBar: HeadersComponent.Appbars(
                Text('设置', style: TextStyle(fontSize: Screen.width(32)),)
            ),
            body: Container(
              color: ColorGather.colorBg(),
              child: !isEdit ? ListView(
                children: <Widget>[
                  Column(
                    children: list.map((item) {
                      return ListTitleComponent(
                        title: Text('${item["name"]}', style: TextStyle(fontSize: Screen.width(30))),
                        trailing: Text('${item["val"] ?? '暂无'}', style: TextStyle(fontSize: Screen.width(30), color: Colors.grey)),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: Screen.width(30),),
                  ButtonComponent.material(title: '我要编辑', width: .92, pressed: () {
                    var listLength = list.length;
                    setState(() {
                      for(var i = 0; i < listLength; i++) {
                        if(editJson[list[i]['key']] != null) {
                          editJson[list[i]['key']].text = list[i]['val'];
                        }
                      }
                      isEdit = true;
                    });
                  },),
                ],
              ) : ListView(
                children: <Widget>[
                  SizedBox(height: Screen.width(20),),
                  InputComponent.text(
                      labelText: '请输入昵称', controller: editJson['nickname'],
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(18)
                      ]),
                  InputComponent.text(
                      labelText: '请输入真实姓名', controller: editJson['real_name'],
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(18)
                      ]),
                  InputComponent.text(
                      labelText: '请输入手机号码', controller: editJson['mobile'],
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(11),
                        WhitelistingTextInputFormatter.digitsOnly
                      ]),
                  InputComponent.text(
                      labelText: '请输入邮箱', controller: editJson['email'],
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(18)
                      ]),
                  InputComponent.text(
                      labelText: '请输入邮编', controller: editJson['zip_code'],
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(18)
                      ]),
                  SizedBox(height: Screen.width(30),),
                  Row(children: <Widget>[
                    Expanded(
                      child: ButtonComponent.material(title: '取消', pressed: () async{
                        setState(() {
                          isEdit = false;
                        });
                      },),
                    ),
                    Expanded(
                      child: ButtonComponent.material(title: '确认修改', pressed: () async{

                        var data = {
                          'nickname': editJson['nickname'].text,
                          'real_name': editJson['real_name'].text,
                          'mobile': editJson['mobile'].text,
                          'email': editJson['email'].text,
                          'zip_code': editJson['zip_code'].text,
                          'vip_level': editJson['vip_level'].text,
                          'register_time': editJson['register_time'].text,
                        };
                        // var response = await Api.resetSpecificInfos(data);
                        // if(response['success']) {
                        //   setState(() {
                        //     list = [];
                        //     data.forEach((key, val) {
                        //       setState(() {
                        //         list.add({'name': listJson[key], 'val': val, 'key': key});
                        //       });
                        //     });
                        //     isEdit = false;
                        //   });
                        //   DialogComponents.toast(context, content: '修改成功!');
                        // }
                      },),
                    )
                  ],)
                ],
              ),
            )
        )
    );
  }

  _init() async{
    arguments['info'].forEach((key, val) {
      if(listJson[key] != null) {
        setState(() {
          list.add({'name': listJson[key], 'val': val, 'key': key});
        });
      }
    });
  }
}