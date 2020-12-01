import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../services/utils.dart';
import '../../../../api/api.dart';
import '../../../component/component.dart';
import '../../../component/dialog.dart';
import '../../../home.dart';


class SetPasswordPages extends StatefulWidget{
  SetPasswordPages({Key key});
  _SetPasswordPages createState() => _SetPasswordPages();
}

class _SetPasswordPages extends State {
  var passwordNew = TextEditingController();
  var passwordConfigNew = TextEditingController();
  var userDetails = {};
  @override
  initState() {
    super.initState();
    // 获取下级
    Storage.getString('userDetail').then((res) {
      if(res != null) {
        var data = json.decode(res);
        setState(() {
          userDetails = data;
        });
      }
    });
  }
  Widget build(BuildContext context) {
    Screen.init(context);
    // TODO: implement build
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {FocusScope.of(context).requestFocus(FocusNode());},
        child: Scaffold(
            appBar: HeadersComponent.Appbars(Text('设置资金密码', style: TextStyle(fontSize: Screen.width(32)),)),
            body: Container(
              alignment: Alignment.centerLeft,
              width: double.infinity,
              padding: EdgeInsets.only(right: Screen.width(15)),
              color: ColorGather.colorBg(),
              child: ListView(
                children: <Widget>[
                  InputComponent.text(
                      labelText: '请输入新密码', obscureText: true, controller: passwordNew,
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(18)
                      ]),
                  Divider(height: 0,),
                  InputComponent.text(
                      labelText: '请确认新密码', obscureText: true, controller: passwordConfigNew,
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(18)
                      ]),
                  SizedBox(height: Screen.width(20),),
                  ButtonComponent.material(
                      title: '确认',
                      pressed: () async {
                        if (passwordNew.text == '' || passwordConfigNew.text == '') {
                          DialogComponents.toast(context, content: '请输入密码');
                          return;
                        } else if (passwordNew.text.length < 7 || passwordConfigNew.text.length < 7) {
                          DialogComponents.toast(context, content: '密码不能小于6位');
                          return;
                        } if (passwordNew.text != passwordConfigNew.text) {
                          DialogComponents.toast(context, content: '两次密码输入不一致');
                          return;
                        }
                        var data = {
                          'password': Utils.password(passwordNew.text),
                          'password_confirm': Utils.password(passwordConfigNew.text),
                        };
                        // var response = await Api.setFundPassword(data);
                        // if(response['success']) {
                        //   DialogComponents.toast(context, content: '设置成功');
                        //   setState(() {
                        //     passwordNew.text = passwordConfigNew.text = '';
                        //     userDetails['fund_password'] = true;
                        //   });
                        //   Storage.setString('userDetail', json.encode(userDetails));
                        //   Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => HomePages(currentIndex: 1,)), (route) => route == null);
                        // }
                      })
                ],
              ),
            )
        )
    );
  }
}