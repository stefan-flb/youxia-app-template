import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../../../services/utils.dart';
import '../../../services/state.dart';
import '../../component/component.dart';
import '../../component/dialog.dart';
import '../../../api/api.dart';



class LoginPages extends StatefulWidget{
  var arguments;
  LoginPages({this.arguments});
  createState() => _LoginPages(this.arguments);
}

class _LoginPages extends State {
  var arguments;
  // 用户名
  var userAccount = TextEditingController();
  // 密码
  var userPassword = TextEditingController();
  // 是否显示密码
  var isShowPassword = true;
  // 自动登录
  var autoLogin = false;
  // 记住密码
  var rememberPassword = false;
  _LoginPages(this.arguments);


  @override
  initState() {
    super.initState();

    userAccount.text = 'test1980';
//    userPassword.text = 'ZVdOa056Y3hNak0wY1hkbGNnPT1wZ3Rn';
    Storage.getBool('autoLogin').then((val) {
      if (val != null) {
        setState(() {autoLogin = val;});
      }
    });
    Storage.getString('rememberPassword').then((val) {
      if (val != null) {
        var data = json.decode(val);
        print(data);
        setState(() {
          userAccount.text = data['account'];
          userPassword.text = data['password'];
          rememberPassword = true;
        });
      }
    });
    if(arguments['username'] != '') {
      setState(() {
        userAccount.text = arguments['username'];
        userPassword.text = arguments['password'];
      });
    }
    // 手动退出登录   不自动登录
    if(!arguments['autoLogin']) {
      autoLogin = false;
    }

    if(autoLogin && userAccount.text != null && userPassword.text != null) {
      // 自动登录
      useLogin();
    }
  }
  Widget build(BuildContext context) {
    globeBuildContext = context;
    Screen.init(context);
    // TODO: implement build
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {FocusScope.of(context).requestFocus(FocusNode());},
        child: Scaffold(
          appBar: HeadersComponent.Appbars(
              Text('登录', style: TextStyle(fontSize: Screen.width(32)),),
              showLeading: false
          ),
          body: Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: Screen.width(70), right: Screen.width(70)),
            child: ListView(
              children: <Widget>[
                Column(
                    children: <Widget>[
                      ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: Screen.width(400),
                            maxHeight: Screen.width(400),
                          ),
                          child: Container(
                            margin: EdgeInsets.only(top: Screen.width(120)),
                            child: Image.asset('images/home/banner_01.jpg', fit: BoxFit.contain,),
                          )
                      ),
                    ]
                ),
                SizedBox(height: Screen.width(80),),
                Container(
                    padding: EdgeInsets.only(left: Screen.width(10)),
                    decoration: BoxDecoration(
                        border: Border.all(width: Screen.width(1), color: Colors.grey),
                        borderRadius: BorderRadius.circular(Screen.width(60))
                    ),
                    child: TextField(
                      inputFormatters: [
                        WhitelistingTextInputFormatter(RegExp("[a-zA-Z]|[0-9]")),
                        LengthLimitingTextInputFormatter(15)
                      ],
                      style: TextStyle(fontSize: Screen.width(30), height: Screen.width(2.2)),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(top: Screen.width(10), bottom: Screen.width(8)),
                        hintText: '请输入账号', hintStyle: TextStyle(fontSize: Screen.width(28)), border: InputBorder.none, labelText: '请输入账号', labelStyle: TextStyle(color: Colors.grey, fontSize: Screen.width(28)),
                        prefixIcon: Icon(Icons.person_outline, color: Colors.grey, size: Screen.width(65)),
                      ),
                      controller: userAccount,
                    )
                ),

                Container(
                    margin: EdgeInsets.only(top: Screen.width(25)),
                    padding: EdgeInsets.only(left: Screen.width(10)),
                    decoration: BoxDecoration(
                        border: Border.all(width: Screen.width(1), color: Colors.grey),
                        borderRadius: BorderRadius.circular(Screen.width(60))
                    ),
                    child: TextField(
                      obscureText: isShowPassword,
                      inputFormatters: [
                        WhitelistingTextInputFormatter(RegExp("[a-zA-Z]|[0-9.]")),
                        LengthLimitingTextInputFormatter(15)
                      ],
                      style: TextStyle(fontSize: Screen.width(30), height: Screen.width(2.2)),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: Screen.width(10), bottom: Screen.width(8)),
                          hintText: '请输入密码', border: InputBorder.none, labelText: '请输入密码', labelStyle: TextStyle(color: Colors.grey , fontSize: Screen.width(28)),
                          prefixIcon: Icon(Icons.lock_outline, color: Colors.grey, size: Screen.width(60)),
                          suffixIcon: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            child: Icon(isShowPassword ? Icons.visibility_off : Icons.visibility, color: Colors.grey, size: Screen.width(50)),
                            onTap: () {
                              setState(() {isShowPassword = !isShowPassword;});
                            },
                          )
                      ),
                      controller: userPassword,
                    )
                ),

                SizedBox(height: Screen.width(30),),
                ButtonComponent.material(title: '登 录', width: 1.0, height: 95, radius: 60, pressed: () async{
//                  if(userAccount.text == '' || userAccount.text == null) {
//                    DialogComponents.toast(context, content: '请输入正确的用户名 ! ');
//                    return;
//                  } else if(userPassword.text == '' || userPassword.text == null || userPassword.text.length < 6) {
//                    DialogComponents.toast(context, content: '请输入正确的密码 ! ');
//                    return;
//                  }
                  useLogin();
                },),
                SizedBox(height: Screen.width(25),),
                ButtonComponent.outline(
                  title: '注 册', width: 1.0, height: 95, radius: 60, textColor: ColorGather.colorMain(),
                  pressed: () { Navigator.pushNamed(context, '/regsiter');
                  },),

                ListTitleComponent(
                  color: null,
                  title: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Text('忘记密码?', style: TextStyle(fontSize: Screen.width(26), color: Colors.grey)),
                    onTap: () {
                      DialogComponents.toast(context, content: '忘记密码, 请联系客服!!!');
                    },
                  ),
                  trailing: Row(children: <Widget>[
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: Row(children: <Widget>[
                        Visibility(
                          replacement: Icon(Icons.check_box_outline_blank, size: Screen.width(40), color: Colors.grey,),
                          child: Icon( Icons.check_box, size: Screen.width(40), color: ColorGather.colorMain(),),
                          visible: autoLogin,
                        ),
                        SizedBox(width: Screen.width(5),),
                        Text('自动登录', style: TextStyle(fontSize: Screen.width(26), color: Colors.grey)),
                      ],),
                      onTap: () {
                        setState(() {
                          autoLogin = !autoLogin;
                          rememberPassword = autoLogin;
                        });
                      },
                    ),
                    SizedBox(width: Screen.width(25),),

                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child:Row(children: <Widget>[
                        Visibility(
                          replacement: Icon(Icons.check_box_outline_blank, size: Screen.width(40), color: Colors.grey,),
                          child: Icon( Icons.check_box, size: Screen.width(40), color: ColorGather.colorMain(),),
                          visible: rememberPassword,
                        ),
                        SizedBox(width: Screen.width(5),),
                        Text('记住密码', style: TextStyle(fontSize: Screen.width(26), color: Colors.grey)),
                      ],),
                      onTap: () {
                        setState(() {rememberPassword = !rememberPassword;});
                      },
                    ),
                  ],),
                ),
              ],
            ),
          ),
        )
    );

  }
  useLogin() async {
    Navigator.pushNamed(context, '/index');
    return;
    var data = {
      'username': userAccount.text,
      'password': Utils.password(userPassword.text),
    };
    var response = await Api.login(data);
    if(response['success']) {
      Storage.setString('token', response['data']['access_token']);

      var userDetail = await Api.userDetail(params: '1');
      if(userDetail['success']) {
        Storage.setString('userDetail', json.encode(userDetail['data']));
        Navigator.pushNamed(context, '/index');
        if(rememberPassword) {
          var data = {
            'account': userAccount.text,
            'password': Utils.password(userPassword.text),
          };
          Storage.setString('rememberPassword', json.encode(data));
        } else {
          Storage.remove('rememberPassword');
        }

        if(autoLogin) {
          Storage.setBool('autoLogin', true);
        } else {
          Storage.remove('autoLogin');
        }
      }

    }
  }
}