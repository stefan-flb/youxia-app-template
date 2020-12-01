import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;

import '../../../services/utils.dart';
import '../../component/component.dart';


//Navigator.pushNamed(context, '/details', arguments: {
//'title': '活动详情',
//'contentTitle': Container(
//alignment: Alignment.center,
//margin: EdgeInsets.only( top: Screen.width(15)),
//child: Text('标题', style: TextStyle(fontSize: Screen.width(30)),),
//),
//'time': Container(
//alignment: Alignment.bottomRight,
//margin: EdgeInsets.only(top: Screen.width(30), right: Screen.width(30)),
//child: Text('2020-01-01 15:00:00', style: TextStyle(fontSize: Screen.width(28)),),
//),
//'content': ''
//});
class DetailsPages extends StatefulWidget{
  var arguments;
  DetailsPages({this.arguments});
  createState() => _DetailsPages(this.arguments);
}

class _DetailsPages extends State {
  var arguments;
  _DetailsPages(this.arguments);

  @override
  initState() {
    super.initState();
  }
  Widget build(BuildContext context) {
    Screen.init(context);
    // TODO: implement build
    return Scaffold(
        appBar: HeadersComponent.Appbars(Text('${arguments['title']}', style: TextStyle(fontSize: Screen.width(32)),)),
        body: Container(
          width: double.infinity,
          color: ColorGather.colorBg(),
          child: ListView(
            children: <Widget>[
              Container(
                  width: double.infinity,
                  color: Colors.white,
                  padding: EdgeInsets.only(bottom: Screen.width(25), top: Screen.width(30)),
                  child: Column(
                    children: <Widget>[
                      arguments['contentTitle'],
                      Html(
                        padding: EdgeInsets.only(left: Screen.width(20), right: Screen.width(20)),
                        data: arguments['content'],
                        customTextStyle: (dom.Node node, TextStyle baseStyle) {
                          if (node is dom.Element) {
                            switch (node.localName) {
                              case "h1":
                                return baseStyle.merge(TextStyle(fontSize: Screen.width(32), height: 0));
                              case "p":
                                return baseStyle.merge(TextStyle(fontSize: Screen.width(32)));
                              case "div":
                                return baseStyle.merge(TextStyle(fontSize: Screen.width(32), height: 0));
                              case "a":
                                return baseStyle.merge(TextStyle(fontSize: Screen.width(32), color: ColorGather.colorMain(), decoration: TextDecoration.none));
                            }
                          }
                          return baseStyle;
                        },
                      ),
                      arguments['time'],
                    ],
                  )
              )
            ],
          ),
        )
    );
  }
}