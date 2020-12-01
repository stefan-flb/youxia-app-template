import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import '../../../../services/utils.dart';
import '../../../component/component.dart';
import '../../../component/dialog.dart';
import '../../../component/picker.dart';


class TransactionRecord extends StatefulWidget{
  createState() => _TransactionRecord();
}

class _TransactionRecord extends State{
  var page = 1;
  var pageSize = 20;
  var pageFlag = true;
  var dropDownFlag = false;
  var list = [];
  var _scrollController = ScrollController();

  var whichType = 0;
  var whichState = 0;
  var startTime = '2020-01-01';
  var endTime = '2020-01-01';

  @override
  initState() {
    super.initState();
    _getData();
    _scrollController.addListener(() {     // 上拉加载
      var _scrollTop = _scrollController.position.pixels; //获取滚动条下拉的距离
      var _scrollHeight = _scrollController.position.maxScrollExtent; //获取整个页面的高度
      if(_scrollTop >= _scrollHeight) {
        _getData();
      }
    });
  }
  dispose() {
    super.dispose();
    _scrollController.dispose(); //手动停止滑动监听
  }
  // 获取数据
  _getData() async{
    // if(pageFlag == false) return;
    // var response = await Dio().get('http://www.phonegap100.com/appapi.php?a=getPortalList&catid=20&page=${page}');
    // var res = json.decode(response.data)['result'];
    // setState(() {
    //   list.addAll(res);
    //   page++;
    // });
    // if(res.length < 20) {
    //   setState(() {
    //     pageFlag = false;
    //   });
    // }
  }
  Widget build(BuildContext context) {
    Screen.init(context);
    // TODO: implement build
    return Scaffold(
        appBar: HeadersComponent.Appbars(
          Text('交易记录', style: TextStyle(fontSize: Screen.width(32)),),
          actions: [
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: Screen.width(120),
                height: double.infinity,
                alignment: Alignment.center,
                child: Text('重置', style: TextStyle(fontSize: Screen.width(32)),),
              ),
              onTap: () {
                setState(() {
                  list = []; page = 1; startTime = ''; endTime = ''; whichType = 0; whichState = 0;
                  _scrollController.jumpTo(0);
                });
                _getData();
              },
            )
          ],
        ),
        body: Container(
            alignment: Alignment.centerLeft,
            width: double.infinity,
            color: ColorGather.colorBg(),
            child: Column(
              children: <Widget>[
                Container(
                  height: Screen.width(90),
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text('全部类型', style: TextStyle(fontSize: Screen.width(28), color: Colors.black),),
                            Icon(Icons.arrow_drop_down, color: Colors.black, size: Screen.width(50),),
                          ],
                        ),
                        onTap: () {
                          DialogComponents.customSheetHalfBottle(
                            context, title: '全部类型',
                            content: StatefulBuilder(
                              builder: (context, changeState) {
                                return Wrap(
                                  children: <Widget>[
                                    ButtonComponent.material(
                                      width: .3, title: '全部类型', elevation: 0.0,
                                      color: whichType == 0 ? ColorGather.colorMain() : Colors.white, textColor: whichType == 0 ? Colors.white : Colors.black,
                                      pressed: () {
                                        changeState(() {whichType = 0;print(whichType);});
                                        Navigator.pop(context);
                                      },
                                    ),
                                    SizedBox(width: Screen.width(10), height: 0,),
                                    ButtonComponent.material(
                                        width: .3, title: '全部类型', elevation: 0.0,
                                        color: whichType == 1 ? ColorGather.colorMain() : Colors.white, textColor: whichType == 1 ? Colors.white : Colors.black,
                                        pressed: () {
                                          changeState(() {whichType = 1;print(whichType);});
                                          Navigator.pop(context);
                                        }
                                    ),
                                    SizedBox(width: Screen.width(10), height: 0,),
                                    ButtonComponent.material(
                                        width: .3, title: '全部类型', elevation: 0.0,
                                        color: whichType == 2 ? ColorGather.colorMain() : Colors.white, textColor: whichType == 2 ? Colors.white : Colors.black,
                                        pressed: () {
                                          changeState(() {whichType = 2;print(whichType);});
                                          Navigator.pop(context);
                                        }
                                    ),
                                    SizedBox(width: Screen.width(10), height: 0,),
                                    ButtonComponent.material(
                                        width: .3, title: '全部类型', elevation: 0.0,
                                        color: whichType == 3 ? ColorGather.colorMain() : Colors.white, textColor: whichType == 3 ? Colors.white : Colors.black,
                                        pressed: () {
                                          changeState(() {whichType = 3;print(whichType);});
                                          Navigator.pop(context);
                                        }
                                    ),
                                    SizedBox(width: Screen.width(10), height: 0,),
                                    ButtonComponent.material(
                                        width: .3, title: '全部类型', elevation: 0.0,
                                        color: whichType == 4 ? ColorGather.colorMain() : Colors.white, textColor: whichType == 4 ? Colors.white : Colors.black,
                                        pressed: () {
                                          changeState(() {whichType = 4;print(whichType);});
                                          Navigator.pop(context);
                                        }
                                    ),
                                    SizedBox(width: Screen.width(10), height: 0,),
                                  ],
                                );
                              },
                            )
                          );
                        },
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text('全部状态', style: TextStyle(fontSize: Screen.width(28), color: Colors.black),),
                            Icon(Icons.arrow_drop_down, color: Colors.black, size: Screen.width(50),),
                          ],
                        ),
                        onTap: () {
                          DialogComponents.customSheetHalfBottle(
                              context, title: '全部状态',
                              content: StatefulBuilder(
                                builder: (context, changeState) {
                                  return Wrap(
                                    children: <Widget>[
                                      ButtonComponent.material(
                                        width: .3, title: '全部状态', elevation: 0.0,
                                        color: whichState == 0 ? ColorGather.colorMain() : Colors.white, textColor: whichState == 0 ? Colors.white : Colors.black,
                                        pressed: () {
                                          changeState(() {whichState = 0;});
                                          Navigator.pop(context);
                                        },
                                      ),
                                      SizedBox(width: Screen.width(10), height: 0,),
                                      ButtonComponent.material(
                                          width: .3, title: '全部状态', elevation: 0.0,
                                          color: whichState == 1 ? ColorGather.colorMain() : Colors.white, textColor: whichState == 1 ? Colors.white : Colors.black,
                                          pressed: () {
                                            changeState(() {whichState = 1;});
                                            Navigator.pop(context);
                                          }
                                      ),
                                      SizedBox(width: Screen.width(10), height: 0,),
                                      ButtonComponent.material(
                                          width: .3, title: '全部状态', elevation: 0.0,
                                          color: whichState == 2 ? ColorGather.colorMain() : Colors.white, textColor: whichState == 2 ? Colors.white : Colors.black,
                                          pressed: () {
                                            changeState(() {whichState = 2;});
                                            Navigator.pop(context);
                                          }
                                      ),
                                      SizedBox(width: Screen.width(10), height: 0,),
                                      ButtonComponent.material(
                                          width: .3, title: '全部状态', elevation: 0.0,
                                          color: whichState == 3 ? ColorGather.colorMain() : Colors.white, textColor: whichState == 3 ? Colors.white : Colors.black,
                                          pressed: () {
                                            changeState(() {whichState = 3;});
                                            Navigator.pop(context);
                                          }
                                      ),
                                      SizedBox(width: Screen.width(10), height: 0,),
                                      ButtonComponent.material(
                                          width: .3, title: '全部状态', elevation: 0.0,
                                          color: whichState == 4 ? ColorGather.colorMain() : Colors.white, textColor: whichState == 4 ? Colors.white : Colors.black,
                                          pressed: () {
                                            changeState(() {whichState = 4;});
                                            Navigator.pop(context);
                                          }
                                      ),
                                      SizedBox(width: Screen.width(10), height: 0,),
                                    ],
                                  );
                                },
                              )
                          );
                        },
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text('时间筛选', style: TextStyle(fontSize: Screen.width(28), color: Colors.black),),
                            SizedBox(width: Screen.width(10), height: 0,),
                            Image.asset('images/myWallet/calendar.png', width: Screen.width(35), color: Colors.black,),
                          ],
                        ),
                        onTap: () {
                          PickerTool.showPickerDateRange(context, callBack: (start, end) {
                            setState(() {
                              startTime = start;
                              endTime = end;
                            });
                          });
                        },
                      )
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: Screen.width(20), bottom: Screen.width(20)),
                  child: Text('时间: ${ startTime + ' 至 ' + endTime }', style: TextStyle(fontSize: Screen.width(28))),
                ),
                Expanded(
                  child: list.length > 0 ? RefreshIndicator(
                    // ignore: missing_return
                    color: ColorGather.colorMain(),
                    onRefresh: () async{
                      await Future.delayed(Duration(milliseconds: 2000), () {
                        setState(() {
                          list = [];page = 1;pageFlag = true;
                        });
                        _getData();
                      });
                    },
                    child: ListView.builder(
                      controller: _scrollController,
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(bottom: Screen.width(2)),
                              child: ListTitleComponent(
                                height: 130,
                                title: Text('游戏上分', style: TextStyle(fontSize: Screen.width(28))),
                                subTitle: Text('2020-01-20', style: TextStyle(fontSize: Screen.width(26))),
                                subPaddingTop: 10,
                                trailing: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
                                    Text('6', style: TextStyle(fontSize: Screen.width(28), color: Colors.red), textAlign: TextAlign.right,),
                                    SizedBox(width: 0, height: Screen.width(10),),
                                    Text('状态: 已完成', style: TextStyle(fontSize: Screen.width(28))),
                                  ],
                                ),
                              ),
                            ),
                            Offstage(
                              offstage: index != list.length - 1,
                              child: getMoreTips(flag: pageFlag),
                            )
                          ],
                        );
                      },
                    ),
                  ) : getMoreTips(flag: pageFlag),
                )
              ],
            )
        )
    );
  }

}

class getMoreTips extends StatelessWidget{
  var flag = true;
  getMoreTips({Key key, this.flag}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: flag ? Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: Screen.width(20), bottom: Screen.width(20)),
            child: Text('正在加载...', style: TextStyle(fontSize: Screen.width(28), color: Colors.grey)),
          ),
          Container(
            margin: EdgeInsets.only(left: Screen.width(20)),
            width: Screen.width(45),
            height: Screen.width(45),
            child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(ColorGather.colorMain()),),
          )
        ],
      ) : Container(
        padding: EdgeInsets.only(top: Screen.width(20), bottom: Screen.width(20)),
        child: Text('没有更多数据...', style: TextStyle(fontSize: Screen.width(28), color: Colors.grey)),
      ),
    );
  }
}