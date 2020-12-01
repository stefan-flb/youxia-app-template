import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../services/utils.dart';
import '../../../../api/api.dart';
import '../../../component/component.dart';
import '../../../component/dialog.dart';


class BankPages extends StatefulWidget{
  BankPages({Key key});
  _BankPages createState() => _BankPages();
}

class _BankPages extends State {
  // 银行卡列表
  var bankList = [];
  var bindTime = '';
  // 姓后面的星号
  var hideName = '';

  //  绑卡需要的数据
  var addBankData = {};
  @override
  initState() {
    super.initState();
    _init();
  }
  Widget build(BuildContext context) {
    Screen.init(context);
    // TODO: implement build
    return Scaffold(
        appBar: HeadersComponent.Appbars(Text('银行卡列表', style: TextStyle(fontSize: Screen.width(32)),)),
        body: Container(
          alignment: Alignment.centerLeft,
          width: double.infinity,
          color: ColorGather.colorBg(),
          child: ListView(
            children: <Widget>[
              bankList.length == 0 ?
              Column(children: <Widget>[
                SizedBox(height: Screen.width(30),),
                Text('添加银行卡', style: TextStyle(fontSize: Screen.width(28), color: Colors.grey,), textAlign: TextAlign.center,),
                Text('即可享受安全快捷的资金提现', style: TextStyle(fontSize: Screen.width(28), color: Colors.grey), textAlign: TextAlign.center),
              ],) :
              ListView.builder(
                itemCount: bankList.length,
                shrinkWrap: true,
                physics: new NeverScrollableScrollPhysics(),
                itemBuilder: (context,index){
                  return Column(
                    children: <Widget>[
                      SizedBox(height: Screen.width(20),),
                      Container(
                        height: Screen.width(150),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('images/myWallet/bank_02.png'),
                                fit: BoxFit.cover
                            )),
                        child: ListTitleComponent(
                          color: null,
                          leading: Container(
                            padding: EdgeInsets.all(Screen.width(10)),
                            width: Screen.width(90),
                            height: Screen.width(90),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(45)
                            ),
                            child: Text('${bankList[index]["bank_sign"].toUpperCase()}', style: TextStyle(fontSize: Screen.width(28), color: Colors.grey),),
                            alignment: Alignment.center,
                          ),
                          title: Text('${bankList[index]["bank_name"]}', style: TextStyle(fontSize: Screen.width(28), color: Colors.white),),
                          subTitle: Text('${bankList[index]["card_num"]}', style: TextStyle(fontSize: Screen.width(28), color: Colors.white),),
                          trailing: Text('${bankList[index]["modifyName"]}', style: TextStyle(fontSize: Screen.width(28), color: Colors.white),),
                        ),
                      ),
                    ],
                  );
                },
              ),

              Offstage(
                offstage: bankList.length >= 4,
                child: Container(
                  margin: EdgeInsets.only(top: Screen.width(30)), height: Screen.width(90),
                  child: ButtonComponent.outline(
                    title: '+ 添加银行卡', textColor: Colors.grey, width: .9,
                    pressed: () {
                      if(addBankData['cards'] != null) {
                        Navigator.pushNamed(context, '/addBankValidation', arguments: addBankData);
                      } else {
                        DialogComponents.toast(context, content: '数据获取失败 重新获取');
                      }
                      },
                  ),
                ),
              ),
              SizedBox(height: Screen.width(25),),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: TextStyle(fontSize: Screen.width(30), color: Colors.grey,),
                  children: [
                    TextSpan(text: '一个账户最多绑定'),
                    TextSpan(text: ' 4 ', style: TextStyle(color: ColorGather.colorMain(),)),
                    TextSpan(text: '张银行卡')
                  ]
                ),
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    style: TextStyle(fontSize: Screen.width(30), color: Colors.grey,),
                    children: [
                      TextSpan(text: '银行卡'),
                      TextSpan(text: '新增', style: TextStyle(color: ColorGather.colorMain(),)),
                      TextSpan(text: '或',),
                      TextSpan(text: '修改', style: TextStyle(color: ColorGather.colorMain(),)),
                      TextSpan(text: '操作',),
                      TextSpan(text: ' ${bindTime} ', style: TextStyle(color: ColorGather.colorMain(),)),
                      TextSpan(text: '小时后,才能发起提现')
                    ]
                ),
              )
            ],
          ),
        )
    );
  }

  _init() async{
    // // 获取银行卡列表
    // Api.getBankList().then((getBankList) {
    //   if (getBankList['success']) {
    //     addBankData = getBankList['data'];
    //     // 给姓名加上星号
    //     for(var i = 0; i < addBankData['cards'].length; i++) {
    //       addBankData['cards'][i]['modifyName'] = addBankData['cards'][i]['owner_name'].substring(0, 1);
    //       for(var j = 0; j < addBankData['cards'][i]['owner_name'].length - 1; j++) {
    //         addBankData['cards'][i]['modifyName'] += '*';
    //       }
    //     }
    //     setState(() {
    //       bankList = addBankData['cards'];
    //     });
    //   }
    // });
    // // 获取绑卡提示信息
    // var configureList = await Api.configureList();
    // if (configureList['success']) {
    //   setState(() {bindTime = configureList['data']['value'];});
    // }

  }
}