import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';

import '../../../../../services/utils.dart';
import '../../../../../api/api.dart';
import '../../../../component/component.dart';
import '../../../../component/picker.dart';
import '../../../../component/dialog.dart';

class ShareMoneyPages extends StatefulWidget{
  createState() => _ShareMoneyPages();
}

class _ShareMoneyPages extends State {
  var page = 1;
  var pageFlag = true;
  var list = [];
  var _scrollController = ScrollController();

  // 全选
  var allCheckBox = false;
  // 自己
  var self = {};
  // 时间
  var startTime = '';
  var timeIndex = 0;
  var timeList = [];

  // 发送分红
  var dividendChecked = [];
  // 搜索
  var serachVal = TextEditingController();
  @override
  initState() {
    super.initState();
    _setTime();
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
          appBar: HeadersComponent.Appbars(Text('代理分红报表', style: TextStyle(fontSize: Screen.width(32)),)),
          body: Container(
            width: double.infinity,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                // 搜索框
                Container(
                  padding: EdgeInsets.only(left: Screen.width(15), right: Screen.width(15)),
                  child: Row(
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
                        width: Screen.width(500),
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
                            list = [];
                            pageFlag = true;
                            page = 1;
                          });
                          _getData(username: serachVal.text);
                        },),
                      )
                    ],
                  ),
                ),

                SizedBox(height: Screen.width(5),),

                // 时间选择框
                Container(
                  padding: EdgeInsets.only(left: Screen.width(15), right: Screen.width(15)),
                  child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: Container(
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
                        var list = [timeList.map((val) {
                          return val['title'];
                        }).toList()];
                        PickerTool.showArrayPicker(context,
                            data: list, normalIndex: [0],
                            clickCallBack:(index, strData){
                              print(index); print(strData);
                              setState(() {
                                serachVal.text = '';
                                startTime = strData[0];
                                list = [];
                                pageFlag = true;
                                page = 1;
                                timeIndex = index[0];
                              });
                              _getData();
                            }
                        );

                      }
                  ),
                ),
                SizedBox(height: Screen.width(10),),
                // 自己
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
                        child: Text('购买总额', style: TextStyle(fontSize: Screen.width(28)),),
                        width: Screen.weightWidth(context) / 3.4,
                        alignment: Alignment.center,
                      ),
                      Container(
                        child: Text('净盈亏', style: TextStyle(fontSize: Screen.width(28)),),
                        width: Screen.weightWidth(context) / 3.4,
                        alignment: Alignment.center,
                      ),
                      Container(
                        child: Text('分红金额', style: TextStyle(fontSize: Screen.width(28)),),
                        width: Screen.weightWidth(context) / 3.4,
                        alignment: Alignment.center,
                      ),
                      Container(
                        child: Text('更多', style: TextStyle(fontSize: Screen.width(28)),),
                        alignment: Alignment.center,
                      ),
                    ],
                  ),
                ),
                // 自己 数据展示

                // 直接显示的数据
                Container(
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Text('${self["total_bets"] ?? ''}', style: TextStyle(fontSize: Screen.width(26)),),
                        width: Screen.weightWidth(context) / 3.4,
                        alignment: Alignment.center,
                      ),
                      Container(
                        child: Text('${self["profit"] ?? ''}', style: TextStyle(fontSize: Screen.width(26)),),
                        width: Screen.weightWidth(context) / 3.4,
                        alignment: Alignment.center,
                      ),
                      Container(
                        child: Text('${self["total_dividend"] ?? ''}', style: TextStyle(fontSize: Screen.width(26)),),
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
                                  Text('日工资', style: TextStyle(fontSize: Screen.width(26)),),
                                  Text('${self["total_salary"]}', style: TextStyle(fontSize: Screen.width(26)),)
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('促销红利', style: TextStyle(fontSize: Screen.width(26)),),
                                  Text('${self["total_gift"]}', style: TextStyle(fontSize: Screen.width(26)),)
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('返点总额', style: TextStyle(fontSize: Screen.width(26)),),
                                  Text('${self["total_commission_from_child"]}', style: TextStyle(fontSize: Screen.width(26)),)
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text('派奖总额', style: TextStyle(fontSize: Screen.width(26)),),
                                  Text('${self["total_bonus"]}', style: TextStyle(fontSize: Screen.width(26)),)
                                ],
                              )
                            ]
                        ))),


                // 直属下级报表
                Container(
                  padding: EdgeInsets.only(top: Screen.width(15), bottom: Screen.width(15)),
                  height: Screen.width(82),
                  width: double.infinity,
                  color: ColorGather.colorBg(),
                  child: Stack(
                    children: <Widget>[
                      Positioned(
                          top: 0,
                          left: Screen.screenWidth() / 4.3,
                          child: Text('直属下级报表', style: TextStyle(fontSize: Screen.width(28))),
                      ),
                      Positioned(
                          top: 0,
                          right: Screen.width(20),
                          child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              padding: EdgeInsets.only(left: Screen.width(10), right: Screen.width(10), top: Screen.width(5), bottom: Screen.width(5)),
                              decoration: BoxDecoration(
                                  color: ColorGather.colorMain(),
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              child: Text('一键派发分红', style: TextStyle(fontSize: Screen.width(24), color: Colors.white),),
                            ),
                            onTap: () async{
                              //    dividendChecked = [item.hash_id];
                              // var data = {
                              //   'parent_id': dividendChecked
                              // };
                              // var response = await Api.playerDividendSend(data);
                              // print(response);
                              // if(response['success']) {
                              //   DialogComponents.toast(context, content: response['msg']);
                              // }
                            },
                          )
                      )
                    ],
                  ),
                ),
                // 数据标题
                Container(
                  padding: EdgeInsets.only(top: Screen.width(20), bottom: Screen.width(16)),
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              child: Checkbox(
                                value: allCheckBox,
                                activeColor: ColorGather.colorMain(),
                                onChanged: (val) {
                                  setState(() {
                                    allCheckBox = val;
                                  });
                                },
                              ),
                              width: Screen.width(50),
                              height: Screen.width(30),
                            ),
                            Text('购买总额', style: TextStyle(fontSize: Screen.width(28)),),
                          ],
                        ),
                        width: Screen.weightWidth(context) / 3.4,
                        alignment: Alignment.center,
                      ),
                      Container(
                        child: Text('净盈亏', style: TextStyle(fontSize: Screen.width(28)),),
                        width: Screen.weightWidth(context) / 3.4,
                        alignment: Alignment.center,
                      ),
                      Container(
                        child: Text('分红金额', style: TextStyle(fontSize: Screen.width(28)),),
                        width: Screen.weightWidth(context) / 3.4,
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
                                    child: Text('${list[index]["total_bets"] ?? ''}', style: TextStyle(fontSize: Screen.width(26)),),
                                    width: Screen.weightWidth(context) / 3.4,
                                    alignment: Alignment.center,
                                  ),
                                  Container(
                                    child: Text('${list[index]["profit"] ?? ''}', style: TextStyle(fontSize: Screen.width(26)),),
                                    width: Screen.weightWidth(context) / 3.4,
                                    alignment: Alignment.center,
                                  ),
                                  Container(
                                    child: Text('${list[index]["total_dividend"] ?? ''}', style: TextStyle(fontSize: Screen.width(26)),),
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
                                              Text('日工资', style: TextStyle(fontSize: Screen.width(26)),),
                                              Text('${list[index]["total_salary"]}', style: TextStyle(fontSize: Screen.width(26)),)
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text('促销红利', style: TextStyle(fontSize: Screen.width(26)),),
                                              Text('${list[index]["total_gift"]}', style: TextStyle(fontSize: Screen.width(26)),)
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text('返点总额', style: TextStyle(fontSize: Screen.width(26)),),
                                              Text('${list[index]["total_commission_from_child"]}', style: TextStyle(fontSize: Screen.width(26)),)
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text('派奖总额', style: TextStyle(fontSize: Screen.width(26)),),
                                              Text('${list[index]["total_bonus"]}', style: TextStyle(fontSize: Screen.width(26)),)
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text('分红比例', style: TextStyle(fontSize: Screen.width(26)),),
                                              Text('${list[index]["rata"]}', style: TextStyle(fontSize: Screen.width(26)),)
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
            ),
          )
      ),
    );
  }

  // 设置时间选择
  _setTime() {
    var year = DateTime.now().year;
    var month = DateTime.now().month;
    var day = DateTime.now().day;

    // 上半月
    for(var i = 0; i <= 6; i++ ){
      // 获取每月的天数
      var everyDay = DateTime(year, (month + 1) - i , 0).day;
      var upDown = (everyDay / 2).floor();
      setState(() {
        timeList.add({
          'title': '${formatDate(DateTime(year, month - i, day), [yyyy, "年", mm, "月"])}上半月',
          'startTime': formatDate(DateTime(year, month - i, 1), [yyyy, '-', mm, '-', dd]),
          'endTime': formatDate(DateTime(year, month - i, upDown), [yyyy, '-', mm, '-', dd]),
        });
      });
    }

    // 下半月
    var j = 0;
    for(var i = 0; i <= 13; i++ ){
      if(i.isOdd) {
        // 获取每月的天数
        var everyDay = DateTime(year, (month + 1) - j , 0).day;

        var upDown = (everyDay / 2).floor();
        setState(() {
          timeList.insert(i, {
            'title': '${formatDate(DateTime(year, month - j, day), [yyyy, "年", mm, "月"])}下半月',
            'startTime': formatDate(DateTime(year, month - j, upDown + 1), [yyyy, '-', mm, '-', dd]),
            'endTime': formatDate(DateTime(year, month - j, everyDay), [yyyy, '-', mm, '-', dd]),
          });
        });
        if(j < 6) {
          j++;
        }

      }
    }

    // 不显示当月的下半月
    timeList.removeAt(1);
    // 如果当日未超过上半月 不显示上半月
    var uoMonth = DateTime(year, month + 1 , 0).day;
    if(day <= (uoMonth / 2).floor())  {
      timeList.removeAt(0);
    }
    startTime = timeList[timeIndex]['title'];
  }
  _getData({username}) async{
    // if(pageFlag == false) return;
    // var data = {
    //   'end_day': timeList[timeIndex]['endTime'],
    //   'page_index': page,
    //   'page_size': 20,
    //   'start_day': timeList[timeIndex]['startTime'],
    //   'username': username ?? ''
    // };
    //
    // // 获取列表
    // var salaryList = await Api.dividendList(data);
    // if(salaryList['success']) {
    //   var listData = salaryList['data']['data'];
    //   // 控制更多菜单
    //   for(var i = 0; i < listData.length; i++) {
    //     listData[i]['flag'] = false;
    //   }
    //   setState(() {
    //     self = salaryList['data']['self'];
    //     self['flag'] = false;
    //     list.addAll(listData);
    //     page++;
    //     if(salaryList['data']['data'].length < 20) {
    //       pageFlag = false;
    //     }
    //   });
    // } else {
    //   setState(() {
    //     pageFlag = false;
    //   });
    // }

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