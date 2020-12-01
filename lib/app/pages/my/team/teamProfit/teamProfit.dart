import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

import '../../../../../services/utils.dart';
import '../../../../../api/api.dart';
import '../../../../component/component.dart';
import '../../../../component/picker.dart';
import '../../../../component/dialog.dart';

class TeamProfitPages extends StatefulWidget{
  createState() => _TeamProfitPages();
}

class _TeamProfitPages extends State {
  var page = 1;
  var pageFlag = true;
  var list = [];
  var _scrollController = ScrollController();

  // 游戏选择
  var gameList = ['cp', 'qp', 'dz', 'zr', 'by'];
  var plat = 'cp';
  // 自己
  var self = {};
  // 区间合计
  var intervalTotal = {};
  // 时间
  var startTime = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);
  var endTime = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);
  // 搜索
  var serachVal = TextEditingController();
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
  Widget build(BuildContext context) {
    Screen.init(context);
    // TODO: implement build
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {FocusScope.of(context).requestFocus(FocusNode());},
      child: Scaffold(
        appBar: HeadersComponent.Appbars(Text('团队盈亏', style: TextStyle(fontSize: Screen.width(32)),)),
        drawerEdgeDragWidth: 0.0,
        endDrawer: _endDrawer(),
        body: Container(
            width: double.infinity,
            color: Colors.white,
            child: plat == 'cp' ? _returnCon() : _returnParty()
        ),
      )
    );
  }

  _getData() async{
    // if(pageFlag == false) return;
    // var data = {
    //   'end_day': endTime,
    //   'page_index': page,
    //   'page_size': 20,
    //   'start_day': startTime
    // };
    //
    // // 获取列表
    // var salaryList;
    // if(plat == 'cp') {
    //   data.remove('plat_type');
    //   salaryList = await Api.profitList(data);
    // } else {
    //   data['plat_type'] = plat;
    //   salaryList = await Api.casinoProfitList(data);
    // }
    //
    // if(salaryList['success']) {
    //   var listData = salaryList['data']['child']['data'];
    //   serachVal.text = '';
    //   // 控制更多菜单
    //   for(var i = 0; i < listData.length; i++) {
    //     listData[i]['flag'] = false;
    //   }
    //   setState(() {
    //     self = salaryList['data']['self'];
    //     intervalTotal = salaryList['data']['part'];
    //     self['flag'] = false;
    //     intervalTotal['flag'] = false;
    //     list.addAll(listData);
    //     page++;
    //     if(salaryList['data']['child']['data'].length < 20) {
    //       pageFlag = false;
    //     }
    //   });
    // } else {
    //   setState(() {
    //     pageFlag = false;
    //   });
    // }

  }

  // 侧边栏
  _endDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(height: Screen.width(88),),
          Wrap(children: _setGameList()),

          SizedBox(height: Screen.width(50),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: Screen.width(75),
                child: TextField(
                  controller: serachVal,
                  scrollPadding: EdgeInsets.all(0),
                  style: TextStyle(fontSize: Screen.width(27), height: Screen.width(2.5)),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(top: 0, bottom: 0, right: 0, left: Screen.width(10)),
                    hintText: '按用户名查询',
                    labelText: '按用户名查询',
                    border: OutlineInputBorder(
                        borderSide: BorderSide(width: Screen.width(1), color: Colors.grey),
                        borderRadius: BorderRadius.circular(Screen.width(8))
                    ),
                    labelStyle: TextStyle(color: Colors.grey),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                ),
                width: Screen.width(400),
                margin: EdgeInsets.only(left: Screen.width(15)),
              ),
              SizedBox(width: Screen.width(5),),
              Expanded(
                child: ButtonComponent.material(title: '查询', height: 75, elevation: 0.0, pressed: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  if(serachVal.text.isEmpty) {
                    DialogComponents.toast(context, content: '请输入用户名');
                    return;
                  }
                  setState(() {
                    list = [];page = 1;pageFlag = true;
                  });
                  _getData();
                  Navigator.pop(context);
                },),
              ),
              SizedBox(width: Screen.width(15),),
            ],
          ),

          GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: Container(
                  margin: EdgeInsets.all(Screen.width(15)),
                  height: Screen.width(70),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      border: Border.all(width: Screen.width(1.5), color: Colors.grey),
                      borderRadius: BorderRadius.all(Radius.circular(Screen.width(8)))
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(Icons.access_time, size: Screen.width(35), color: Colors.black45,),
                      SizedBox(width: Screen.width(5),),
                      Text('${startTime}', style: TextStyle(fontSize: Screen.width(26)),),
                    ],
                  )
              ),
              onTap: () {
                PickerTool.showDatePicker(context, clickCallback: (str, time){
                  print(str);print(time);
                  var start = DateTime.parse(formatDate(DateTime.parse(time), [yyyy, '-', mm, '-', dd]));
                  var end = DateTime.parse(endTime);
                  if(start.millisecondsSinceEpoch > end.millisecondsSinceEpoch) {
                    DialogComponents.toast(context, content: '开始时间不能大于结束时间');
                    setState(() {
                      startTime = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);
                      endTime = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);
                    });
                    return;
                  }
                  setState(() {
                    startTime = formatDate(DateTime.parse(time), [yyyy, '-', mm, '-', dd]);
                    list = [];page = 1;pageFlag = true;
                  });
                  _getData();
                  Navigator.pop(context);
                }
                );
              }
          ),
          Text('至', style: TextStyle(fontSize: Screen.width(28)), textAlign: TextAlign.center,),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Container(
                margin: EdgeInsets.only(bottom: Screen.width(15), top: Screen.width(15), left: Screen.width(15), right: Screen.width(15)),
                height: Screen.width(70),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    border: Border.all(width: Screen.width(1.5), color: Colors.grey),
                    borderRadius: BorderRadius.all(Radius.circular(Screen.width(8)))
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.access_time, size: Screen.width(35), color: Colors.black45,),
                    SizedBox(width: Screen.width(5),),
                    Text('${endTime}', style: TextStyle(fontSize: Screen.width(26)),),
                  ],
                )
            ),
            onTap: () {
              PickerTool.showDatePicker(context, clickCallback: (str, time){
                print(str);print(time);
                var start = DateTime.parse(startTime);
                var end = DateTime.parse(formatDate(DateTime.parse(time), [yyyy, '-', mm, '-', dd]));
                if(start.millisecondsSinceEpoch > end.millisecondsSinceEpoch) {
                  DialogComponents.toast(context, content: '开始时间不能大于结束时间');
                  setState(() {
                    startTime = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);
                    endTime = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);
                  });
                  return;
                }
                setState(() {
                  endTime = formatDate(DateTime.parse(time), [yyyy, '-', mm, '-', dd]);
                  list = [];page = 1;pageFlag = true;
                });
                _getData();
                Navigator.pop(context);
              }
              );
            },
          ),
        ],
      ),
    );
  }
  // 设置游戏
  _setGameList() {
    return gameList.map((val) {
      return Container(
        margin: EdgeInsets.only(left: Screen.width(15), top: Screen.width(15)),
        child: OutlineButton(
            textColor: plat == val ? ColorGather.colorMain() : Colors.black87,
            child: Text('${val}', style: TextStyle(fontSize: Screen.width(26)),),
            padding: EdgeInsets.all(0),
            highlightedBorderColor: Colors.grey,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5)
            ),
            borderSide: BorderSide(
              color: plat == val ? ColorGather.colorMain() : Colors.grey,
            ),
            onPressed: () {
              setState(() {
                plat = val;
                list = [];page = 1;pageFlag = true;
              });
              _getData();
              Navigator.pop(context);
            }),
        width: Screen.width(188),
        height: Screen.width(65),
      );
    }).toList();
  }
  // 内容
  _returnCon () {
    return Column(
      children: <Widget>[

        Container(
          alignment: Alignment.center,
          height: Screen.width(82),
          padding: EdgeInsets.only(top: Screen.width(15), bottom: Screen.width(15)),
          color: ColorGather.colorBg(),
          child: Text('自己', style: TextStyle(fontSize: Screen.width(28)),),
        ),
        // 数据标题
        Container(
          padding: EdgeInsets.only(top: Screen.width(20), bottom: Screen.width(16)),
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Container(
                child: Text('用户名', style: TextStyle(fontSize: Screen.width(28)),),
                width: Screen.weightWidth(context) / 4.5,
                alignment: Alignment.center,
              ),
              Container(
                child: Text('充值金额', style: TextStyle(fontSize: Screen.width(28)),),
                width: Screen.weightWidth(context) / 4.5,
                alignment: Alignment.center,
              ),
              Container(
                child: Text('购买金额', style: TextStyle(fontSize: Screen.width(28)),),
                width: Screen.weightWidth(context) / 4.5,
                alignment: Alignment.center,
              ),
              Container(
                child: Text('净盈亏', style: TextStyle(fontSize: Screen.width(28)),),
                width: Screen.weightWidth(context) / 4.5,
                alignment: Alignment.center,
              ),
              Container(
                child: Text('更多', style: TextStyle(fontSize: Screen.width(28)),),
                alignment: Alignment.center,
              ),
            ],
          ),
        ),
        // 直接显示的数据
        Container(
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Container(
                child: Text('${self["username"] ?? ''}', style: TextStyle(fontSize: Screen.width(26)),),
                width: Screen.weightWidth(context) / 4.5,
                alignment: Alignment.center,
              ),
              Container(
                child: Text('${self["recharge_amount"] ?? ''}', style: TextStyle(fontSize: Screen.width(26)),),
                width: Screen.weightWidth(context) / 4.5,
                alignment: Alignment.center,
              ),
              Container(
                child: Text('${self["bets"] ?? ''}', style: TextStyle(fontSize: Screen.width(26)),),
                width: Screen.weightWidth(context) / 4.5,
                alignment: Alignment.center,
              ),
              Container(
                child: Text('${self["profit"] ?? ''}', style: TextStyle(fontSize: Screen.width(26)),),
                width: Screen.weightWidth(context) / 4.5,
                alignment: Alignment.center,
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Container(
                  child: Icon(self['flag'] == true ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right, size: Screen.width(40),),
                  alignment: Alignment.center,
                ),
                onTap: () {
                  setState(() {
                    self['flag'] = !self['flag'];
                    intervalTotal['flag'] = false;
                  });
                },
              )
            ],
          ),
          padding: EdgeInsets.only(top: Screen.width(20), bottom: Screen.width(16)),
        ),
        // 更多数据
        Offstage(
            offstage: self['flag'] == null || self['flag'] == false,
            child: Container(
                padding: EdgeInsets.only(top: Screen.width(20), bottom: Screen.width(20), left: Screen.width(45), right: Screen.width(45)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(width: Screen.width(1), color: Colors.grey),
                      bottom: BorderSide(width: Screen.width(1), color: Colors.grey),
                    )
                ),
                child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('提现总额', style: TextStyle(fontSize: Screen.width(26)),),
                          Text('${self["withdraw_amount"]}', style: TextStyle(fontSize: Screen.width(26)),)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('购买返点', style: TextStyle(fontSize: Screen.width(26)),),
                          Text('${self["commission_from_bet"]}', style: TextStyle(fontSize: Screen.width(26)),)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('下级返点', style: TextStyle(fontSize: Screen.width(26)),),
                          Text('${self["commission_from_child"]}', style: TextStyle(fontSize: Screen.width(26)),)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('派奖总额', style: TextStyle(fontSize: Screen.width(26)),),
                          Text('${self["bonus"]}', style: TextStyle(fontSize: Screen.width(26)),)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('促销红利', style: TextStyle(fontSize: Screen.width(26)),),
                          Text('${self["gift"]}', style: TextStyle(fontSize: Screen.width(26)),)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('游戏盈亏', style: TextStyle(fontSize: Screen.width(26)),),
                          Text('${self["game_profit"]}', style: TextStyle(fontSize: Screen.width(26)),)
                        ],
                      )
                    ]
                ))),

        // 区间合计
        Container(
          alignment: Alignment.center,
          height: Screen.width(82),
          padding: EdgeInsets.only(top: Screen.width(15), bottom: Screen.width(15)),
          color: ColorGather.colorBg(),
          child: Text('区间合计', style: TextStyle(fontSize: Screen.width(28)),),
        ),
        // 数据标题
        Container(
          padding: EdgeInsets.only(top: Screen.width(20), bottom: Screen.width(16)),
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Container(
                child: Text('充值金额', style: TextStyle(fontSize: Screen.width(28)),),
                width: Screen.weightWidth(context) / 4.5,
                alignment: Alignment.center,
              ),
              Container(
                child: Text('购买金额', style: TextStyle(fontSize: Screen.width(28)),),
                width: Screen.weightWidth(context) / 4.5,
                alignment: Alignment.center,
              ),
              Container(
                child: Text('净盈亏', style: TextStyle(fontSize: Screen.width(28)),),
                width: Screen.weightWidth(context) / 4.5,
                alignment: Alignment.center,
              ),
              Container(
                child: Text('下级返点', style: TextStyle(fontSize: Screen.width(28)),),
                width: Screen.weightWidth(context) / 4.5,
                alignment: Alignment.center,
              ),
              Container(
                child: Text('更多', style: TextStyle(fontSize: Screen.width(28)),),
                alignment: Alignment.center,
              ),
            ],
          ),
        ),
        // 直接显示的数据
        Container(
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Container(
                child: Text('${intervalTotal["recharge_amount"] ?? ''}', style: TextStyle(fontSize: Screen.width(26)),),
                width: Screen.weightWidth(context) / 4.5,
                alignment: Alignment.center,
              ),
              Container(
                child: Text('${intervalTotal["bets"] ?? ''}', style: TextStyle(fontSize: Screen.width(26)),),
                width: Screen.weightWidth(context) / 4.5,
                alignment: Alignment.center,
              ),
              Container(
                child: Text('${intervalTotal["profit"] ?? ''}', style: TextStyle(fontSize: Screen.width(26)),),
                width: Screen.weightWidth(context) / 4.5,
                alignment: Alignment.center,
              ),
              Container(
                child: Text('${intervalTotal["commission_from_child"] ?? ''}', style: TextStyle(fontSize: Screen.width(26)),),
                width: Screen.weightWidth(context) / 4.5,
                alignment: Alignment.center,
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Container(
                  child: Icon(intervalTotal['flag'] == true ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right, size: Screen.width(40),),
                  alignment: Alignment.center,
                ),
                onTap: () {
                  setState(() {
                    intervalTotal['flag'] = !intervalTotal['flag'];
                    self['flag'] = false;
                  });
                },
              )
            ],
          ),
          padding: EdgeInsets.only(top: Screen.width(20), bottom: Screen.width(16)),
        ),
        // 更多数据
        Offstage(
            offstage: intervalTotal['flag'] == null || intervalTotal['flag'] == false,
            child: Container(
                padding: EdgeInsets.only(top: Screen.width(20), bottom: Screen.width(20), left: Screen.width(45), right: Screen.width(45)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(width: Screen.width(1), color: Colors.grey),
                      bottom: BorderSide(width: Screen.width(1), color: Colors.grey),
                    )
                ),
                child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('提现总额', style: TextStyle(fontSize: Screen.width(26)),),
                          Text('${intervalTotal["withdraw_amount"]}', style: TextStyle(fontSize: Screen.width(26)),)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('购买返点', style: TextStyle(fontSize: Screen.width(26)),),
                          Text('${intervalTotal["commission_from_bet"]}', style: TextStyle(fontSize: Screen.width(26)),)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('下级返点', style: TextStyle(fontSize: Screen.width(26)),),
                          Text('${intervalTotal["commission_from_child"]}', style: TextStyle(fontSize: Screen.width(26)),)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('购买奖金', style: TextStyle(fontSize: Screen.width(26)),),
                          Text('${intervalTotal["bonus"]}', style: TextStyle(fontSize: Screen.width(26)),)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('礼金', style: TextStyle(fontSize: Screen.width(26)),),
                          Text('${intervalTotal["gift"]}', style: TextStyle(fontSize: Screen.width(26)),)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('游戏盈亏', style: TextStyle(fontSize: Screen.width(26)),),
                          Text('${intervalTotal["game_profit"]}', style: TextStyle(fontSize: Screen.width(26)),)
                        ],
                      )
                    ]
                ))),

        // 直属下级报表
        Container(
          alignment: Alignment.center,
          height: Screen.width(82),
          padding: EdgeInsets.only(top: Screen.width(15), bottom: Screen.width(15)),
          color: ColorGather.colorBg(),
          child: Text('直属下级报表', style: TextStyle(fontSize: Screen.width(28)),),
        ),
        // 数据标题
        Container(
          padding: EdgeInsets.only(top: Screen.width(20), bottom: Screen.width(16)),
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Container(
                child: Text('用户名', style: TextStyle(fontSize: Screen.width(28)),),
                width: Screen.weightWidth(context) / 4.5,
                alignment: Alignment.center,
              ),
              Container(
                child: Text('充值金额', style: TextStyle(fontSize: Screen.width(28)),),
                width: Screen.weightWidth(context) / 4.5,
                alignment: Alignment.center,
              ),
              Container(
                child: Text('购买金额', style: TextStyle(fontSize: Screen.width(28)),),
                width: Screen.weightWidth(context) / 4.5,
                alignment: Alignment.center,
              ),
              Container(
                child: Text('净盈亏', style: TextStyle(fontSize: Screen.width(28)),),
                width: Screen.weightWidth(context) / 4.5,
                alignment: Alignment.center,
              ),
              Container(
                child: Text('更多', style: TextStyle(fontSize: Screen.width(28)),),
                alignment: Alignment.center,
              ),
            ],
          ),
        ),
        // 展示数据
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
                    // 直接显示的数据
                    Container(
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Text('${list[index]["username"] ?? ''}', style: TextStyle(fontSize: Screen.width(26)),),
                            width: Screen.weightWidth(context) / 3.4,
                            alignment: Alignment.center,
                          ),
                          Container(
                            child: Text('${list[index]["recharge_amount"] ?? ''}', style: TextStyle(fontSize: Screen.width(26)),),
                            width: Screen.weightWidth(context) / 3.4,
                            alignment: Alignment.center,
                          ),
                          Container(
                            child: Text('${list[index]["bets"] ?? ''}', style: TextStyle(fontSize: Screen.width(26)),),
                            width: Screen.weightWidth(context) / 3.4,
                            alignment: Alignment.center,
                          ),
                          Container(
                            child: Text('${list[index]["profit"] ?? ''}', style: TextStyle(fontSize: Screen.width(26)),),
                            width: Screen.weightWidth(context) / 3.4,
                            alignment: Alignment.center,
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              child: Icon(list[index]['flag'] == true ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right, size: Screen.width(40),),
                              alignment: Alignment.center,
                            ),
                            onTap: () {
                              setState(() {
                                list[index]['flag'] = !list[index]['flag'];
                                self['flag'] = false;
                                intervalTotal['flag'] = false;
                              });
                            },
                          )
                        ],
                      ),
                      padding: EdgeInsets.only(top: Screen.width(20), bottom: Screen.width(16)),
                    ),

                    // 更多数据
                    Offstage(
                        offstage: list[index]['flag'] == false,
                        child: Container(
                            padding: EdgeInsets.only(top: Screen.width(20), bottom: Screen.width(20), left: Screen.width(45), right: Screen.width(45)),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                  top: BorderSide(width: Screen.width(1), color: Colors.grey),
                                  bottom: BorderSide(width: Screen.width(1), color: Colors.grey),
                                )
                            ),
                            child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('提现总额', style: TextStyle(fontSize: Screen.width(26)),),
                                      Text('${list[index]["withdraw_amount"]}', style: TextStyle(fontSize: Screen.width(26)),)
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('购买返点', style: TextStyle(fontSize: Screen.width(26)),),
                                      Text('${list[index]["commission_from_bet"]}', style: TextStyle(fontSize: Screen.width(26)),)
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('下级返点', style: TextStyle(fontSize: Screen.width(26)),),
                                      Text('${list[index]["commission_from_child"]}', style: TextStyle(fontSize: Screen.width(26)),)
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('派奖总额', style: TextStyle(fontSize: Screen.width(26)),),
                                      Text('${list[index]["bonus"]}', style: TextStyle(fontSize: Screen.width(26)),)
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('促销红利', style: TextStyle(fontSize: Screen.width(26)),),
                                      Text('${list[index]["gift"]}', style: TextStyle(fontSize: Screen.width(26)),)
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('游戏盈亏', style: TextStyle(fontSize: Screen.width(26)),),
                                      Text('${list[index]["game_profit"]}', style: TextStyle(fontSize: Screen.width(26)),)
                                    ],
                                  )
                                ]
                            ))),
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
      ],
    );
  }

  // 第三方平台
  _returnParty () {
    return Column(
      children: <Widget>[
        Container(
          alignment: Alignment.center,
          height: Screen.width(82),
          padding: EdgeInsets.only(top: Screen.width(15), bottom: Screen.width(15)),
          color: ColorGather.colorBg(),
          child: Text('自己', style: TextStyle(fontSize: Screen.width(28)),),
        ),
        // 数据标题
        Container(
          padding: EdgeInsets.only(top: Screen.width(20), bottom: Screen.width(16)),
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Container(
                child: Text('用户名', style: TextStyle(fontSize: Screen.width(28)),),
                width: Screen.weightWidth(context) / 3.4,
                alignment: Alignment.center,
              ),
              Container(
                child: Text('公司派彩', style: TextStyle(fontSize: Screen.width(28)),),
                width: Screen.weightWidth(context) / 3.4,
                alignment: Alignment.center,
              ),
              Container(
                child: Text('公司输赢', style: TextStyle(fontSize: Screen.width(28)),),
                width: Screen.weightWidth(context) / 3.4,
                alignment: Alignment.center,
              ),
              Container(
                child: Text('更多', style: TextStyle(fontSize: Screen.width(28)),),
                alignment: Alignment.center,
              )
            ],
          ),
        ),
        // 直接显示的数据
        Container(
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Container(
                child: Text('${self["username"] ?? ''}', style: TextStyle(fontSize: Screen.width(26)),),
                width: Screen.weightWidth(context) / 3.4,
                alignment: Alignment.center,
              ),
              Container(
                child: Text('${self["company_payout_amount"] ?? ''}', style: TextStyle(fontSize: Screen.width(26)),),
                width: Screen.weightWidth(context) / 3.4,
                alignment: Alignment.center,
              ),
              Container(
                child: Text('${self["company_win_amount"] ?? ''}', style: TextStyle(fontSize: Screen.width(26)),),
                width: Screen.weightWidth(context) / 3.4,
                alignment: Alignment.center,
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Container(
                  child: Icon(self['flag'] == true ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right, size: Screen.width(40),),
                  alignment: Alignment.center,
                ),
                onTap: () {
                  setState(() {
                    self['flag'] = !self['flag'];
                    intervalTotal['flag'] = false;
                  });
                },
              )
            ],
          ),
          padding: EdgeInsets.only(top: Screen.width(20), bottom: Screen.width(16)),
        ),
        // 更多数据
        Offstage(
            offstage: self['flag'] == null || self['flag'] == false,
            child: Container(
                padding: EdgeInsets.only(top: Screen.width(20), bottom: Screen.width(20), left: Screen.width(45), right: Screen.width(45)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(width: Screen.width(1), color: Colors.grey),
                      bottom: BorderSide(width: Screen.width(1), color: Colors.grey),
                    )
                ),
                child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('活动红利', style: TextStyle(fontSize: Screen.width(26)),),
                          Text('${self["company_win_neat_amount"]}', style: TextStyle(fontSize: Screen.width(26)),)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('购买金额', style: TextStyle(fontSize: Screen.width(26)),),
                          Text('${self["bet_amount"]}', style: TextStyle(fontSize: Screen.width(26)),)
                        ],
                      )
                    ]
                ))),

        // 区间合计
        Container(
          alignment: Alignment.center,
          height: Screen.width(82),
          padding: EdgeInsets.only(top: Screen.width(15), bottom: Screen.width(15)),
          color: ColorGather.colorBg(),
          child: Text('区间合计', style: TextStyle(fontSize: Screen.width(28)),),
        ),
        // 数据标题
        Container(
          padding: EdgeInsets.only(top: Screen.width(20), bottom: Screen.width(16)),
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Container(
                child: Text('用户名', style: TextStyle(fontSize: Screen.width(28)),),
                width: Screen.weightWidth(context) / 3.4,
                alignment: Alignment.center,
              ),
              Container(
                child: Text('公司派彩', style: TextStyle(fontSize: Screen.width(28)),),
                width: Screen.weightWidth(context) / 3.4,
                alignment: Alignment.center,
              ),
              Container(
                child: Text('公司输赢', style: TextStyle(fontSize: Screen.width(28)),),
                width: Screen.weightWidth(context) / 3.4,
                alignment: Alignment.center,
              ),
              Container(
                child: Text('更多', style: TextStyle(fontSize: Screen.width(28)),),
                alignment: Alignment.center,
              )
            ],
          ),
        ),
        // 直接显示的数据
        Container(
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Container(
                child: Text('${intervalTotal["username"] ?? ''}', style: TextStyle(fontSize: Screen.width(26)),),
                width: Screen.weightWidth(context) / 3.4,
                alignment: Alignment.center,
              ),
              Container(
                child: Text('${intervalTotal["company_payout_amount"] ?? ''}', style: TextStyle(fontSize: Screen.width(26)),),
                width: Screen.weightWidth(context) / 3.4,
                alignment: Alignment.center,
              ),
              Container(
                child: Text('${intervalTotal["company_win_amount"] ?? ''}', style: TextStyle(fontSize: Screen.width(26)),),
                width: Screen.weightWidth(context) / 3.4,
                alignment: Alignment.center,
              ),
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Container(
                  child: Icon(intervalTotal['flag'] == true ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right, size: Screen.width(40),),
                  alignment: Alignment.center,
                ),
                onTap: () {
                  setState(() {
                    intervalTotal['flag'] = !intervalTotal['flag'];
                    self['flag'] = false;
                  });
                },
              )
            ],
          ),
          padding: EdgeInsets.only(top: Screen.width(20), bottom: Screen.width(16)),
        ),
        // 更多数据
        Offstage(
            offstage: intervalTotal['flag'] == null || intervalTotal['flag'] == false,
            child: Container(
                padding: EdgeInsets.only(top: Screen.width(20), bottom: Screen.width(20), left: Screen.width(45), right: Screen.width(45)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(width: Screen.width(1), color: Colors.grey),
                      bottom: BorderSide(width: Screen.width(1), color: Colors.grey),
                    )
                ),
                child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('活动红利', style: TextStyle(fontSize: Screen.width(26)),),
                          Text('${intervalTotal["company_win_neat_amount"]}', style: TextStyle(fontSize: Screen.width(26)),)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('购买金额', style: TextStyle(fontSize: Screen.width(26)),),
                          Text('${intervalTotal["bet_amount"]}', style: TextStyle(fontSize: Screen.width(26)),)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('净盈亏', style: TextStyle(fontSize: Screen.width(26)),),
                          Text('${intervalTotal["profit"]}', style: TextStyle(fontSize: Screen.width(26)),)
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('游戏盈亏', style: TextStyle(fontSize: Screen.width(26)),),
                          Text('${intervalTotal["game_profit"]}', style: TextStyle(fontSize: Screen.width(26)),)
                        ],
                      )
                    ]
                ))),

        // 直属下级报表
        Container(
          alignment: Alignment.center,
          height: Screen.width(82),
          padding: EdgeInsets.only(top: Screen.width(15), bottom: Screen.width(15)),
          color: ColorGather.colorBg(),
          child: Text('直属下级报表', style: TextStyle(fontSize: Screen.width(28)),),
        ),
        // 数据标题
        Container(
          padding: EdgeInsets.only(top: Screen.width(20), bottom: Screen.width(16)),
          color: Colors.white,
          child: Row(
            children: <Widget>[
              Container(
                child: Text('用户名', style: TextStyle(fontSize: Screen.width(28)),),
                width: Screen.weightWidth(context) / 3.4,
                alignment: Alignment.center,
              ),
              Container(
                child: Text('公司派彩', style: TextStyle(fontSize: Screen.width(28)),),
                width: Screen.weightWidth(context) / 3.4,
                alignment: Alignment.center,
              ),
              Container(
                child: Text('公司输赢', style: TextStyle(fontSize: Screen.width(28)),),
                width: Screen.weightWidth(context) / 3.4,
                alignment: Alignment.center,
              ),
              Container(
                child: Text('更多', style: TextStyle(fontSize: Screen.width(28)),),
                alignment: Alignment.center,
              )
            ],
          ),
        ),
        // 展示数据
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
                    // 直接显示的数据
                    Container(
                      color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Container(
                            child: Text('${list[index]["username"] ?? ''}', style: TextStyle(fontSize: Screen.width(26)),),
                            width: Screen.weightWidth(context) / 3.4,
                            alignment: Alignment.center,
                          ),
                          Container(
                            child: Text('${list[index]["company_payout_amount"] ?? ''}', style: TextStyle(fontSize: Screen.width(26)),),
                            width: Screen.weightWidth(context) / 3.4,
                            alignment: Alignment.center,
                          ),
                          Container(
                            child: Text('${list[index]["company_win_amount"] ?? ''}', style: TextStyle(fontSize: Screen.width(26)),),
                            width: Screen.weightWidth(context) / 3.4,
                            alignment: Alignment.center,
                          ),
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              child: Icon(list[index]['flag'] == true ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right, size: Screen.width(40),),
                              alignment: Alignment.center,
                            ),
                            onTap: () {
                              setState(() {
                                list[index]['flag'] = !list[index]['flag'];
                                self['flag'] = false;
                                intervalTotal['flag'] = false;
                              });
                            },
                          )
                        ],
                      ),
                      padding: EdgeInsets.only(top: Screen.width(20), bottom: Screen.width(16)),
                    ),

                    // 更多数据
                    Offstage(
                        offstage: list[index]['flag'] == false,
                        child: Container(
                            padding: EdgeInsets.only(top: Screen.width(20), bottom: Screen.width(20), left: Screen.width(45), right: Screen.width(45)),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border(
                                  top: BorderSide(width: Screen.width(1), color: Colors.grey),
                                  bottom: BorderSide(width: Screen.width(1), color: Colors.grey),
                                )
                            ),
                            child: Column(
                                children: <Widget>[
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('活动红利', style: TextStyle(fontSize: Screen.width(26)),),
                                      Text('${list[index]["company_win_neat_amount"]}', style: TextStyle(fontSize: Screen.width(26)),)
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('购买金额', style: TextStyle(fontSize: Screen.width(26)),),
                                      Text('${list[index]["bet_amount"]}', style: TextStyle(fontSize: Screen.width(26)),)
                                    ],
                                  )
                                ]
                            ))),
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
      ],
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