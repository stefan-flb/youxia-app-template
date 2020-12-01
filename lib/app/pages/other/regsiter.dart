import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../services/utils.dart';
import '../../component/component.dart';
import '../../component/dialog.dart';
import '../../../api/api.dart';


class RegsiterPages extends StatefulWidget{
  createState() => _RegsiterPages();
}

class _RegsiterPages extends State {
  // 用户名
  var userAccount = TextEditingController();
  // 密码
  var userPassword = TextEditingController();
  // 确认密码
  var userConfirmPassword = TextEditingController();
  // 手机号码
  var mobilePhone = TextEditingController();
  // 姓名
  var name = TextEditingController();
  // 邮箱
  var email = TextEditingController();
  // 介绍人
  var introducer = TextEditingController();

  // 是否显示密码
  var isShowPassword = true;
  @override
  initState() {
    super.initState();
  }
  Widget build(BuildContext context) {
    Screen.init(context);
    // TODO: implement build
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {FocusScope.of(context).requestFocus(FocusNode());},
        child: Scaffold(
            appBar: HeadersComponent.Appbars(Text('注册', style: TextStyle(fontSize: Screen.width(32)),)),
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
                              margin: EdgeInsets.only(top: Screen.width(30)),
                              child: Image.asset('images/home/banner_01.jpg', fit: BoxFit.contain,),
                            )
                        ),
                      ]
                  ),
                  SizedBox(height: Screen.width(50),),
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
                  SizedBox(height: Screen.width(5),),
                  Text('请输入6-15位且必须包含英文和数字的账号', style: TextStyle(fontSize: Screen.width(24), color: Colors.grey), textAlign: TextAlign.center,),

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
                  SizedBox(height: Screen.width(5),),
                  Text('请输入6-15位且必须包含英文和数字的账号', style: TextStyle(fontSize: Screen.width(24), color: Colors.grey), textAlign: TextAlign.center,),

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
                            hintText: '请确认密码', border: InputBorder.none, labelText: '请确认密码', labelStyle: TextStyle(color: Colors.grey , fontSize: Screen.width(28)),
                            prefixIcon: Icon(Icons.lock_outline, color: Colors.grey, size: Screen.width(60)),
                            suffixIcon: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              child: Icon(isShowPassword ? Icons.visibility_off : Icons.visibility, color: Colors.grey, size: Screen.width(50)),
                              onTap: () {
                                setState(() {isShowPassword = !isShowPassword;});
                              },
                            )
                        ),
                        controller: userConfirmPassword,
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
                        inputFormatters: [
                          WhitelistingTextInputFormatter(RegExp("[0-9]")),
                          LengthLimitingTextInputFormatter(11)
                        ],
                        style: TextStyle(fontSize: Screen.width(30), height: Screen.width(2.2)),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: Screen.width(10), bottom: Screen.width(8)),
                            hintText: '请输入手机号码', border: InputBorder.none, labelText: '请输入手机号码', labelStyle: TextStyle(color: Colors.grey , fontSize: Screen.width(28)),
                            prefixIcon: Icon(Icons.phone, color: Colors.grey, size: Screen.width(60))
                        ),
                        controller: mobilePhone,
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
                        inputFormatters: [
                          WhitelistingTextInputFormatter(RegExp("[\u4e00-\u9fa5]")),
                          LengthLimitingTextInputFormatter(15)
                        ],
                        style: TextStyle(fontSize: Screen.width(30), height: Screen.width(2.2)),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: Screen.width(10), bottom: Screen.width(8)),
                            hintText: '请输入姓名', border: InputBorder.none, labelText: '请输入姓名', labelStyle: TextStyle(color: Colors.grey , fontSize: Screen.width(28)),
                            prefixIcon: Icon(Icons.mode_edit, color: Colors.grey, size: Screen.width(60))
                        ),
                        controller: name,
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
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(20)
                        ],
                        style: TextStyle(fontSize: Screen.width(30), height: Screen.width(2.2)),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: Screen.width(10), bottom: Screen.width(8)),
                            hintText: '请输入邮箱', border: InputBorder.none, labelText: '请输入邮箱', labelStyle: TextStyle(color: Colors.grey , fontSize: Screen.width(28)),
                            prefixIcon: Icon(Icons.email, color: Colors.grey, size: Screen.width(56))
                        ),
                        controller: email,
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
                        inputFormatters: [
                          WhitelistingTextInputFormatter(RegExp("[a-zA-Z]|[0-9.]")),
                          LengthLimitingTextInputFormatter(15)
                        ],
                        style: TextStyle(fontSize: Screen.width(30), height: Screen.width(2.2)),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(top: Screen.width(10), bottom: Screen.width(8)),
                            hintText: '请输入介绍人(可不填)', border: InputBorder.none, labelText: '请输入介绍人(可不填)', labelStyle: TextStyle(color: Colors.grey , fontSize: Screen.width(28)),
                            prefixIcon: Icon(Icons.supervised_user_circle, color: Colors.grey, size: Screen.width(60))
                        ),
                        controller: introducer,
                      )
                  ),

                  SizedBox(height: Screen.width(30),),
                  ButtonComponent.material(title: '注 册', width: 1.0, height: 95, radius: 60, pressed: () async {
                    if(userAccount.text == '' || userAccount.text == null || userAccount.text.length < 6) {
                      DialogComponents.toast(context, content: '请输入正确的用户名 ! ');
                      return;
                    } else if(userPassword.text == '' || userPassword.text == null || userPassword.text.length < 6) {
                      DialogComponents.toast(context, content: '请输入正确的密码 ! ');
                      return;
                    } else if(userPassword.text != userConfirmPassword.text) {
                      DialogComponents.toast(context, content: '两次密码输入不一致 ! ');
                      return;
                    } else if(!Regular.isChinaPhoneLegal(mobilePhone.text)) {
                      DialogComponents.toast(context, content: '请输入正确的手机号码 ! ');
                      return;
                    } else if(!Regular.isEmail(email.text)) {
                      DialogComponents.toast(context, content: '请输入正确的邮箱 ! ');
                      return;
                    } else if(!Regular.isChinese(name.text) || name.text.length < 2) {
                      DialogComponents.toast(context, content: '请输入正确的姓名 ! ');
                      return;
                    }
                  var data = {
                    'username': userAccount.text,
                    'password': Utils.password(userPassword.text),
                    'phone': mobilePhone.text,
                    'email': email.text,
                    'reailyName': name.text,
                    'recommend': introducer.text,
                  };
                  // var response = await Api.register(data);
                  // print(response);
                  // if(response['success']) {
                  //   Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false, arguments: {
                  //     'autoLogin': false,
                  //     'username': userAccount.text,
                  //     'password': Utils.password(userPassword.text),
                  //   });
                  // }

                  },),
                  SizedBox(height: Screen.width(30),),
                ],
              ),
            )
        )
    );
  }
}