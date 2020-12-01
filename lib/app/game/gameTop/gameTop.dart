import 'package:flutter/material.dart';

import '../../component/component.dart';
import '../../../services/utils.dart';


class GameTopPages extends StatefulWidget{
  @override
  createState() => _GameTopPages();
}
class _GameTopPages extends State {
  var list = '1,2,3,4,5,6,7,8,9,10';
  @override
  initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      color: Colors.white,
      height: Screen.width(190),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: Screen.width(10), bottom: Screen.width(15)),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.red,
                  width: Screen.width(3),
                  style: BorderStyle.solid
                )
              )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('200820032期', style: TextStyle(fontSize: Screen.width(28)),),
                Row(
                    children: list.split(',').map((item) {
                      return  Container(
                        margin: EdgeInsets.only(right: Screen.width(6)),
                        width: Screen.width(40),
                        height: Screen.width(40),
                        decoration: BoxDecoration(
                            color: ColorGather.colorMain(),
                            borderRadius: BorderRadius.all(Radius.circular(Screen.width(20))),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black87,
                                  offset: Offset(1.0, 2.0), //阴影xy轴偏移量
                                  blurRadius: 2.0, //阴影模糊程度
                                  spreadRadius: 0.5 //阴影扩散程度
                              )
                            ]
                        ),

                        child: Text('${item}', style: TextStyle(fontSize: Screen.width(24), color: Colors.white, height: 1.35), textAlign: TextAlign.center, )
                      );
                    }).toList()
                )
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.only(top: Screen.width(10), bottom: Screen.width(10)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Text('英雄联盟', style: TextStyle(fontSize: Screen.width(28)),),
                Text('200820032期', style: TextStyle(fontSize: Screen.width(28)),),
                Container(
                  width: Screen.width(130),
                  child: Text('10:00', style: TextStyle(fontSize: Screen.width(28)), textAlign: TextAlign.center,),
                )
              ],
            ),
          ),

          Container(
            padding: EdgeInsets.only(left: Screen.width(30), right: Screen.width(30)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('单注奖金', style: TextStyle(fontSize: Screen.width(28)),),
                Row(
                    children: [
                      Text('1920.60', style: TextStyle(fontSize: Screen.width(28), color: Colors.red, fontWeight: FontWeight.bold),),
                      SizedBox(width: Screen.width(30),),
                      Text('元', style: TextStyle(fontSize: Screen.width(28)),),
                    ]
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}