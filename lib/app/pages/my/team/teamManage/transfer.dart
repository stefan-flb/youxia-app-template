import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../services/utils.dart';
import '../../../../../api/api.dart';
import '../../../../component/component.dart';
import '../../../../component/dialog.dart';
import '../../../../component/picker.dart';

class TransferPages extends StatefulWidget{
  var arguments;
  TransferPages({this.arguments});
  createState() => _TransferPages(this.arguments);
}

class _TransferPages extends State {
  var arguments;

  var money = TextEditingController();
  var password = TextEditingController();
  var bankNum = TextEditingController();
  var bankIndex = 0;
  var bankName = '请选择银行卡';


  _TransferPages(this.arguments);
  @override
  initState() {
    super.initState();
  }
  Widget build(BuildContext context) {
    Screen.init(context);
    // TODO: implement build
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {FocusScope.of(context).requestFocus(FocusNode());},
      child: Scaffold(
          appBar: HeadersComponent.Appbars(
            Text('上下级转账', style: TextStyle(fontSize: Screen.width(32)),),
          ),
          body: Container(
            width: double.infinity,
            color: ColorGather.colorBg(),
            child: ListView(
              children: <Widget>[
                ListTitleComponent(
                  trailingShow: false,
                  leading: Text('账户余额:', style: TextStyle(fontSize: Screen.width(28))),
                  title: Text('${arguments['userDetails']['balance']}', style: TextStyle(fontSize: Screen.width(28), color: Colors.grey)),
                ),
                Divider(height: 0,),
                ListTitleComponent(
                  trailingShow: false,
                  leading: Text('收款账号:', style: TextStyle(fontSize: Screen.width(28))),
                  title: Text('${arguments['list']['username']}', style: TextStyle(fontSize: Screen.width(28), color: Colors.grey)),
                ),
                Divider(height: 0,),
                InputComponent.text(
                    labelText: '转账金额:', hintText: '请输入转账金额', controller: money, labelColor: Colors.black,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(19)
                    ]),
                Divider(height: 0,),
                InputComponent.text(
                    labelText: '资金密码:', hintText: '请输入资金密码', controller: password, labelColor: Colors.black, obscureText: true,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(19)
                    ]),
                Divider(height: 0,),
                ListTitleComponent(
                  trailingShow: false,
                  leading: Text('安全校验:', style: TextStyle(fontSize: Screen.width(28))),
                  title: Row(
                    children: <Widget>[
                      Text('${bankName}', style: TextStyle(fontSize: Screen.width(28))),
                      SizedBox(width: Screen.width(20),),
                      Icon(Icons.keyboard_arrow_down, size: Screen.width(50), color: Colors.grey,)
                    ],
                  ),
                  onTap: () async{
                    var list = [arguments['bankList'].map((val) {
                      return val['bank_name'] + ' ' + val['card_num'];
                    }).toList()];
                    PickerTool.showArrayPicker(context,
                        data: list, normalIndex: [0],
                        clickCallBack:(index, strData) async{
                          print(index); print(strData);
                          setState(() {
                            bankIndex = index[0];
                            bankName = strData[0];
                          });
                        }
                    );
                  },
                ),
                Divider(height: 0,),
                InputComponent.text(
                    labelText: '银行卡号:', hintText: '请输入完整的银行卡号', controller: bankNum, labelColor: Colors.black,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(19)
                    ]),

                SizedBox(height: Screen.width(30),),
                ButtonComponent.material(title: '确认转账', pressed: () async{
                  if(money.text.isEmpty) {
                    DialogComponents.toast(context, content: '请填写转账金额');
                    return;
                  } else if(password.text.isEmpty || password.text.length < 7) {
                    DialogComponents.toast(context, content: '请填写正确的资金密码');
                    return;
                  } else if(bankName == '请选择银行卡') {
                    DialogComponents.toast(context, content: '请选择校验银行卡');
                    return;
                  } else if(bankNum.text.isEmpty) {
                    DialogComponents.toast(context, content: '请填写银行卡号');
                    return;
                  } else if(bankNum.text.length != 16 && bankNum.text.length != 19) {
                    DialogComponents.toast(context, content: '请正确的16位或19位卡号');
                    return;
                  }
                  var data = {
                    'amount': money.text,
                    'bank_card_id': arguments['bankList'][bankIndex]['id'],
                    'bank_card_number': bankNum.text,
                    'fund_password': Utils.password(password.text),
                    'user_id': arguments['list']['hash_id']
                  };

                  // var response = await Api.transferToChild(data);
                  // if (response['success']) {
                  //   DialogComponents.toast(context, content: response['msg']);
                  //   Navigator.pop(context, {'amount': money.text});
                  // }
                },),
              ],
            ),
          )
      ),
    );
  }
}