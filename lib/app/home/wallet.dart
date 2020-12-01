import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

import '../../services/utils.dart';
import '../../services/state.dart';
import '../../api/api.dart';
import '../component/component.dart';
import '../component/dialog.dart';


class WalletPages extends StatefulWidget{
  WalletPages({Key key});
  _WalletPages createState() => _WalletPages();
}

class _WalletPages extends State {
  // 是否显示余额宝 余额
  var showBaoMoney = true;
  // 银行卡列表
  var bankList = [];
  // 用户信息
  var userDetail = {
    'balance': '100',
    'fund_password': true
  };
  @override
  initState() {
    super.initState();
    _init();
  }
  Widget build(BuildContext context) {
    final states = Provider.of<Providers>(context);
    Screen.init(context);
    // TODO: implement build
    return Scaffold(
        appBar: HeadersComponent.Appbars(
          Text('我的钱包', style: TextStyle(fontSize: Screen.width(32)),),
          showLeading: false,
          leading: GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: Screen.width(15)),
              width: Screen.width(60),
              height: double.infinity,
              child: Icon(Icons.refresh, size: Screen.width(60),),
            ),
            onTap: () {
              // _userDetail();
            },
          ),
       ),
        body: Container(
          color: ColorGather.colorBg(),
          child: ListView(
            children: <Widget>[
              Container(
                height: Screen.width(170),
                color: ColorGather.colorMain(),
                child: ListTitleComponent(
                  color: null,
                  leadingLeft: 40,
                  title: Container(
                    child: Text('账号余额', style: TextStyle(fontSize: Screen.width(26), color: Colors.white)),
                    margin: EdgeInsets.only(bottom: Screen.width(10)),
                  ),
                  subTitle: Row(
                    children: <Widget>[
                      userDetail['balance'] == null ?
                      Text('获取中...', style: TextStyle(fontSize: Screen.width(26), color: Colors.white))
                      :
                      Text('${states.showMoney ? userDetail["balance"] : "******"}', style: TextStyle(fontSize: Screen.width(30), color: Colors.white, fontWeight: FontWeight.w600)),
                      SizedBox(height: 0, width: Screen.width(25),),
                      Image.asset('images/myWallet/wallet_01.png', width: Screen.width(38),),
                    ],
                  ),
                  trailing: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Icon(!states.showMoney ? Icons.visibility_off : Icons.visibility, color: Colors.white, size: Screen.width(50)),
                    onTap: () {
                      setState(() {states.showMoney = !states.showMoney;});
                      Storage.setBool('walletShowMoney', states.showMoney);
                      states.showMoneyFn();
                    },
                  )
                ),
              ),

              Container(
                color: Colors.white,
                margin: EdgeInsets.only(top: Screen.width(20)),
                child: Column(
                    children: <Widget>[
                      ListTitleComponent(
                        leading: Image.asset('images/myWallet/wallet_03.png', width: Screen.width(55)),
                        title: Text('充值', style: TextStyle(fontSize: Screen.width(30))),
                        onTap: () {Navigator.pushNamed(context, '/recharge');},
                      ),
                      Divider(height: 0,),
                      ListTitleComponent(
                        leading: Image.asset('images/myWallet/wallet_04.png', width: Screen.width(55)),
                        title: Text('提现', style: TextStyle(fontSize: Screen.width(30))),
                        onTap: () {
                          if(!userDetail['fund_password']) {
                            DialogComponents.alertIos(
                                context,
                                content: [
                                  Text('请先设置资金密码！！！', style: TextStyle(fontSize: Screen.width(28))),
                                ],
                                confirm: () {
                                  Navigator.of(context).pushReplacementNamed('/setPassword');
                                }
                            );
                            return;
                          } else if(bankList.length == 0) {
                            DialogComponents.alertIos(
                                context, content: [
                                  Text('请先绑定银行卡！！！', style: TextStyle(fontSize: Screen.width(28))),
                                ],
                                confirm: () {
                                  Navigator.of(context).pushReplacementNamed('/bank');
                                }
                            );
                            return;
                          }
                          Navigator.pushNamed(context, '/withdrawal', arguments: {'userDetail': userDetail, 'bankList': bankList});
                        },
                      ),
//                      Divider(height: 0,),
//                      ListTitleComponent(
//                        leading: Image.asset('images/myWallet/wallet_05.png', width: Screen.width(55)),
//                        title: Text('余额宝', style: TextStyle(fontSize: Screen.width(30))),
//                        onTap: () {Navigator.pushNamed(context, '/yubao');},
//                      ),
                      Container(height: Screen.width(20),  color: ColorGather.colorBg()),
                      ListTitleComponent(
                        leading: Image.asset('images/myWallet/wallet_06.png', width: Screen.width(55)),
                        title: Text('额度转换', style: TextStyle(fontSize: Screen.width(30))),
                        onTap: () {Navigator.pushNamed(context, '/transformation', arguments: userDetail);},
                      ),
                      Divider(height: 0,),
                      ListTitleComponent(
                        leading: Image.asset('images/myWallet/wallet_07.png', width: Screen.width(54)),
                        title: Text('银行卡', style: TextStyle(fontSize: Screen.width(30))),
                        onTap: () {
                          if(!userDetail['fund_password']) {
                            DialogComponents.alertIos(
                                context,
                                content: [
                                  Text('请先设置资金密码！！！', style: TextStyle(fontSize: Screen.width(28))),
                                ],
                                confirm: () {
                                  Navigator.of(context).pushReplacementNamed('/setPassword');
                                }
                            );
                          } else {
                            Navigator.pushNamed(context, '/bank');
                          }
                        },
                      ),
                      Divider(height: 0,),
                      ListTitleComponent(
                        leading: Image.asset('images/myWallet/wallet_08.png', width: Screen.width(53)),
                        title: Text('帐变记录', style: TextStyle(fontSize: Screen.width(30))),
                        onTap: () {Navigator.pushNamed(context, '/transactionRecord');},
                      ),
                      Container(height: Screen.width(20),  color: ColorGather.colorBg()),
                    ]
                ),
              )
            ],
          ),
        )
    );
  }


  _init() {

    // 获取用户 余额 和 是否资金密码
    // _userDetail();

    // 获取银行卡列表
    // Api.getBankList().then((response) {
    //   if (response['success']) {
    //     setState(() {bankList = response['data']['cards'];});
    //     if(bankList.length == 0) {
    //       SchedulerBinding.instance.addPostFrameCallback((v) {
    //         showDialog(
    //             context: context, //BuildContext对象
    //             barrierDismissible: false,
    //             builder: (BuildContext context) {
    //               return _DialogComponent(haveFundPassword: userDetail['fund_password']);
    //             });
    //       });
    //     }
    //   }
    // });

  }
  // 获取余额 和 是否资金密码
  _userDetail() {
    setState(() {
      userDetail['balance'] = null;
    });
    // Api.userDetail().then((response) {
    //   if (response['success']) {
    //     setState(() {userDetail = response['data'];});
    //     Storage.setString('userDetail', json.encode(response['data']));
    //   }
    // });
  }

}


// _DialogComponent(title:"关于我们", content:"关于我们");
class _DialogComponent extends Dialog {
  var haveFundPassword;
  _DialogComponent({this.haveFundPassword});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView(
      children: <Widget>[
        SizedBox(height: Screen.width(80),),
        Material(
            type: MaterialType.transparency,
            child: Center(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: Screen.weightWidth(context) - Screen.width(110),
                      padding: EdgeInsets.only(bottom: Screen.width(30)),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(Screen.width(15))
                      ),
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: Screen.height(55),),
                          FractionallySizedBox(
                            widthFactor: .6,
                            child: Image.asset('images/myWallet/bndBank_01.png'),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20, bottom: 10),
                            child: Text('绑定银行卡', style: TextStyle(fontSize: Screen.width(32), color: ColorGather.colorMain()),),
                          ),
                          FractionallySizedBox(
                            widthFactor: .8,
                            child: Text('为保障您的账号资金安全，需先成功绑定银行卡才能进行安全提现。', style: TextStyle(fontSize: Screen.width(26),), textAlign: TextAlign.center,),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: ButtonComponent.material(width: .8, title: '绑定银行卡', pressed: () {
                              if(!haveFundPassword) {
                                DialogComponents.alertIos(
                                    context,
                                    content: [
                                      Text('请先设置资金密码！！！', style: TextStyle(fontSize: Screen.width(28))),
                                    ],
                                    confirm: () {
                                      Navigator.of(context).pushReplacementNamed('/setPassword');
                                    }
                                );
                              } else {
                                Navigator.pushReplacementNamed(context, '/bank');
                              }
                            },),
                          ),
                        ],
                      ),),

                    Container(width: Screen.width(3), height: Screen.width(120), color: Colors.white,),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        width: Screen.width(75), height: Screen.width(75),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(37.5)
                        ),
                        child: Icon(Icons.close, size: Screen.width(45)),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ))
        ),
      ],
    );
  }
}