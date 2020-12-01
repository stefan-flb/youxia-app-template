import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../services/utils.dart';
import '../../../../api/api.dart';
import '../../../component/component.dart';
import '../../../component/dialog.dart';

class ChangePassword extends StatefulWidget{
  ChangePassword({Key key});
  _ChangePassword createState() => _ChangePassword();
}

class _ChangePassword extends State with SingleTickerProviderStateMixin {
  var userInfo = {};

  var tabController;
  var typeIndex = 0;
  var passwordOld = TextEditingController();
  var passwordNew = TextEditingController();
  var passwordConfigNew = TextEditingController();

  @override
  initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(() {
      print(tabController.index);
      setState(() {
        passwordOld.text = passwordNew.text = passwordConfigNew.text = '';
      });
    });
    Storage.getString('userDetail').then((response) {
      if(response != null) {
        setState(() {
          userInfo = json.decode(response);
        });
      }
    });

  }
  dispose() {
    super.dispose();
    tabController.dispose();
  }
  Widget build(BuildContext context) {


    Screen.init(context);
    // TODO: implement build
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {FocusScope.of(context).requestFocus(FocusNode());},
        child: Scaffold(
            appBar: HeadersComponent.Appbars(Text('修改${typeIndex == 0 ? '登陆': '资金'}密码', style: TextStyle(fontSize: Screen.width(32)),)),
            body: Container(
                color: ColorGather.colorBg(),
                child: Column(
                  children: <Widget>[
                   Container(
                     color: Colors.white,
                     child: TabBar(
                       controller: tabController,
                       labelPadding: EdgeInsets.all(0),
                       indicatorColor: ColorGather.colorMain(),
                       tabs: <Widget>[
                         Tab(child: Text('修改登陆密码', style: TextStyle(fontSize: Screen.width(28), color: Colors.black87),)),
                         Tab(child: Text(' ${!userInfo["fund_password"] ? "设置登陆密码" : "修改登陆密码"}', style: TextStyle(fontSize: Screen.width(28), color: Colors.black87),)),
                       ],
                     ),
                   ),
                    Expanded(
                      child: TabBarView(
                        controller: tabController,
                        children: <Widget>[
                          ListView(
                            children: <Widget>[
                              SizedBox(height: Screen.width(20),),
                              InputComponent.text(
                                  labelText: '请输入旧登录密码', obscureText: false, controller: passwordOld,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(18)
                                  ]),
                              SizedBox(height: Screen.width(20),),
                              InputComponent.text(
                                  labelText: '请输入新登录密码', obscureText: true, controller: passwordNew,
                                  inputFormatters: [
                                    WhitelistingTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(18)
                                  ]),
                              Divider(height: 0,),
                              InputComponent.text(
                                  labelText: '请确认新登录密码', obscureText: true, controller: passwordConfigNew,
                                  inputFormatters: [
                                    WhitelistingTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(18)
                                  ]),
                              SizedBox(height: Screen.width(20),),
                              ButtonComponent.material(title: '确认修改', pressed: () async{
                                if(passwordOld.text.isEmpty || passwordNew.text.isEmpty || passwordConfigNew.text.isEmpty || passwordOld.text.length < 7 || passwordNew.text.length < 7 || passwordConfigNew.text.length < 7) {
                                  DialogComponents.toast(context, content: '请填写正确的密码');
                                  return;
                                } else if(passwordNew.text != passwordConfigNew.text) {
                                  DialogComponents.toast(context, content: '两次新密码输入不一致');
                                  return;
                                } else if(passwordOld.text == passwordNew.text) {
                                  DialogComponents.toast(context, content: '新密码不能和旧密码相同');
                                  return;
                                }
                                // var data = {
                                //   'id': userInfo['user_id'],
                                //   'username': userInfo['username'],
                                //   'old_password': passwordOld.text,
                                //   'password': Utils.password(passwordNew.text),
                                //   'password_confirm': Utils.password(passwordConfigNew.text),
                                // };
                                // var response = await Api.changeLoginPassword(data);
                                // if(response['success']) {
                                //   DialogComponents.toast(context, content: response['msg']);
                                //   setState(() {
                                //     passwordOld.text = passwordNew.text = passwordConfigNew.text = '';
                                //   });
                                // }

                              },),
                            ],
                          ),
                          userInfo['fund_password'] ? ListView(
                            children: <Widget>[
                              SizedBox(height: Screen.width(20),),
                              InputComponent.text(
                                  labelText: '请输入旧资金密码', obscureText: false, controller: passwordOld,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(18)
                                  ]),
                              SizedBox(height: Screen.width(20),),
                              InputComponent.text(
                                  labelText: '请输入新资金密码', obscureText: true, controller: passwordNew,
                                  inputFormatters: [
                                    WhitelistingTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(18)
                                  ]),
                              Divider(height: 0,),
                              InputComponent.text(
                                  labelText: '请确认新资金密码', obscureText: true, controller: passwordConfigNew,
                                  inputFormatters: [
                                    WhitelistingTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(18)
                                  ]),
                              SizedBox(height: Screen.width(20),),
                              ButtonComponent.material(title: '确认修改', pressed: () async{
                                if(passwordOld.text.isEmpty || passwordNew.text.isEmpty || passwordConfigNew.text.isEmpty || passwordOld.text.length < 7 || passwordNew.text.length < 7 || passwordConfigNew.text.length < 7) {
                                  DialogComponents.toast(context, content: '请填写正确的密码');
                                  return;
                                } else if(passwordNew.text != passwordConfigNew.text) {
                                  DialogComponents.toast(context, content: '两次新密码输入不一致');
                                  return;
                                } else if(passwordOld.text == passwordNew.text) {
                                  DialogComponents.toast(context, content: '新密码不能和旧密码相同');
                                  return;
                                }
                                // var data = {
                                //   'id': userInfo['user_id'],
                                //   'username': userInfo['username'],
                                //   'old_password': passwordOld.text,
                                //   'password': Utils.password(passwordNew.text),
                                //   'password_confirm': Utils.password(passwordConfigNew.text),
                                // };
                                // var response = await Api.changeFundPassword(data);
                                // if(response['success']) {
                                //   DialogComponents.toast(context, content: response['msg']);
                                //   setState(() {
                                //     passwordOld.text = passwordNew.text = passwordConfigNew.text = '';
                                //   });
                                // }
                              },),
                            ],
                          ) : ListView(
                            children: <Widget>[
                              SizedBox(height: Screen.width(20),),
                              InputComponent.text(
                                  labelText: '请输入新资金密码', obscureText: true, controller: passwordNew,
                                  inputFormatters: [
                                    WhitelistingTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(18)
                                  ]),
                              Divider(height: 0,),
                              InputComponent.text(
                                  labelText: '请确认新资金密码', obscureText: true, controller: passwordConfigNew,
                                  inputFormatters: [
                                    WhitelistingTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(18)
                                  ]),
                              SizedBox(height: Screen.width(20),),
                              ButtonComponent.material(title: '确认设置', pressed: () async{
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
                                // var data = {
                                //   'password': Utils.password(passwordNew.text),
                                //   'password_confirm': Utils.password(passwordConfigNew.text),
                                // };
                                // var response = await Api.setFundPassword(data);
                                // if(response['success']) {
                                //   DialogComponents.toast(context, content: response['msg']);
                                //   setState(() {
                                //     passwordNew.text = passwordConfigNew.text = '';
                                //   });
                                // }
                              },),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                )
            ),
        )
    );
  }
}