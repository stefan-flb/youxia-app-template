import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../services/utils.dart';
import '../../../../api/api.dart';
import '../../../component/component.dart';
import '../../../component/dialog.dart';


class AddBankValidation extends StatefulWidget{
  var arguments;
  AddBankValidation({Key key, this.arguments});
  _AddBankValidation createState() => _AddBankValidation(this.arguments);
}

class _AddBankValidation extends State {
  var arguments;
  var fundPassword = TextEditingController();
  var ownerName = TextEditingController();

  _AddBankValidation(this.arguments);
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
            appBar: HeadersComponent.Appbars(Text('绑卡信息验证', style: TextStyle(fontSize: Screen.width(32)),)),
            body: Container(
              alignment: Alignment.centerLeft,
              width: double.infinity,
              color: ColorGather.colorBg(),
              child: ListView(
                children: <Widget>[
                  Offstage(
                    offstage: arguments['cards'].length == 0,
                    child: InputComponent.text(
                        labelText: '开户人姓名', obscureText: true, controller: ownerName,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(18)
                        ]),
                  ),
                  Divider(height: 0,),
                  InputComponent.text(
                      labelText: '资金密码', obscureText: true, controller: fundPassword,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(18)
                      ]),
                  SizedBox(height: Screen.width(20),),
                  ButtonComponent.material(
                      title: '确认',
                      pressed: () async {
                        if (fundPassword.text == '' ||  ownerName.text == '' || !Regular.isChinese(ownerName.text)) {
                          DialogComponents.toast(context, content: '请填写正确的信息');
                          return;
                        } else if (fundPassword.text.length < 3) {
                          DialogComponents.toast(context, content: '姓名最少两位字符');
                          return;
                        } else if (fundPassword.text.length < 7) {
                          DialogComponents.toast(context, content: '密码不能小于6位');
                          return;
                        }
                        var data = {
                          'fund_password': fundPassword.text,
                          'owner_name': ownerName.text,
                        };
                        // var response = await Api.bindCardCheck(data);
                        // print(response);
                        // if(response['success']) {
                        //   setState(() {
                        //     fundPassword.text = ownerName.text = '';
                        //   });
                        //   Navigator.pushReplacementNamed(context, '/bank');
                        // }
                      })
                ],
              ),
            )
        )
    );
  }
}