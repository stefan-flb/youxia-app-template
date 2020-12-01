import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../services/utils.dart';
import '../../../../api/api.dart';
import '../../../component/component.dart';
import '../../../component/dialog.dart';
import 'orderDetails.dart';


class OrderRecordPages extends StatefulWidget{
  createState() => _OrderRecordPages();
}

class _OrderRecordPages extends State{
  var page = 1;
  var pageFlag = true;
  var dropDownFlag = false;
  var list = [];
  var _scrollController = ScrollController();
  var lotteryList = [];

  // 类型选择
  Map whichType = {
    'name': '全部游戏'
  };
  // 状态选择
  Map whichStatus = {
    'name': '全部状态'
  };
  var stateList = [
    { 'name': '全部状态', 'status': null },
    { 'name': '待开奖', 'status': 0 },
    { 'name': '已中奖', 'status': 1 },
    { 'name': '未中奖', 'status': 2 },
    { 'name': '已撤单', 'status': 1 },
    { 'name': '系统撤单', 'status': 4 },
    { 'name': '和局', 'status': 3}
  ];

  // 总计
  var total = {
    'buy': '0',
    'wining': '0',
    'profit': '0',
  };

  @override
  initState() {
    super.initState();
    print('orderRecord');
    _getData();
    _init();
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
  _getData({status, isWin, lotterySign}) async{
    // if(pageFlag == false) return;
    // var data = {
    //   'page_index': page,
    //   'page_size': 10,
    //   'status': status,
    //   'is_win': isWin,
    //   'lottery_sign': lotterySign
    // };
    // if(status == null) { data.remove('status'); }
    // if(isWin == null) { data.remove('is_win'); }
    // if(lotterySign == null) { data.remove('lottery_sign'); }
    // // 获取列表
    // var response = await Api.projectHistory(data);
    // print(response['data']['data'].length);
    // if(response['success']) {
    //   var buy = 0.0;
    //   var wining = 0.0;
    //   setState(() {
    //     list.addAll(response['data']['data']);
    //     list.forEach((val) {
    //       buy += double.parse(val['total_cost']);
    //       wining += double.parse(val['bonus']);
    //     });
    //
    //     total['buy'] = '${buy}';
    //     total['wining'] = '${wining}';
    //     total['profit'] = '${wining - buy}';
    //     page++;
    //     if(response['data']['totalPage'] < page) {
    //       pageFlag = false;
    //     }
    //   });
    //   print(total['buy']);
    // } else {
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
          Text('订单记录', style: TextStyle(fontSize: Screen.width(32)),),
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
                  list = []; page = 1; pageFlag = true; whichType['name'] = '全部游戏'; whichStatus['name'] = '全部状态';
                  total = {
                    'buy': '0',
                    'wining': '0',
                    'profit': '0',
                  };
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
                  height: Screen.width(80),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: Screen.width(1)
                      )
                    )
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text('${whichType['name']}', style: TextStyle(fontSize: Screen.width(28), color: Colors.black),),
                            Icon(Icons.arrow_drop_down, color: Colors.black, size: Screen.width(50),),
                          ],
                        ),
                        onTap: () {
                          DialogComponents.customSheetHalfBottle(
                              context, title: '选择游戏', isScroll: true,
                              content: Wrap(
                                spacing: Screen.width(10),
                                children: lotteryList.map<Widget>((val) {
                                    return Container(
                                      height: Screen.width(65),
                                      margin: EdgeInsets.only(bottom: Screen.width(10)),
                                      child: ButtonComponent.material(
                                        width: .31, title: '${val['name']}', elevation: 0.0, fontSize: 24, height: 65,
                                        color: whichType['name'] == val['name'] ? ColorGather.colorMain() : Colors.white, textColor: whichType['name'] == val['name'] ? Colors.white : Colors.black,
                                        pressed: () {
                                          setState(() {
                                            whichType = val; list = []; page = 1; pageFlag = true;
                                          });
                                          _getData(lotterySign: val['id']);
                                          Navigator.pop(context);
                                        },
                                      ),
                                    );
                                  }).toList()
                              )
                          );
                        },
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text('${whichStatus['name']}', style: TextStyle(fontSize: Screen.width(28), color: Colors.black),),
                            Icon(Icons.arrow_drop_down, color: Colors.black, size: Screen.width(50),),
                          ],
                        ),
                        onTap: () {
                          DialogComponents.customSheetHalfBottle(
                              context, title: '选择状态',
                              content: Wrap(
                                  spacing: Screen.width(10),
                                  children: stateList.map<Widget>((val) {
                                      return Container(
                                        height: Screen.width(65),
                                        margin: EdgeInsets.only(bottom: Screen.width(10)),
                                        child: ButtonComponent.material(
                                          width: .31, title: '${val['name']}', elevation: 0.0, fontSize: 24, height: 65,
                                          color: whichStatus['name'] == val['name'] ? ColorGather.colorMain() : Colors.white, textColor: whichStatus['name'] == val['name'] ? Colors.white : Colors.black,
                                          pressed: () {
                                            print(val);
                                            setState(() {
                                              whichStatus = val; list = []; page = 1; pageFlag = true;
                                              if(val['name'] == '和局' || val['name'] == '已中奖' || val['name'] == '未中奖') {
                                                _getData(isWin: val['status']);
                                              } else {
                                                _getData(status: val['status']);
                                              }

                                            });

                                            Navigator.pop(context);
                                          },
                                        ),
                                      );
                                    }).toList()
                              )
                          );
                        },
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: list.length > 0 ? RefreshIndicator(
                    // ignore: missing_return
                    color: ColorGather.colorMain(),
                    onRefresh: () async{
                      await Future.delayed(Duration(milliseconds: 2000), () {
                        setState(() {
                          list = []; page = 1; pageFlag = true; whichType['name'] = '全部游戏'; whichStatus['name'] = '全部状态';
                          total = {
                            'buy': '0',
                            'wining': '0',
                            'profit': '0',
                          };
                          _scrollController.jumpTo(0);
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
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              child: Container(
                                margin: EdgeInsets.only(bottom: Screen.width(2)),
                                child: ListTitleComponent(
                                  height: 142,
                                  title: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text('${list[index]['lottery_name']}', style: TextStyle(fontSize: Screen.width(26))),
                                      SizedBox(width: 0, height: Screen.width(2),),
                                      Text('${list[index]['method_name']}', style: TextStyle(fontSize: Screen.width(26), color: Colors.grey)),
                                      SizedBox(width: 0, height: Screen.width(1),),
                                      Text('${list[index]['time_bought']}', style: TextStyle(fontSize: Screen.width(26), color: Colors.grey)),
                                    ],
                                  ),
                                  subPaddingTop: 10,
                                  trailing: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: <Widget>[
                                      Text('购${list[index]['total_cost']}元', style: TextStyle(fontSize: Screen.width(26)), textAlign: TextAlign.right,),
                                      SizedBox(width: 0, height: Screen.width(2),),
                                      Text('第${list[index]['issue']}期', style: TextStyle(fontSize: Screen.width(26), color: Colors.grey)),
                                      SizedBox(width: 0, height: Screen.width(1),),
                                      _listState(list[index])
                                    ],
                                  ),
                                ),
                              ),
                              onTap: () {
                                Navigator.of(context).push(CupertinoPageRoute( builder: (context) => OrderDetails(arguments: list[index],)));
                              },
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
                ),

                Container(
                  height: Screen.width(95),
                  decoration: BoxDecoration(
                      color: Colors.white
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('购买', style: TextStyle(fontSize: Screen.width(26)),),
                          SizedBox(height: Screen.width(5),),
                          Text('${Utils.toFixed(total['buy'], num: 4)}', style: TextStyle(fontSize: Screen.width(26)),),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('中奖', style: TextStyle(fontSize: Screen.width(26)),),
                          SizedBox(height: Screen.width(5),),
                          Text('${double.parse(total['wining']) >= 0 ? '' : '-'}${Utils.toFixed(total['wining'], num: 4)}', style: TextStyle(fontSize: Screen.width(26), color: double.parse(total['wining']) >= 0 ? Colors.red : Colors.green),),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('盈利', style: TextStyle(fontSize: Screen.width(26)),),
                          SizedBox(height: Screen.width(5),),
                          Text('${Utils.toFixed(total['profit'], num: 4)}', style: TextStyle(fontSize: Screen.width(26), color: double.parse(total['profit']) >= 0 ? Colors.red : Colors.green),),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            )
        )
    );
  }

  _init () {
    Storage.getString('lotteryList').then((val) {
      if(val != null) {
        var data = json.decode(val);
        var temp = [];
        data.forEach((key, val) {
          temp.addAll(val['list']);
        });
        temp.insert(0, { 'name': '全部游戏', 'id': '' });
        lotteryList = temp;
      } else {
        // Api.lotteryList().then((response) {
        //   if (response['success']) {
        //     Storage.setString('lotteryList', json.encode(response['data']['data']));
        //     var data = response['data']['data'];
        //     var temp = [];
        //     data.forEach((key, val) {
        //       temp.addAll(val['list']);
        //     });
        //     temp.insert(0, { 'name': '全部游戏', 'id': '' });
        //     lotteryList = temp;
        //   }
        // });
      }
    });
  }

  // 列表状态
  _listState(item) {
    if(item['challenge'] == 1) {
     return Text('单挑', style: TextStyle(fontSize: Screen.width(26), color: Colors.grey));
    } else if(item['status'] == 0) {
      return Text('待开奖', style: TextStyle(fontSize: Screen.width(26), color: Colors.grey));
    } else if(item['status'] == 1) {
      return Text('已撤销', style: TextStyle(fontSize: Screen.width(26), color: Colors.grey));
    } else if(item['is_win'] == 1) {
      return Text('${item["bonus"]}元', style: TextStyle(fontSize: Screen.width(26), color: Colors.red));
    } else if(item['is_win'] == 2) {
      return Text('未中奖', style: TextStyle(fontSize: Screen.width(26), color: Colors.green));
    }
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