import 'dart:ffi';

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../component/component.dart';
import '../../component/dialog.dart';
import '../../../services/utils.dart';
import '../../../services/state.dart';


class GameBottomPages extends StatefulWidget{
  @override
  createState() => _GameBottomPages();
}
class _GameBottomPages extends State {
  var prizeGroup = 1900.0;
  var minPrizeGroup = 1900.0;
  var maxPrizeGroup = 2000.0;

  // 圆角分厘
  var prizeMode = 1;

  var minMultiple = 1;
  var maxMultiple = 10;

  var prizeModeList =[0, 1, 2, 3];
  // 计算器
  var calculateList = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  var calculateMultiple = '0';

  // 点开奖金组时
  var prizeGroupShow = false;

  @override
  initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    var states = Provider.of<Providers>(globeBuildContext);
    // TODO: implement build
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {},
      child: Container(
        width: Screen.weightWidth(context),
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey,
                  offset: Offset(2.0, 0), //阴影xy轴偏移量
                  blurRadius: 3.0, //阴影模糊程度
                  spreadRadius: 0.5 //阴影扩散程度
              )
            ]
        ),
        child: Stack(
          overflow: Overflow.visible,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: Screen.width(prizeGroupShow ? 100 : 0)),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          padding: EdgeInsets.only(left: Screen.width(15), right: Screen.width(0), top: Screen.width(8), bottom: Screen.width(5)),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: Screen.width(3),
                                      color: ColorGather.colorMain()
                                  )
                              )
                          ),
                          child: Row(
                            children: <Widget>[
                              Text('奖金组', style: TextStyle(fontSize: Screen.width(26)),),
                              SizedBox(width: Screen.width(20),),
                              Text('${prizeGroup.toInt()}', style: TextStyle(fontSize: Screen.width(26)),),
                              Icon(Icons.arrow_drop_down, size: Screen.width(45), color: Colors.grey,)
                            ],
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            prizeGroupShow = !prizeGroupShow;
                          });
                        },
                      ),

                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          padding: EdgeInsets.only(left: Screen.width(15), right: Screen.width(0), top: Screen.width(8), bottom: Screen.width(5)),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: Screen.width(3),
                                      color: ColorGather.colorMain()
                                  )
                              )
                          ),
                          child: Row(
                            children: <Widget>[
                              Text('${_prizeModeH(prizeMode)}', style: TextStyle(fontSize: Screen.width(26)),),
                              SizedBox(width: Screen.width(10),),
                              Icon(Icons.arrow_drop_down, size: Screen.width(45), color: Colors.grey,)
                            ],
                          ),
                        ),
                        onTap: () {
                          DialogComponents.select(context,
                              item: prizeModeList.map<Widget>((item) {
                                return  SimpleDialogOption(
                                  child: Row(
                                    children: <Widget>[
                                      Radio(value: item, groupValue: prizeMode, onChanged: (val) {
                                        setState(() {
                                          prizeMode = val;
                                        });
                                        Navigator.pop(context, '选择');
                                      },),
                                      Text('${_prizeModeH(item)}', style: TextStyle(fontSize: Screen.width(28))),
                                    ],
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      prizeMode = item;
                                    });
                                    Navigator.pop(context, '选择');
                                  },
                                );
                              }).toList()
                          );
                        },
                      ),

                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          padding: EdgeInsets.only(left: Screen.width(15), right: Screen.width(15), top: Screen.width(8), bottom: Screen.width(5)),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: Screen.width(3),
                                      color: ColorGather.colorMain()
                                  )
                              )
                          ),
                          child: Row(
                            children: <Widget>[
                              Text('倍数', style: TextStyle(fontSize: Screen.width(26)),),
                              Container(
                                padding: EdgeInsets.only(top: Screen.width(3),left: Screen.width(20), right: Screen.width(10)),
                                child: Text('${states.currentGame['multiple']}', style: TextStyle(fontSize: Screen.width(26)),),
                              )
                            ],
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            calculateMultiple = '0';
                          });
                          DialogComponents.sheet(
                              context,
                              content: StatefulBuilder(
                                builder: (context, changeState) {
                                  return Container(
                                    height: Screen.width(615),
                                    child: Column(
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(top: Screen.width(25), bottom: Screen.width(25)),
                                          child: Row(
                                            children: <Widget>[
                                              Text('当前选择', style: TextStyle(fontSize: Screen.width(28))),
                                              Text('${calculateMultiple}', style: TextStyle(fontSize: Screen.width(28))),
                                              Text('最大倍数', style: TextStyle(fontSize: Screen.width(28))),
                                              Text('${maxMultiple}', style: TextStyle(fontSize: Screen.width(28)))
                                            ],
                                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                                          ),
                                        ),

                                        Wrap(
                                            children: calculateList.asMap().map((index, item) {
                                              return MapEntry(index, GestureDetector(
                                                behavior: HitTestBehavior.opaque,
                                                onTap: () {
                                                  changeState(() {
                                                    calculateMultiple += item.toString();
                                                  });
                                                  if(int.parse(calculateMultiple) >= maxMultiple) {
                                                    changeState(() {
                                                      calculateMultiple = maxMultiple.toString();
                                                    });
                                                  }
                                                  calculateMultiple = int.parse(calculateMultiple).toString();
                                                },
                                                child: Container(
                                                  width: Screen.weightWidth(context) / 3,
                                                  height: Screen.width(130),
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      right: BorderSide(
                                                          width: Screen.width(2),
                                                          color: index + 1 % 3 == 0 ? Colors.white : Colors.grey
                                                      ),
                                                      bottom: BorderSide(
                                                          width: Screen.width(2),
                                                          color: Colors.grey
                                                      ),
                                                    ),
                                                  ),
                                                  child: Text('${item}', style: TextStyle(fontSize: Screen.width(36))),
                                                ),
                                              )
                                              );
                                            }).values.toList()
                                        ),


                                        Row(
                                          children: <Widget>[
                                            GestureDetector(
                                              behavior: HitTestBehavior.opaque,
                                              onTap: () {
                                                if(calculateMultiple.length != 0) {
                                                  changeState(() {
                                                    calculateMultiple = calculateMultiple.substring(0, calculateMultiple.length - 1);
                                                  });
                                                }
                                                if(calculateMultiple.length <= 0) {
                                                  changeState(() {
                                                    calculateMultiple = '0';
                                                  });
                                                }
                                              },
                                              child: Container(
                                                width: Screen.weightWidth(context) / 3,
                                                height: Screen.width(130),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                      right: BorderSide(
                                                          width: Screen.width(2),
                                                          color: Colors.grey
                                                      )
                                                  ),
                                                ),
                                                child: Icon(Icons.backspace, size: Screen.width(70),),
                                              ),
                                            ),

                                            GestureDetector(
                                              behavior: HitTestBehavior.opaque,
                                              onTap: () {
                                                changeState(() {
                                                  calculateMultiple += '0';
                                                });
                                                if(int.parse(calculateMultiple) >= maxMultiple) {
                                                  changeState(() {
                                                    calculateMultiple = maxMultiple.toString();
                                                  });
                                                }
                                                calculateMultiple = int.parse(calculateMultiple).toString();
                                              },
                                              child: Container(
                                                width: Screen.weightWidth(context) / 3,
                                                height: Screen.width(130),
                                                alignment: Alignment.center,
                                                decoration: BoxDecoration(
                                                  border: Border(
                                                    right: BorderSide(
                                                        width: Screen.width(2),
                                                        color: Colors.grey
                                                    ),
                                                  ),
                                                ),
                                                child: Text('${0}', style: TextStyle(fontSize: Screen.width(36))),
                                              ),
                                            ),

                                            GestureDetector(
                                              behavior: HitTestBehavior.opaque,
                                              onTap: () {
                                                if(int.parse(calculateMultiple) <= 0) {
                                                  calculateMultiple = '1';
                                                }
                                                states.currentGame['multiple'] = calculateMultiple;
                                                Navigator.pop(context);
                                              },
                                              child: Container(
                                                width: Screen.weightWidth(context) / 3,
                                                height: Screen.width(130),
                                                alignment: Alignment.center,
                                                child: Icon(Icons.check_circle, size: Screen.width(70),),
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                },
                              )
                          );
                        },
                      ),

                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: Screen.width(10),),
                              Icon(Icons.delete_forever, size: Screen.width(55), color: ColorGather.colorMain(),)
                            ],
                          ),
                        ),
                        onTap: () {
                          DialogComponents.alertIos(
                              context,
                              content: [
                                Text('确定清空选号吗 ?', style: TextStyle(fontSize: Screen.width(28))),
                              ],
                              confirm: () {
                                Navigator.pop(context, 'confirm');
                              }
                          );
                        },
                      ),
                    ],
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          Text('试试手气吧', style: TextStyle(fontSize: Screen.width(26)),),
                          RichText(
                            text: TextSpan(
                                style: TextStyle(fontSize: Screen.width(28), color: Colors.black),
                                children: [
                                  TextSpan(text: '当前余额'),
                                  TextSpan(text: '38888.8888', style: TextStyle(color: ColorGather.colorMain())),
                                ]
                            ),
                          )
                        ],
                      ),

                      Row(
                        children: <Widget>[
                          Container(
                            width: Screen.width(180),
                            child: MaterialButton(
                              disabledColor: Colors.grey,
                              disabledTextColor: Colors.white,
                              padding: EdgeInsets.all(0),
                              height: Screen.width(55),
                              color: ColorGather.colorMain(),
                              textColor: Colors.white,
                              elevation: 2.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(Screen.width(8)))
                              ),
                              child: Text('一键购彩', style: TextStyle(fontSize: Screen.width(26)),),
                              onPressed: () {},
                            ),
                          ),
                          SizedBox(width: Screen.width(30),),
                          Container(
                            width: Screen.width(120),
                            child: MaterialButton(
                              disabledColor: Colors.grey,
                              disabledTextColor: Colors.white,
                              padding: EdgeInsets.all(0),
                              height: Screen.width(55),
                              color: ColorGather.colorMain(),
                              textColor: Colors.white,
                              elevation: 2.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(Screen.width(8)))
                              ),
                              child: Text('购彩', style: TextStyle(fontSize: Screen.width(26)),),
                              onPressed: () {},
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),


            Positioned(
              top: Screen.width(0),
              child: Offstage(
                offstage: !prizeGroupShow,
                child: Container(
                  width: Screen.width(750),
                  decoration: BoxDecoration(
                      color: Colors.white
                  ),
                  child: Slider(
                    value: prizeGroup,
                    max: maxPrizeGroup,
                    min: minPrizeGroup,
                    inactiveColor: Colors.grey,
                    activeColor: ColorGather.colorMain(),
                    onChanged: (double val) {
                      setState(() {
                        prizeGroup = val;
                      });
                    },
                    onChangeEnd: (double val) {
                      print(val);
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _prizeModeH(mode) {
    if (mode is int) {
      switch (mode) {
        case 0:
          return '元';
          break;
        case 1:
          return '角';
          break;
        case 2:
          return '分';
          break;
        case 3:
          return '厘';
          break;
      }
    } else {
      switch (mode) {
        case '元':
          return 0;
          break;
        case '角':
          return 1;
          break;
        case '分':
          return 2;
          break;
        case '厘':
          return 3;
          break;
      }
    }
  }
}