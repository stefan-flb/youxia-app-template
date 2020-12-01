import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../services/utils.dart';
import '../../../../api/api.dart';
import '../../../component/component.dart';
import '../../../component/dialog.dart';


class RechargePages extends StatefulWidget{
  RechargePages({Key key});
  _RechargePages createState() => _RechargePages();
}

class _RechargePages extends State {
  // 充值方式索引
  var rechargeModeIndex = 0;
  // 充值方式
  var rechargeChannelListKeys = [];
  // 获取的所有充值数据
  var rechargeChannelAll = Map();
  // 充值渠道列表
  var rechargeChannelList = [];
  // 选中的充值渠道
  var radioIndex = 0;
  // 输入的充值金额
  var rechargeMoney = TextEditingController();

  var showBank = false;
  // 提交的充值数据
  var payData = {'from': 1, 'amount': '', 'channel': ''};

  @override
  initState() {
    super.initState();
    _getRechargeChannel();
  }
  // 获取充值数据
  _getRechargeChannel() async{
    // var getRechargeChannel = await Api.getRechargeChannel();
    // if(getRechargeChannel['success']) {
    //   rechargeChannelAll = getRechargeChannel['data'];
    //   setState(() {
    //     rechargeChannelListKeys = rechargeChannelAll.keys.toList();
    //     if(rechargeChannelListKeys.length > 0) {
    //       rechargeChannelList = rechargeChannelAll[rechargeChannelListKeys[0]]['list'];
    //       rechargeMoney.text = '${rechargeChannelList[radioIndex]['min']}';
    //     }
    //   });
    //   print(json.encode(rechargeChannelAll));
    // }
  }

  Widget build(BuildContext context) {
    Screen.init(context);
    // TODO: implement build
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {FocusScope.of(context).requestFocus(FocusNode());},
        child: Scaffold(
            appBar: HeadersComponent.Appbars(Text('充值', style: TextStyle(fontSize: Screen.width(32)),)),
            body: Container(
              alignment: Alignment.centerLeft,
              width: double.infinity,
              color: ColorGather.colorBg(),
              child: ListView(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(bottom: Screen.width(20), top: Screen.width(10)),
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          alignment: Alignment.centerLeft, padding: EdgeInsets.only(left: Screen.width(18), top: Screen.width(30)),
                          child: Text('充值方式', style: TextStyle(fontSize: Screen.width(28))),
                        ),
                        SizedBox(height: Screen.width(20),),
                        GridView.builder(
                            itemCount: rechargeChannelListKeys.length,
                            shrinkWrap: true,
                            physics: new NeverScrollableScrollPhysics(),
                            //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              //横轴元素个数
                                crossAxisCount: 3,
                                //纵轴间距
                                mainAxisSpacing: 0,
                                //横轴间距
                                crossAxisSpacing: 0,
                                //子组件宽高长度比例
                                childAspectRatio: 5 / 2
                            ),
                                itemBuilder: (BuildContext context, int index) {
                                  //Widget Function(BuildContext context, int index)
                                  return GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    child: Container(
                                      margin: EdgeInsets.only(left: Screen.width(18), right: Screen.width(index != 0 && index % 2 == 0 ? 18 : 0), bottom: Screen.width(18)),
                                      width: Screen.width(226), height: Screen.width(70),
                                      decoration: BoxDecoration(
                                          border: Border.all(width: Screen.width(1), color: rechargeModeIndex == index ? ColorGather.colorMain() : Colors.grey),
                                          borderRadius: BorderRadius.all(Radius.circular(Screen.width(10)))
                                      ),
                                      child: Row(
                                        children: <Widget>[
                                          SizedBox(width: Screen.width(10),),
                                          _getRechargeChanneIcon(rechargeChannelListKeys[index]),
                                          SizedBox(width: Screen.width(5),),
                                          Text('${rechargeChannelListKeys[index]}', style: TextStyle(fontSize: Screen.width(25), color: rechargeModeIndex == index ? ColorGather.colorMain() : Colors.black)),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        rechargeModeIndex = index;
                                        rechargeChannelList = rechargeChannelAll[rechargeChannelListKeys[index]]['list'];
                                      });
                                    },
                                   );
                            }),
                        Container(
                          alignment: Alignment.centerLeft, padding: EdgeInsets.only(left: Screen.width(18), top: Screen.width(20)),
                          child: Text('充值渠道', style: TextStyle(fontSize: Screen.width(28))),
                        ),
                        GridView.builder(
                            itemCount: rechargeChannelList.length,
                            shrinkWrap: true,
                            physics: new NeverScrollableScrollPhysics(),
                            //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              //横轴元素个数
                                crossAxisCount: 1,
                                //纵轴间距
                                mainAxisSpacing: 0,
                                //横轴间距
                                crossAxisSpacing: 0,
                                //子组件宽高长度比例
                                childAspectRatio: 12 / 1
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              //Widget Function(BuildContext context, int index)
                              return GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                child: Container(
                                  height: Screen.width(70),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Text('渠道${index + 1}', style: TextStyle(fontSize: Screen.width(26), color: radioIndex == index ? ColorGather.colorMain() : Colors.black)),
                                      Text('最低${rechargeChannelList[index]['min']}', style: TextStyle(fontSize: Screen.width(26), color: radioIndex == index ? ColorGather.colorMain() : Colors.black)),
                                      Text('最高${rechargeChannelList[index]['max']}', style: TextStyle(fontSize: Screen.width(26), color: radioIndex == index ? ColorGather.colorMain() : Colors.black)),
                                      Radio(
                                        value: index, groupValue: radioIndex, activeColor: ColorGather.colorMain(),
                                        onChanged: (val) { setState(() {radioIndex = val;});},
                                      )
                                    ],),
                                ),
                                onTap: () {
                                  setState(() {
                                    radioIndex = index;
                                    rechargeMoney.text = '${rechargeChannelList[radioIndex]['min']}';
                                  });},
                              );
                            }),
                      ],
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: Screen.width(30)),
                    child: InputComponent.text(
                        labelText: '输入充值金额 最低${rechargeChannelList.length > 0 ? rechargeChannelList[radioIndex]['min'] : 0}元', controller: rechargeMoney,
                        changed: (val) {
                          if (int.parse(val) > rechargeChannelList[radioIndex]['max']) {
                            rechargeMoney.text = '${rechargeChannelList[radioIndex]['max']}';
                          }
                        },
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(18),
                          WhitelistingTextInputFormatter.digitsOnly
                        ]),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: Screen.width(30)),
                    child: ButtonComponent.material(title: '确认充值', pressed: () {
                      _submit(context);
                    },),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.only(top: Screen.width(30), left: Screen.width(15), bottom: Screen.height(20), right: Screen.width(15)),
                    padding: EdgeInsets.all(Screen.width(20)),
                    decoration: BoxDecoration(
                        color: ColorGather.colorBgYwllow(),
                        border: Border.all(width: Screen.width(1), color: Color.fromRGBO(255, 252, 183, 1)),
                        borderRadius: BorderRadius.all(Radius.circular(Screen.width(5)))
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('※ 温馨提示：', style: TextStyle(fontSize: Screen.width(24), color: ColorGather.colorFontYwllow())),
                        Text('1. 请不要重复扫描收款二维码进行付款', style: TextStyle(fontSize: Screen.width(24), color: ColorGather.colorFontYwllow())),
                        Text('2. 请实时发起充值申请获取最新的收款卡信息', style: TextStyle(fontSize: Screen.width(24), color: ColorGather.colorFontYwllow())),
                        Text('3. 网银转账渠道需填写正确的附言信息', style: TextStyle(fontSize: Screen.width(24), color: ColorGather.colorFontYwllow())),
                        Text('4. 请确保发起的充值申请金额和付款金额一致，务必不要修改付款金额', style: TextStyle(fontSize: Screen.width(24), color: ColorGather.colorFontYwllow())),
                        Text('5. 为了提升您的充值到账成功率，建议您申请非100的整数倍金额进行充值，例如 101、505、1002等', style: TextStyle(fontSize: Screen.width(24), color: ColorGather.colorFontYwllow())),
                        Text('注：重复扫码、修改付款金额、没有获取最新的收款卡信息等造成的资金损失，平台不予处理，感谢您的配合与理解', style: TextStyle(fontSize: Screen.width(24), color: ColorGather.colorFontYwllow())),
                      ],
                    ),
                  ),
                ],
              ),
            )
        )
    );
  }
  // 提交支付
  _submit (context) async{
    var payDetails = rechargeChannelList[radioIndex];
    if (rechargeMoney.text == '') {
      DialogComponents.toast(context, content: '请输入充值金额');
      return false;
    } else if (int.parse(rechargeMoney.text) < rechargeChannelList[radioIndex]['min']) {
      DialogComponents.toast(context, content: '金额不能 小于 最小充值金额');
      return false;
    }
    if(payDetails['request_mode'] == 1) {
//    if (showBank) {
//      payDetails['bank_code'] = payDetails['banks_code'][this.cur2]['payment_type_sign'];
//    } else {
//      if (payData['bank_code'] != null) {
//        payData.remove('bank_code');
//      }
//    }
      payData['amount'] = rechargeMoney.text;
      payData['channel'] = payDetails['payment_sign'];

      payData.remove('client_channel');
      payData.remove('token');

      // var response = await Api.submitRecharge(payData);
      // if (response['success']) {
      //   rechargeChannelList = response['data'][0];
      // }
    } else {
      var token = await Storage.getString('token');
      var url = Api.domain + 'player/recharge?' + 'amount=${rechargeMoney.text}&channel=${rechargeChannelList[radioIndex]['type_sign']}&client_channel=${rechargeChannelList[radioIndex]['channel_id']}&token=${token}&from=1';
//      launch(url);
    }
  }
  // 支付方式图标
  _getRechargeChanneIcon (val) {
    if(val.contains('支付宝')) {
      return Image.asset('images/myWallet/alipay.png', width: Screen.width(45));
    } else if(val.contains('微信')) {
      return Image.asset('images/myWallet/wechat.png', width: Screen.width(45));
    } else if(val.contains('银联') || val.contains('网银')) {
      return Image.asset('images/myWallet/bank.png', width: Screen.width(50));
    } else {
      return SizedBox(width: 0, height: 0);
    }
  }
}