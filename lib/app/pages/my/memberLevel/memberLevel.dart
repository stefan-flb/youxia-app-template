import 'package:flutter/material.dart';
import '../../../../services/utils.dart';
import '../../../component/component.dart';

class MemberLevelPages extends StatefulWidget{
  createState() => _MemberLevelPages();
}

class _MemberLevelPages extends State {
  var searchVal = TextEditingController();
  @override
  initState() {
    super.initState();
  }
  Widget build(BuildContext context) {
    Screen.init(context);
    // TODO: implement build
    return Scaffold(
      appBar: HeadersComponent.Appbars(Text('会员等级', style: TextStyle(fontSize: Screen.width(32)),)),
      body: Container(
        color: ColorGather.colorBg(),
        child: ListView(
          children: <Widget>[
            Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  ListTitleComponent(
                    title: Text('等级规则', style: TextStyle(fontSize: Screen.width(30)),),
                    trailing: RichText(
                      text: TextSpan(
                        style: TextStyle(color: Colors.grey, fontSize: Screen.width(30)),
                        children: [
                          TextSpan(text: '我的积分: ', ),
                          TextSpan(text: '0', style: TextStyle(color: ColorGather.colorMain())),
                          TextSpan(text: '    离白银还差: '),
                          TextSpan(text: '4999', style: TextStyle(color: Colors.black)),
                        ]
                      ),
                    )
                  ),

                  Divider(height: 0,),
                  SizedBox(height: Screen.width(40),),
                  Table(
                    columnWidths: <int, TableColumnWidth>{
                      0: FixedColumnWidth(Screen.width(300)),
                      1: FixedColumnWidth(Screen.width(300))
                    },
                    defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                    border: TableBorder.all(
                      color: Colors.grey,
                      width: Screen.width(2)
                    ),
                    children: [
                      TableRow(
                        decoration: BoxDecoration(
                          color: ColorGather.colorBg()
                        ),
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: Screen.width(80),
                            child: Text('荣誉等级', style: TextStyle(fontSize: Screen.width(28)),),
                          ),
                          Text('荣誉等级', style: TextStyle(fontSize: Screen.width(28)), textAlign: TextAlign.center,)
                        ]
                      ),
                      TableRow(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: Screen.width(80),
                              child: Text('黄铜', style: TextStyle(fontSize: Screen.width(28)),),
                            ),
                            Text('荣誉等级', style: TextStyle(fontSize: Screen.width(28)), textAlign: TextAlign.center,)
                          ]
                      ),
                      TableRow(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: Screen.width(80),
                              child: Text('白银', style: TextStyle(fontSize: Screen.width(28)),),
                            ),
                            Text('荣誉等级', style: TextStyle(fontSize: Screen.width(28)), textAlign: TextAlign.center,)
                          ]
                      ),
                      TableRow(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: Screen.width(80),
                              child: Text('黄金', style: TextStyle(fontSize: Screen.width(28)),),
                            ),
                            Text('荣誉等级', style: TextStyle(fontSize: Screen.width(28)), textAlign: TextAlign.center,)
                          ]
                      ),
                      TableRow(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              height: Screen.width(80),
                              child: Text('白金', style: TextStyle(fontSize: Screen.width(28)),),
                            ),
                            Text('荣誉等级', style: TextStyle(fontSize: Screen.width(28)), textAlign: TextAlign.center,)
                          ]
                      ),
                    ],
                  ),
                  SizedBox(height: Screen.width(25),),
                ],
              ),
            ),

            Container(
              margin: EdgeInsets.only(top: Screen.width(20)),
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  ListTitleComponent(
                      title: Row(
                        children: <Widget>[
                          Text('升级宝典', style: TextStyle(fontSize: Screen.width(30)),),
                          SizedBox(width: Screen.width(40),),
                          Text('如何快速获得积分', style: TextStyle(fontSize: Screen.width(28), color: Colors.grey),)
                        ],
                      ),
                      trailingShow: false,
                  ),
                  Divider(height: 0,),

                  Container(
                    height: Screen.width(150),
                    child: ListTitleComponent(
                        leading: Image.asset('images/my/level_01.png', width: Screen.width(100),),
                        title: Text('充值升级', style: TextStyle(fontSize: Screen.width(30))),
                        subTitle: RichText(
                          text: TextSpan(
                              style: TextStyle(fontSize: Screen.width(30), color: Colors.grey),
                              children: [
                                TextSpan(text: '有效充值 500元宝 '),
                                TextSpan(text: '+1', style: TextStyle(color: Colors.red)),
                                TextSpan(text: ' 积分'),
                              ]
                          ),
                        ),
                        trailing: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            width: Screen.width(150), height: Screen.width(70), alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(0,197,243, 1),
                                borderRadius: BorderRadius.circular(Screen.width(35))
                            ),
                            child: Text('去完成', style: TextStyle(fontSize: Screen.width(28), color: Colors.white)),
                          ),
                          onTap: () {Navigator.pushNamed(context, '/recharge');},
                        )
                    ),
                  ),

                  Container(
                    height: Screen.width(150),
                    child: ListTitleComponent(
                        leading: Image.asset('images/my/level_02.png', width: Screen.width(100),),
                        title: Text('购买升级', style: TextStyle(fontSize: Screen.width(30))),
                        subTitle: RichText(
                          text: TextSpan(
                              style: TextStyle(fontSize: Screen.width(30), color: Colors.grey),
                              children: [
                                TextSpan(text: '有效购买 500元宝 '),
                                TextSpan(text: '+1', style: TextStyle(color: Colors.red)),
                                TextSpan(text: ' 积分'),
                              ]
                          ),
                        ),
                        trailing: GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            width: Screen.width(150), height: Screen.width(70), alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Color.fromRGBO(0,197,243, 1),
                                borderRadius: BorderRadius.circular(Screen.width(35))
                            ),
                            child: Text('去完成', style: TextStyle(fontSize: Screen.width(28), color: Colors.white)),
                          ),
                          onTap: () {},
                        )
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}