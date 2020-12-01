import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../../../../services/utils.dart';
import '../../../../services/state.dart';
import '../../../../api/api.dart';
import '../../../component/component.dart';
import '../../../component/dialog.dart';


class TransformationPages extends StatefulWidget{
  var arguments;
  TransformationPages({this.arguments});
  createState() => _TransformationPages(this.arguments);
}

class _TransformationPages extends State {
  var arguments;
  _TransformationPages(this.arguments);
  var showContent = '获取中...';
  // 平台列表
  var platList = [];
  var moneyIn = TextEditingController();
  var moneyOut = TextEditingController();
  var fundPassword = TextEditingController();
  @override
  initState() {
    super.initState();
    _init();
  }
  Widget build(BuildContext context) {
    final states = Provider.of<Providers>(context);
    Screen.init(context);
    // TODO: implement build
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {FocusScope.of(context).requestFocus(FocusNode());},
        child: Scaffold(
            appBar: HeadersComponent.Appbars(Text('额度转换', style: TextStyle(fontSize: Screen.width(32)),)),
            body: Container(
              color: ColorGather.colorBg(),
              child: ListView(
                children: <Widget>[
                  Container(
                    height: Screen.width(170),
                    margin: EdgeInsets.all(Screen.width(20)),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Screen.width(8)),
                        image: DecorationImage(image: AssetImage('images/myWallet/transformation.png'), fit: BoxFit.cover)
                    ),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: Screen.width(20),),
                        ListTitleComponent(
                          color: null,
                          height: 125,
                          title: Container(
                            margin: EdgeInsets.only(bottom: Screen.width(15)),
                            child: Text('主钱包', style: TextStyle(fontSize: Screen.width(32), color: Colors.white)),
                          ),
                          subTitle: Text('${states.showMoney ? arguments["balance"] : "******"}', style: TextStyle(fontSize: Screen.width(30), color: Colors.white)),
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
//                        SizedBox(height: Screen.width(25),),
//                        ListTitleComponent(
//                          color: null,
//                          height: 125,
//                          title: Container(
//                            margin: EdgeInsets.only(bottom: Screen.width(15)),
//                            child: Text('现金余额', style: TextStyle(fontSize: Screen.width(34), color: Colors.white)),
//                          ),
//                          subTitle: Text('1000022.00', style: TextStyle(fontSize: Screen.width(30), color: Colors.white)),
//                          trailing: Image.asset('images/myWallet/wallet_02_2.png', width: Screen.width(45)),
//                        ),
                      ],
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(bottom: Screen.width(25), left: Screen.width(20)),
                    child: Text('第三方钱包', style: TextStyle(fontSize: Screen.width(30))),
                  ),
                  platList.length != 0 ?
                  ListView.builder(
                    itemCount: platList.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return ListTitleComponent(
                          title: Text('${platList[index]["main_game_plat_name"]}', style: TextStyle(fontSize: Screen.width(28))),
                          trailing: Row(
                            children: <Widget>[
                              Text('${platList[index]["balance"] ?? "获取中..."}', style: TextStyle(fontSize: Screen.width(26)),),
//                              Text('获取余额失败', style: TextStyle(fontSize: Screen.width(26)),) ,
                              SizedBox(width: Screen.width(10), height: 0,),
                              Container(
                                width: Screen.width(100),
                                height: Screen.width(60),
                                child: MaterialButton(
                                  padding: EdgeInsets.all(0),
                                  color: ColorGather.colorMain(),
                                  textColor: Colors.white,
                                  child: Text( '转入', style: TextStyle(fontSize: Screen.width(26)),),
                                  onPressed:() {
                                    moneyIn.text = '';
                                    fundPassword.text = '';
                                    DialogComponents.select(context, title: '转入AG钱包',
                                        item: [
                                          SimpleDialogOption(
                                            child: Column(
                                              children: <Widget>[
                                                InputComponent.text(
                                                    labelText: '转入金额', controller: moneyIn,
                                                    inputFormatters: [
                                                      WhitelistingTextInputFormatter.digitsOnly,
                                                      LengthLimitingTextInputFormatter(18)
                                                    ]),
                                                Divider(height: 0,),
                                                InputComponent.text(
                                                    labelText: '资金密码', controller: fundPassword, obscureText: true,
                                                    inputFormatters: [
                                                      LengthLimitingTextInputFormatter(18)
                                                    ]),
                                                Divider(height: 0,),
                                                SizedBox(height: Screen.width(20),),
                                                ButtonComponent.material(title: '转入AG钱包', pressed: () async {
                                                  if(moneyIn.text.isEmpty) {
                                                    DialogComponents.toast(context, content: '请输入转入金额');
                                                    return;
                                                  } else if(fundPassword.text.isEmpty || fundPassword.text.length < 7) {
                                                    DialogComponents.toast(context, content: '请输入正确的资金密码');
                                                    return;
                                                  }
                                                  var data = {
                                                    'amount': moneyIn.text,
                                                    'fund_password': fundPassword.text,
                                                    'mainGamePlat': platList[index]['main_game_plat_code']
                                                  };
                                                  // var response = await Api.transferIn(data);
                                                  // if(response['success']) {
                                                  //   Navigator.pop(context, '选择');
                                                  // }
                                                },),
                                              ],
                                            ),
                                            onPressed: () {}
                                          ),
                                        ]
                                    );
                                  },
                                ),
                              ),
                              SizedBox(width: Screen.width(5), height: 0,),
                              Container(
                                width: Screen.width(100),
                                height: Screen.width(60),
                                child: MaterialButton(
                                  padding: EdgeInsets.all(0),
                                  color: ColorGather.colorMain(),
                                  textColor: Colors.white,
                                  child: Text( '转出', style: TextStyle(fontSize: Screen.width(26)),),
                                  onPressed:() {
                                    moneyOut.text = '';
                                    fundPassword.text = '';
                                    DialogComponents.select(context, title: '从AG钱包转出',
                                        item: [
                                          SimpleDialogOption(
                                            child: Column(
                                              children: <Widget>[
                                                InputComponent.text(
                                                    labelText: '转出金额', controller: moneyOut,
                                                    inputFormatters: [
                                                      WhitelistingTextInputFormatter.digitsOnly,
                                                      LengthLimitingTextInputFormatter(18)
                                                    ]),
                                                Divider(height: 0,),
                                                InputComponent.text(
                                                    labelText: '资金密码', controller: fundPassword, obscureText: true,
                                                    inputFormatters: [
                                                      LengthLimitingTextInputFormatter(18)
                                                    ]),
                                                Divider(height: 0,),
                                                SizedBox(height: Screen.width(20),),
                                                ButtonComponent.material(title: '从AG钱包转出', pressed: () async{
                                                  if(moneyOut.text.isEmpty) {
                                                    DialogComponents.toast(context, content: '请输入转出金额');
                                                    return;
                                                  } else if(fundPassword.text.isEmpty || fundPassword.text.length < 7) {
                                                    DialogComponents.toast(context, content: '请输入正确的资金密码');
                                                    return;
                                                  }
                                                  var data = {
                                                    'amount': moneyIn.text,
                                                    'fund_password': fundPassword.text,
                                                    'mainGamePlat': platList[index]['main_game_plat_code']
                                                  };
                                                  // var response = await Api.transferTo(data);
                                                  // if(response['success']) {
                                                  //   Navigator.pop(context, '选择');
                                                  // }
                                                },),
                                              ],
                                            ),
                                            onPressed: () {Navigator.pop(context, '选择');},
                                          ),
                                        ]
                                    );
                                  },
                                ),
                              ),
                              SizedBox(width: Screen.width(5), height: 0,),
                              Container(
                                width: Screen.width(100),
                                height: Screen.width(60),
                                child: MaterialButton(
                                  padding: EdgeInsets.all(0),
                                  color: ColorGather.colorMain(),
                                  textColor: Colors.white,
                                  child: Text( '刷新', style: TextStyle(fontSize: Screen.width(26)),),
                                  onPressed:() {
                                    setState(() {
                                      platList[index]["balance"] = '获取中...';
                                    });
                                    _getCasinoBalance(platList[index]['main_game_plat_code']);
                                  },
                                ),
                              ),

                            ],
                          )
                      );
                    },
                  ) :
                  Container(
                    height: Screen.width(80),
                    child: Text('${showContent}', style: TextStyle(fontSize: Screen.width(28)),),
                    color: Colors.white,
                    alignment: Alignment.center,
                  )
                ],
              ),
            )
        )
    );
  }

  _init() async{
    // var getCasinoPlat = await Api.getCasinoPlat();
    // if (getCasinoPlat['success']) {
    //   setState(() {platList = getCasinoPlat['data'];});
    //   for(var i = 0; i < platList.length; i++) {
    //     _getCasinoBalance(platList[i]['main_game_plat_code']);
    //   }
    // }
  }

  // 获取第三方平台余额
  _getCasinoBalance(sign) {
    // var data = {
    //   'mainGamePlat': sign
    // };
    // Api.getCasinoBalance(data).then((res) {
    //   if(res['success']) {
    //     // 获取余额是 每个平台单独获取 所以获取之后插入到 平台列表里面渲染
    //     for(var i = 0; i < platList.length; i++) {
    //       if(platList[i]['main_game_plat_code'] == sign) {
    //         setState(() {
    //           platList[i]['balance'] = res['data']['data']['balance'];
    //           showContent = '第三方平台暂时关闭';
    //         });
    //       }
    //     }
    //   } else if(!res['success'] && res['msg'].contains('维护')) {
    //     for(var i = 0; i < platList.length; i++) {
    //       if(platList[i]['main_game_plat_code'] == sign) {
    //         setState(() {
    //           platList[i]['balance'] = res['msg'];
    //         });
    //       }
    //     }
    //   }
    // });
  }
}
