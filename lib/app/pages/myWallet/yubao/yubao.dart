import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../services/utils.dart';
import '../../../component/component.dart';
import '../../../component/dialog.dart';


class YubaoPages extends StatefulWidget{
  createState() => _YubaoPages();
}

class _YubaoPages extends State {
  var turnIn = TextEditingController();
  var turnOut = TextEditingController();
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
            appBar: HeadersComponent.Appbars(Text('余额宝', style: TextStyle(fontSize: Screen.width(32)),)),
            body: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [ColorGather.colorMain(), Colors.white], begin: Alignment.topCenter, end: Alignment.bottomCenter)
              ),
              child: ListView(
                children: <Widget>[
                  Card(
                    margin: EdgeInsets.all(Screen.width(25)),
                    color: Colors.white,
                    child: Container(
                      height: Screen.width(710),
                      child: Column(
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: Screen.width(40), bottom: Screen.width(25), right: Screen.width(15)),
                                child: Text('总余额', style: TextStyle(fontSize: Screen.width(30), color: Color.fromRGBO(150, 150, 150, 1)),),
                              ),
                              Image.asset('images/myWallet/wallet_02.png', fit: BoxFit.cover, width: Screen.width(50),)
                            ],
                          ),
                          Text('1000000.00', style: TextStyle(fontSize: Screen.width(40)),),
                          SizedBox(height: Screen.width(60),),
                          ButtonComponent.material(title: '昨日收益 100000', width: .7, height: 100, fontSize: 32, radius: 50),
                          SizedBox(height: Screen.width(90),),
                          Row(
                            children: <Widget>[
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: <Widget>[
                                    Text('累计收益', style: TextStyle(fontSize: Screen.width(30), color: Color.fromRGBO(150, 150, 150, 1)),),
                                    Text('1000000.00', style: TextStyle(fontSize: Screen.width(30)),),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Column(
                                  children: <Widget>[
                                    Text('年收益化 ( % )', style: TextStyle(fontSize: Screen.width(30), color: Color.fromRGBO(150, 150, 150, 1)),),
                                    Text('1000000.00', style: TextStyle(fontSize: Screen.width(30)),),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(height: Screen.width(40),),
                          Row(
                            children: <Widget>[
                              Expanded(
                                  flex: 1,
                                  child: ButtonComponent.material(title: '转入', width: .8, pressed: () {
                                    turnOut.text = '';
                                    DialogComponents.select(context, title: '转入余额宝',
                                        item: [
                                          SimpleDialogOption(
                                              child: Column(
                                                children: <Widget>[
                                                  ListTitleComponent(
                                                    leading: Container(
                                                      width: Screen.width(55),
                                                      height: Screen.width(55),
                                                      decoration: BoxDecoration(
                                                          image: DecorationImage(
                                                            image: AssetImage('images/my/my_2.png'),
                                                          )
                                                      ),
                                                      padding: EdgeInsets.all(10),
                                                    ),
                                                    trailingShow: false,
                                                    title: Text('现金账户余额', style: TextStyle(fontSize: Screen.width(28),),),
                                                    subTitle: Text('10000', style: TextStyle(fontSize: Screen.width(28),),),
                                                  ),
                                                  ListTitleComponent(
                                                    title: InputComponent.text(
                                                        labelText: '请输入转入金额', controller: turnOut,
                                                        inputFormatters: [
                                                          WhitelistingTextInputFormatter(RegExp("[0-9.]")),
                                                          LengthLimitingTextInputFormatter(18)
                                                        ]),
                                                    trailing: GestureDetector(
                                                      behavior: HitTestBehavior.opaque,
                                                      child: Text('全部', style: TextStyle(fontSize: Screen.width(28), color: ColorGather.colorMain()),),
                                                      onTap: () {
                                                        setState(() {turnOut.text = '10000';});
                                                      },
                                                    ),
                                                    height: 120,
                                                    leadingLeft: 0,
                                                  ),
                                                  Divider(height: 0,),
                                                  Container(
                                                    padding: EdgeInsets.only(top: Screen.width(20), bottom: Screen.width(20)),
                                                    child: RichText(
                                                      text: TextSpan(
                                                          style: TextStyle(fontSize: Screen.width(30), color: Colors.black),
                                                          children: [
                                                            TextSpan(text: '预计收益到账日期 '),
                                                            TextSpan(text: '2020-05-20', style: TextStyle(color: Colors.blue)),
                                                          ]
                                                      ),
                                                    ),
                                                    alignment: Alignment.centerLeft,
                                                  ),
                                                  ButtonComponent.material(title: '确定转入', pressed: () {
                                                    print(turnOut.text);
                                                    Navigator.pop(context, '选择');
                                                  },),
                                                ],
                                              )
                                          ),
                                        ]
                                    );
                                  })
                              ),
                              Expanded(
                                  flex: 1,
                                  child: ButtonComponent.material(title: '转出', width: .8, pressed: () {
                                    turnIn.text = '';
                                    DialogComponents.select(
                                        context, title: '转出到现金账户',
                                        item: [
                                          SimpleDialogOption(
                                              child: Column(
                                                children: <Widget>[
                                                  ListTitleComponent(
                                                    title:  InputComponent.text(
                                                        labelText: '请输入转出金额', controller: turnIn,
                                                        inputFormatters: [
                                                          WhitelistingTextInputFormatter(RegExp("[0-9.]")),
                                                          LengthLimitingTextInputFormatter(18)
                                                        ]),
                                                    trailing: GestureDetector(
                                                      behavior: HitTestBehavior.opaque,
                                                      child: Text('全部', style: TextStyle(fontSize: Screen.width(28), color: ColorGather.colorMain()),),
                                                      onTap: () {
                                                        setState(() {
                                                          turnIn.text = '10000';
                                                        });
                                                      },
                                                    ),
                                                    height: 120,
                                                    leadingLeft: 0,
                                                  ),
                                                  Divider(height: 0,),
                                                  SizedBox(height: Screen.width(40),),
                                                  ButtonComponent.material(title: '确定转出', pressed: () {
                                                    print(turnIn.text);
                                                    Navigator.pop(context, '选择');
                                                  },),
                                                ],
                                              )
                                          ),
                                        ]
                                    );
                                  })
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
        )
    );
  }
}
