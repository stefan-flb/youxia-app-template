import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../services/utils.dart';
import '../../../../api/api.dart';
import '../../../component/component.dart';
import '../../../component/dialog.dart';
import '../../../component/picker.dart';

class WithdrawalPages extends StatefulWidget {
  var arguments;
  WithdrawalPages({this.arguments});
  createState() => new _WithdrawalPages(this.arguments);
}
class _WithdrawalPages extends State {
  var arguments;
  _WithdrawalPages(this.arguments);
  var bankList = [];
  var withdrawaCount = '';
  var withdrawaMoneyMin = '';
  var withdrawaMoneyMax = '';
  var bankPickerData = [
    ["11","22"]
  ];
  var showPicker = '请先择银行卡';
  var bankPickerIndex = 0;
  // 提现金额
  var withdrawalMoney = TextEditingController();
  // 提现密码
  var withdrawalPassword = TextEditingController();
  // 提现银行卡
  var withdrawalBank;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(arguments['bankList']);
    // 给姓名加上星号
    for(var i = 0; i < arguments['bankList'].length; i++) {
      arguments['bankList'][i]['modifyName'] = arguments['bankList'][i]['owner_name'].substring(0, 1);
      for(var j = 0; j < arguments['bankList'][i]['owner_name'].length - 1; j++) {
        arguments['bankList'][i]['modifyName'] += '*';
      }
    }
    _init();
  }
  @override
  Widget build(BuildContext context) {
    Screen.init(context);
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {FocusScope.of(context).requestFocus(FocusNode());},
        child: Scaffold(
            appBar: HeadersComponent.Appbars(Text('提现申请', style: TextStyle(fontSize: Screen.width(32)),)),
            body: Container(
              color: ColorGather.colorBg(),
              child: ListView(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: Screen.width(25), bottom: Screen.width(22), left: Screen.width(25)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                              style: TextStyle(fontSize: Screen.width(28), color: Colors.black),
                              children: [
                                TextSpan(text: '请填写正确的出款资料, 今日剩余提款次数 '),
                                TextSpan(text: '${withdrawaCount}', style: TextStyle(color: ColorGather.colorMain())),
                                TextSpan(text: ' 次'),
                              ]
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                              style: TextStyle(fontSize: Screen.width(28), color: Colors.black),
                              children: [
                                TextSpan(text: '最小金额为 '),
                                TextSpan(text: '${withdrawaMoneyMin}', style: TextStyle(color: ColorGather.colorMain())),
                                TextSpan(text: ' 元,'),
                                TextSpan(text: ' 最大金额为 '),
                                TextSpan(text: '${withdrawaMoneyMax}', style: TextStyle(color: ColorGather.colorMain())),
                                TextSpan(text: ' 元'),
                              ]
                          ),
                        ),
                      ],
                    )
                  ),
                  ListTitleComponent(
                    trailingShow: false,
                    leading: Text(' 用 户 名 :', style: TextStyle(fontSize: Screen.width(28))),
                    title: Text('${arguments['bankList'][0]['modifyName']}', style: TextStyle(fontSize: Screen.width(28), color: Colors.grey)),
                  ),
                  Divider(height: 0,),
                  ListTitleComponent(
                    trailingShow: false,
                    leading: Text('当前余额:', style: TextStyle(fontSize: Screen.width(28))),
                    title: Text('${arguments['userDetail']['balance']}', style: TextStyle(fontSize: Screen.width(28), color: Colors.grey)),
                  ),
                  Divider(height: 0,),
                  ListTitleComponent(
                    trailingShow: false,
                    leading: Text(' 银 行 卡 :', style: TextStyle(fontSize: Screen.width(28))),
                    title: Row(
                      children: <Widget>[
                        Text('${showPicker}', style: TextStyle(fontSize: Screen.width(28))),
                        SizedBox(width: Screen.width(5),),
                        Icon(Icons.keyboard_arrow_down, size: Screen.width(50), color: Colors.grey,)
                      ],
                    ),
                    onTap: () {
                      var list = [arguments['bankList'].map((val) {
                        return val['modifyName'] + '  ' + val['bank_name'];
//                        + val['card_num']
                      }).toList()];
                      PickerTool.showArrayPicker(context,
                          data: list, normalIndex: [0],
                          clickCallBack:(index, strData){
                            print(index); print(strData);
                            setState(() {
                              bankPickerIndex = index[0];
                              showPicker = strData[0];
                            });
                          }
                      );
                    },
                  ),
                  Divider(height: 0,),
                  InputComponent.text(
                      labelText: '提现金额:', hintText: '输入提现金额', controller: withdrawalMoney, labelColor: Colors.black,
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(20)
                      ],
                    changed: (val) {
                        if(int.parse(withdrawalMoney.text) > int.parse(withdrawaMoneyMax)) {
                          withdrawalMoney.text = withdrawaMoneyMax;
                        }
                    }
                  ),
                  Divider(height: 0,),
                  InputComponent.text(
                      labelText: '资金密码:', hintText: '输入资金密码', controller: withdrawalPassword, labelColor: Colors.black, obscureText: true,
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(20)
                      ]),
                  SizedBox(height: Screen.width(30),),
                  ButtonComponent.material(title: '确认提现', pressed: () async {
                    if(withdrawalMoney.text.isEmpty) {
                      DialogComponents.toast(context, content: '请输入提现金额');
                      return;
                    } else if(withdrawalPassword.text.isEmpty || withdrawalPassword.text.length < 7) {
                      DialogComponents.toast(context, content: '请输入正确的资金密码');
                      return;
                    } else if(int.parse(arguments['userDetail']['balance']) < int.parse(withdrawalMoney.text)) {
                      DialogComponents.toast(context, content: '余额不足');
                      return;
                    }
                    var data = {
                      'amount': withdrawalMoney.text,
                      'card_id': arguments['bankList'][bankPickerIndex]['id'],
                      'fund_password': Utils.password(withdrawalPassword.text),
                    };
                    // var response = await Api.withdraw(data);
                    // if (response['success']) {
                    //   DialogComponents.toast(context, content: response['msg']);
                    // }
                  },),
                ],
              ),
            )
        )
    );
  }

  _init() async{
    // 获取提示信息
    // var WithdrawalRemainingTimes = await Api.configureList(data: {'type': 'Withdrawal_remaining_times'});
    // print(WithdrawalRemainingTimes);
    // if (WithdrawalRemainingTimes['success']) {
    //   setState(() {withdrawaCount = '${WithdrawalRemainingTimes['data']}';});
    // }
    //
    // var financeRechargeWithdraw = await Api.configureList(data: {'type': 'finance_recharge_withdraw'});
    // print(financeRechargeWithdraw);
    // if (financeRechargeWithdraw['success']) {
    //   setState(() {
    //     withdrawaMoneyMin = financeRechargeWithdraw['data']['finance_min_withdraw'];
    //     withdrawaMoneyMax = financeRechargeWithdraw['data']['finance_max_withdraw'];
    //     withdrawalMoney.text = withdrawaMoneyMin;
    //   });
    // }

  }
}