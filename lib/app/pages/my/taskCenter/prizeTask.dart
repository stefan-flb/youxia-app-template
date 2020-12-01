import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;

import '../../../../services/utils.dart';
import '../../../component/component.dart';
import '../../../component/dialog.dart';


class PrizeTaskPages extends StatefulWidget{
  var sign;
  PrizeTaskPages({this.sign});
  createState() => _PrizeTaskPages({sign: this.sign});
}

class _PrizeTaskPages extends State {
  var sign;
  _PrizeTaskPages(this.sign);
  // 左侧图标背景色
  var leadingBgColor = [
    Color.fromRGBO(202,109,254, 1),
    Color.fromRGBO(595,182,252, 1),
    Color.fromRGBO(0,202,57, 1),
    Color.fromRGBO(110,142,253, 1),
    Color.fromRGBO(255,178,105, 1),
    Color.fromRGBO(255,106,146, 1),
    Color.fromRGBO(246,225,0, 1),
    Color.fromRGBO(62,56,0, 1),
    Color.fromRGBO(120,120,117, 1),
    Color.fromRGBO(255,0,0, 1),
    Color.fromRGBO(255,92,99, 1),
    Color.fromRGBO(207,0,0, 1),
  ];
  // 任务是否完后
  var isFinish;

  var btnUnActiveTitle;
  var btnActiveTitle;

  @override
  initState() {
    super.initState();
    if(sign['przie'] != null) {
      btnActiveTitle = '去完成';
      btnUnActiveTitle = '已完成';
    } else if (sign['today'] != null) {
      btnActiveTitle = '去完成';
      btnUnActiveTitle = '已完成';
    } else if (sign['finish'] != null) {
      btnActiveTitle = '未领取';
      btnUnActiveTitle = '已领取';
    }
  }
  Widget build(BuildContext context) {
    Screen.init(context);
    // TODO: implement build
    return ListView(
      children: <Widget>[
        SizedBox(height: Screen.width(20),),
        Container(
          height: Screen.width(180),
          child: ListTitleComponent(
              leading: Container(
                padding: EdgeInsets.all(Screen.width(25)),
                width: Screen.width(100),
                height: Screen.width(100),
                decoration: BoxDecoration(
                    color: leadingBgColor[0],
                    borderRadius: BorderRadius.circular(Screen.width(50))
                ),
                child: Image.asset('images/my/my_7.png', color: Colors.white,),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('单次充值', style: TextStyle(fontSize: Screen.width(30))),
                  Text('2元宝', style: TextStyle(fontSize: Screen.width(26), color: Colors.red)),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Row(
                      children: <Widget>[
                        Text('点击查看规则', style: TextStyle(fontSize: Screen.width(28), color: Colors.grey)),
                        Icon(Icons.keyboard_arrow_down, size: Screen.width(45), color: Colors.grey)
                      ],
                    ),
                    onTap: () {
                      DialogComponents.alert(
                          context, title: '查看规则',
                          content: Container(
                            height: Screen.width(350),
                            child: Html(
                              data: '''
                                                 <div>
                                                  <h1 >Demo Page</h1>
                                                  <a >Demo Page</a>
                                                  </div>
                                              ''',
                              customTextStyle: (dom.Node node, TextStyle baseStyle) {
                                if (node is dom.Element) {
                                  switch (node.localName) {
                                    case "h1":
                                      return baseStyle.merge(TextStyle(fontSize: Screen.width(28), height: 0));
                                    case "p":
                                      return baseStyle.merge(TextStyle(fontSize: Screen.width(28)));
                                    case "div":
                                      return baseStyle.merge(TextStyle(fontSize: Screen.width(28), height: 0));
                                    case "a":
                                      return baseStyle.merge(TextStyle(fontSize: Screen.width(28), color: ColorGather.colorMain(), decoration: TextDecoration.none));
                                  }
                                }
                                return baseStyle;
                              },
                            ),
                          ),
                          confirm: () {

                          });
                    },
                  )
                ],
              ),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Offstage(
                    offstage: sign['finish'] == null,
                    child: RichText(
                      text: TextSpan(
                          style: TextStyle(color: Colors.grey, fontSize: Screen.width(32)),
                          children: [
                            TextSpan(text: '1 ', style: TextStyle(color: Colors.red)),
                            TextSpan(text: '/ 3')
                          ]
                      ),
                    ),
                  ),
                  SizedBox(height: Screen.width(10),),
                  isFinish != null ? Container(
                    width: Screen.width(150), height: Screen.width(70), alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(236,236,236, 1),
                        borderRadius: BorderRadius.circular(Screen.width(35)),
                        border: Border.all(width: Screen.width(1), color: Colors.grey)
                    ),
                    child: Text('${btnUnActiveTitle}', style: TextStyle(fontSize: Screen.width(28), color: Colors.grey)),
                  ) : GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: Screen.width(150), height: Screen.width(70), alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Color.fromRGBO(0,197,243, 1),
                          borderRadius: BorderRadius.circular(Screen.width(35))
                      ),
                      child: Text('${btnActiveTitle}', style: TextStyle(fontSize: Screen.width(28), color: Colors.white)),
                    ),
                    onTap: () {
                      DialogComponents.toast(context, content: '操作成功');
                    },
                  )
                ],
              )
          ),
        )
      ],
    );
  }
}