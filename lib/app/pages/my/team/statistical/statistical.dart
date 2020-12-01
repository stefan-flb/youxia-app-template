import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xw/api/api.dart';

import '../../../../../services/utils.dart';
import '../../../../component/component.dart';
import '../../../../component/dialog.dart';
import '../../../../component/picker.dart';

class Statistical extends StatefulWidget{
  Statistical({Key key});
  _Statistical createState() => _Statistical();
}

class _Statistical extends State {
  // 时间按钮
  var timeList = [
    {
      'title': '今天',
      'startTime': formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]),
      'endTime': formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]),
      'disable': false
    },
    {
      'title': '昨天',
      'startTime': formatDate(DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch - (24 * 60 * 60 * 1000)), [yyyy, '-', mm, '-', dd]),
      'endTime': formatDate(DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch - (24 * 60 * 60 * 1000)), [yyyy, '-', mm, '-', dd]),
      'color': Colors.white
    },
    {
      'title': '上半月',
      'startTime': formatDate(DateTime(DateTime.now().year, DateTime.now().month, 1), [yyyy, '-', mm, '-', dd]),
      'endTime': '',
      'color': Colors.white
    },
    {
      'title': '下半月',
      'startTime': '',
      'endTime': formatDate(DateTime(DateTime.now().year, DateTime.now().month + 1 , 0), [yyyy, '-', mm, '-', dd]),
      'color': Colors.white
    },
    {
      'title': '本月',
      'startTime': formatDate(DateTime(DateTime.now().year, DateTime.now().month, 1), [yyyy, '-', mm, '-', dd]),
      'endTime': formatDate(DateTime(DateTime.now().year, DateTime.now().month + 1 , 0), [yyyy, '-', mm, '-', dd]),
      'color': Colors.white
    },
  ];
  var timeIndex = 0;

  // 时间
  var startTime = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);
  var endTime = formatDate(DateTime.now(), [yyyy, '-', mm, '-', dd]);
  // 搜索
  var serachVal = TextEditingController();

  // 人数统计
  var personStatistical = [];
  Map personFieldNames = {
    'team_have_bet': '购买人数',
    'team_first_register': '新注册/总人数',
    'team_first_recharge_count': '首充人数',
    'team_repeat_recharge_count': '复冲人数'
  };
  // 数据统计
  var dataFieldNames = {
    'team_balance': '团队余额',
    'team_recharge_count': '充值金额',
    'team_withdraw_count': '提现金额',
    'team_bets': '购买金额',
    'team_bonus': '派奖总额',
    'team_commission_from_bet': '购买返点',
    'team_commission_from_child': '代理返点',
    'team_gift': '活动礼金',
    'salary': '日工资',
    'profit': '净盈亏',
  };
  var dataStatistical = [];
  @override
  initState() {
    super.initState();
    _init();
  }
  Widget build(BuildContext context) {
    Screen.init(context);
    // TODO: implement build
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {FocusScope.of(context).requestFocus(FocusNode());},
      child: Scaffold(
          appBar: HeadersComponent.Appbars(
            Text('代理首页', style: TextStyle(fontSize: Screen.width(32)),),
          ),
          body: Container(
            color: Color.fromRGBO(248, 248, 248, 1),
            child: ListView(
              children: <Widget>[
                // 时间按钮
                Container(
                  padding: EdgeInsets.all(Screen.width(15)),
                  child: GridView.builder(
                    itemCount: timeList.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 5,
                        mainAxisSpacing: 0,
                        crossAxisSpacing: 7,
                        childAspectRatio: 4 / 2
                    ),
                    itemBuilder: (context, index) {
                      return RaisedButton(
                        padding: EdgeInsets.all(0),
                        color: timeIndex == index ? Color.fromRGBO(186, 219, 255, 1) : Colors.white,
                        elevation: 0,
                        disabledColor: Colors.grey,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Screen.width(10)),
                          side: BorderSide(
                            color: timeIndex == index ? Color.fromRGBO(186, 219, 255, 1) : Color.fromRGBO(220, 223, 230, 1),
                          )
                        ),
                        child: Text('${timeList[index]["title"]}', style: TextStyle(fontSize: Screen.width(27)),),
                        onPressed: timeList[index]['title'] == '下半月' && DateTime.now().day < DateTime.parse(timeList[index]['startTime']).day ? null : () {
                          setState(() {
                            timeIndex = index;
                            startTime = timeList[index]['startTime'];
                            endTime = timeList[index]['endTime'];
                            _init();
                          });
                        },
                      );
                    },
                  ),
                ),

//              时间选择框  搜索框
                Container(
                    padding: EdgeInsets.all(Screen.width(15)),
                    alignment: Alignment.center,
                    color: Colors.white,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              child: Container(
                                  width: (Screen.weightWidth(context) - 15) / 2.2,
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
                                        timeIndex = -1;
                                        startTime = formatDate(DateTime.parse(time), [yyyy, '-', mm, '-', dd]);
                                      });
                                      _init();
                                    }
                                );
                              }
                            ),
                            Text(' 至 ', style: TextStyle(fontSize: Screen.width(28)),),
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              child: Container(
                                  width: (Screen.weightWidth(context) - 15) / 2.2,
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
                                    timeIndex = -1;
                                  });
                                  _init();
                                }
                                );
                              },
                            ),
                          ],
                        ),

                        SizedBox(height: Screen.width(25),),

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
                                _init();
                              },),
                            )
                          ],
                        )
                      ],
                    )
                ),

                // 人数统计
                Container(
                  padding: EdgeInsets.all(Screen.width(25)),
                  child: Text('人数统计', style: TextStyle(fontSize: Screen.width(30)),),
                ),
                Container(
                  color: Colors.white,
                  child: GridView.builder(
                    itemCount: personStatistical.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: Screen.width(4),
                      childAspectRatio: 3 / 2.5,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(width: Screen.width(3), color: index != 0 && (index + 1) % 3 == 0 ? Colors.white : Color.fromRGBO(248, 248, 248, 1)),
                            bottom: BorderSide(
                                width: Screen.width((personStatistical.length - 1) - index < _setBorder() ? 0 : 3),
                                color: (personStatistical.length - 1) - index < _setBorder() ? Colors.white : Color.fromRGBO(248, 248, 248, 1))
                          )
                        ),
                        child: ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            Text('${personStatistical[index]['title']}', style: TextStyle(fontSize: Screen.width(26)), textAlign: TextAlign.center,),
                            SizedBox(height: Screen.width(10),),
                            Text('${personStatistical[index]['value']}', style: TextStyle(fontSize: Screen.width(28)), textAlign: TextAlign.center,),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                // 数据统计
                Container(
                  padding: EdgeInsets.all(Screen.width(25)),
                  child: Text('数据统计 (游戏)', style: TextStyle(fontSize: Screen.width(30)),),
                ),
                Container(
                  color: Colors.white,
                  child: GridView.builder(
                    itemCount: dataStatistical.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 0,
                      crossAxisSpacing: Screen.width(4),
                      childAspectRatio: 3 / 2.5,
                    ),
                    itemBuilder: (context, index) {
                      return Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border(
                                right: BorderSide(width: Screen.width(3), color: index != 0 && (index + 1) % 3 == 0 ? Colors.white : Color.fromRGBO(248, 248, 248, 1)),
                                bottom: BorderSide(
                                    width: Screen.width((dataStatistical.length - 1) - index < _setBorder() ? 0 : 3),
                                    color: (dataStatistical.length - 1) - index < _setBorder() ? Colors.white : Color.fromRGBO(248, 248, 248, 1))
                            )
                        ),
                        child: ListView(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          children: <Widget>[
                            Text('${dataStatistical[index]['title']}', style: TextStyle(fontSize: Screen.width(26)), textAlign: TextAlign.center,),
                            SizedBox(height: Screen.width(10),),
                            Text('${dataStatistical[index]['value']}', style: TextStyle(fontSize: Screen.width(28)), textAlign: TextAlign.center,),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: Screen.width(40),),
              ],
            ),
          )
      ),
    );
  }

  _init() async{
    _setDay();
    setState(() {
      personStatistical = [];
      dataStatistical = [];
    });
    // var data = {
    //   'end_day': startTime,
    //   'start_day': endTime,
    //   'username': serachVal.text
    // };
    // var response = await Api.proxyMain(data);
    //
    // if(response['success']) {
    //   serachVal.text = '';
    //   var res = response['data'];
    //   res.forEach((key, value) {
    //     if(personFieldNames.containsKey(key)) {
    //       if(key == 'team_first_register'){
    //         value = res['team_first_register'].toString();
    //         value = '${res['team_first_register']}/${res['child_count']}';
    //       }
    //       setState(() {
    //         personStatistical.add({'title': personFieldNames[key], 'value': value});
    //       });
    //     }
    //
    //     if(dataFieldNames.containsKey(key)) {
    //       setState(() {
    //         dataStatistical.add({'title': dataFieldNames[key], 'value': value});
    //       });
    //     }
    //   });
    // }
  }
  // 上半月 下半月
  _setDay() {
    var getDay = DateTime(DateTime.now().year, DateTime.now().month + 1 , 0).toString();
    setState(() {
      timeList[2]['endTime'] = formatDate(DateTime(DateTime.now().year, DateTime.now().month, (DateTime.parse(getDay).day / 2).floor()), [yyyy, '-', mm, '-', dd]);
      timeList[3]['startTime'] = formatDate(DateTime(DateTime.now().year, DateTime.now().month, (DateTime.parse(getDay).day / 2).ceil()), [yyyy, '-', mm, '-', dd]);
    });
  }

  // 计算边框
  _setBorder () {
    switch(personStatistical.length % 3) {
      case 0:
        return 3;
        break;
      case 1:
        return 1;
        break;
      case 2:
        return 2;
        break;
    }
  }
}