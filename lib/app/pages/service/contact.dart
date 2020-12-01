import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../services/utils.dart';
import '../../component/component.dart';
import '../../component/dialog.dart';


class ContactPages extends StatefulWidget{
  createState() => _ProblemDetailsPages();
}

class _ProblemDetailsPages extends State {
  var vx = '321321213asdasdas';
  @override
  initState() {
    super.initState();
  }
  Widget build(BuildContext context) {
    Screen.init(context);
    // TODO: implement build
    return Scaffold(
        appBar: HeadersComponent.Appbars(Text('联系我们', style: TextStyle(fontSize: Screen.width(32)),)),
        body: Container(
            padding: EdgeInsets.all(Screen.width(60)),
            width: double.infinity,
            color: ColorGather.colorBg(),
            child: ListView(
              children: <Widget>[

                Text('联系我们', style: TextStyle(fontSize: Screen.width(28)), textAlign: TextAlign.center,),
                SizedBox(height: Screen.width(20),),
                Text('关注用户体验, 提高服务质量, 有任何问题或者需求可以随时与我们沟通！ 资深客服人员为您提供优质、便捷的服务, 7*24 全年无休', style: TextStyle(fontSize: Screen.width(28), height: Screen.width(3.5))),
                SizedBox(height: Screen.width(40),),
                Row(
                  children: <Widget>[
                    Text('微信: 3123213sadasd', style: TextStyle(fontSize: Screen.width(28),)),
                    SizedBox(width: Screen.width(30),),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: Text('复制', style: TextStyle(fontSize: Screen.width(28), color: Colors.blue, decoration: TextDecoration.underline)),
                      onTap: () {
                        var data = ClipboardData(text: vx);
                        Clipboard.setData(data);
                        DialogComponents.toast(context, content: '复制成功');
                      },
                    )
                  ],
                ),
                SizedBox(height: Screen.width(30),),
                Row(
                  children: <Widget>[
                    Text('Q  Q: 3123213sadasd', style: TextStyle(fontSize: Screen.width(28))),
                    SizedBox(width: Screen.width(30),),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: Text('复制', style: TextStyle(fontSize: Screen.width(28), color: Colors.blue, decoration: TextDecoration.underline)),
                      onTap: () {
                        var data = ClipboardData(text: vx);
                        Clipboard.setData(data);
                        if(data != null) {
                          DialogComponents.toast(context, content: '复制成功');
                        }
                      },
                    )
                  ],
                )
//                ListTitleComponent(
//                  leading: Image.asset('images/service/service_04.png', width: Screen.width(55)),
//                  title: Text('微信', style: TextStyle(fontSize: Screen.width(28))),
//                  trailing: Text('zxcvbnm123456', style: TextStyle(fontSize: Screen.width(28), color: Colors.grey)),
//                ),
//                Divider(height: 0,),
//                ListTitleComponent(
//                  leading: Image.asset('images/service/service_05.png', width: Screen.width(50)),
//                  title: Text('QQ', style: TextStyle(fontSize: Screen.width(30))),
//                  trailing: Text('zxcvbnm123456', style: TextStyle(fontSize: Screen.width(28), color: Colors.grey)),
//                ),
              ],
            )
        )
    );
  }
}