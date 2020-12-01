import 'dart:async';
import 'dart:convert';
import 'package:date_format/date_format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../services/utils.dart';
import '../../../../../api/api.dart';
import '../../../../component/component.dart';
import '../../../../component/dialog.dart';
import '../../../../component/picker.dart';
import 'transfer.dart';
import 'shareMoney.dart';
import 'dailyWages.dart';

class TeamManage extends StatefulWidget{
  createState() => _TeamManage();
}

class _TeamManage extends State {
  var page = 1;
  var pageFlag = true;
  var list = [];
  var listIndex = 0;
  var _scrollController = ScrollController();

  // 搜索
  var userSerach = TextEditingController();
  var prizeMin = TextEditingController();
  var prizeMax = TextEditingController();
  var startTime = '选择开始时间';
  var endTime = '选择结束时间';
  // 银行卡列表
  var bankList = [];
  // 用户信息
  var userDetails = {};
  // 团队余额
  var balanceList = {};
  // 获取所有上下级列表
  var titleList = [];
  // 所有数据
  var childLists = {};
  // 设置奖金组
  var prizeGroup = 0.0;
  @override
  initState() {
    super.initState();
    Storage.getString('userDetail').then((res) {
      if(res != null) {
        var data = json.decode(res);
        setState(() {
          userDetails = data;
          titleList.add({'username': data['username'], 'id': '', 'index': 0});
        });
      }
    });

    // 获取银行卡列表
    // Api.getBankList().then((response) {
    //   if (response['success']) {
    //     setState(() {bankList = response['data']['cards'];});
    //   }
    // });

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
          appBar: HeadersComponent.Appbars(Text('团队管理', style: TextStyle(fontSize: Screen.width(32)),)),
          body: DefaultTabController(
            length: titleList.length,
            child: Container(
              width: double.infinity,
              color: ColorGather.colorBg(),
              child: Column(
                children: <Widget>[
                  // 用户名查询
                  Container(
                    padding: EdgeInsets.only(left: Screen.width(20), right: Screen.width(20), top: Screen.width(10)),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          height: Screen.width(75),
                          child: TextField(
                            controller: userSerach,
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
                          width: Screen.width(450),
                        ),
                        SizedBox(width: Screen.width(5),),
                        Expanded(
                          child: ButtonComponent.material(title: '查询', height: 75, elevation: 0.0, pressed: () {
                            FocusScope.of(context).requestFocus(FocusNode());
                            if(userSerach.text.isEmpty) {
                              DialogComponents.toast(context, content: '请输入用户名');
                              return;
                            }
                            setState(() {
                              list = [];
                              pageFlag = true;
                              page = 1;
                              startTime = '选择开始时间';
                              endTime = '选择结束时间';
                            });
                            _getData(username: userSerach.text);
                          },),
                        )
                      ],
                    ),
                  ),

                  //              时间选择框  搜索框
                  Container(
                    padding: EdgeInsets.only(left: Screen.width(20), right: Screen.width(20), bottom: Screen.width(10)),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              width: (Screen.weightWidth(context) - 20) / 2.2,
                              height: Screen.width(70),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  border: Border.all(width: Screen.width(1.5), color: Colors.grey),
                                  borderRadius: BorderRadius.all(Radius.circular(Screen.width(8)))
                              ),
                              child: Text('${startTime}', style: TextStyle(fontSize: Screen.width(24)),),
                            ),
                            onTap: () {
                              PickerTool.showDatePicker(context, clickCallback: (str, time){
                                print(str);print(time);
                                setState(() {
                                  startTime = formatDate(DateTime.parse(time), [yyyy, '-', mm, '-', dd, ' ', '00', ':', '00', ':', '00']);
                                });
                                if(endTime != '选择结束时间') {
                                  var start = DateTime.parse(formatDate(DateTime.parse(time), [yyyy, '-', mm, '-', dd, ' ', '00', ':', '00', ':', '00']));
                                  var end = DateTime.parse(endTime);
                                  if(start.millisecondsSinceEpoch > end.millisecondsSinceEpoch) {
                                    DialogComponents.toast(context, content: '开始时间不能大于结束时间');
                                    startTime = '选择开始时间';
                                    return;
                                  }
                                  setState(() {
                                    list = [];
                                    pageFlag = true;
                                    page = 1;
                                    userSerach.text = '';
                                  });
                                  _getData(endTime: endTime, startTime: startTime);
                                }
                              }
                              );
                            }
                        ),
                        Text(' 至 ', style: TextStyle(fontSize: Screen.width(28)),),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            width: (Screen.weightWidth(context) - 20) / 2.2,
                            height: Screen.width(70),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                border: Border.all(width: Screen.width(1.5), color: Colors.grey),
                                borderRadius: BorderRadius.all(Radius.circular(Screen.width(8)))
                            ),
                            child: Text('${endTime}', style: TextStyle(fontSize: Screen.width(24)),),
                          ),
                          onTap: () {
                            PickerTool.showDatePicker(context, clickCallback: (str, time){
                              print(str);print(time);
                              setState(() {
                                setState(() {
                                  endTime = formatDate(DateTime.parse(time), [yyyy, '-', mm, '-', dd, ' ', '23', ':', '59', ':', '59']);
                                });
                                if(startTime != '选择开始时间') {
                                  var start = DateTime.parse(startTime);
                                  var end = DateTime.parse(formatDate(DateTime.parse(time), [yyyy, '-', mm, '-', dd, ' ', '23', ':', '59', ':', '59']));
                                  if(start.millisecondsSinceEpoch > end.millisecondsSinceEpoch) {
                                    DialogComponents.toast(context, content: '开始时间不能大于结束时间');
                                    endTime = '选择结束时间';
                                    return;
                                  }
                                  setState(() {
                                    list = [];
                                    pageFlag = true;
                                    page = 1;
                                    userSerach.text = '';
                                  });
                                  _getData(endTime: endTime, startTime: startTime);
                                }
                              });
                            }
                            );
                          },
                        ),
                      ],
                    ),
                  ),

                  // 上下级层级
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(top: Screen.width(10), left: Screen.width(15), right: Screen.width(10), bottom: Screen.width(16)),
                    child: TabBar(
                      isScrollable: true,
                      indicatorColor: Colors.transparent,
                      labelPadding: EdgeInsets.all(0),
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorWeight: 1,
                      tabs: titleList.map((val) {
                        return GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            child: Text('${val["username"]} ${val['index'] != 0 && titleList.length == val['index'] + 1 ? "" : "> "}', style: TextStyle(fontSize: Screen.width(28), height: 1.8, color: Colors.black87)),
                            onTap: () {
                              setState(() {
                                list = [];
                                pageFlag = true;
                                page = 1;
                                titleList.removeRange(val['index'] + 1, titleList.length);
                              });
                              _getData(parentId: val['id']);
                            });
                      }).toList(),
                    ),
                  ),

                  // 数据标题
                  Container(
                    padding: EdgeInsets.only(top: Screen.width(20), bottom: Screen.width(16)),
                    color: Colors.white,
                    child: Row(
                      children: <Widget>[
                        Container(
                          child: Text('用户名', style: TextStyle(fontSize: Screen.width(28)),),
                          width: Screen.weightWidth(context) / 4,
                          alignment: Alignment.center,
                        ),
                        Container(
                          child: Text('奖金组', style: TextStyle(fontSize: Screen.width(28)),),
                          width: Screen.weightWidth(context) / 5,
                          alignment: Alignment.center,
                        ),
                        Container(
                          child: Text('余额', style: TextStyle(fontSize: Screen.width(28)),),
                          width: Screen.weightWidth(context) / 4,
                          alignment: Alignment.center,
                        ),
                        Container(
                          child: Text('人数', style: TextStyle(fontSize: Screen.width(28)),),
                          width: Screen.weightWidth(context) / 6.669,
                          alignment: Alignment.center,
                        ),
                        Container(
                          child: Text('更多', style: TextStyle(fontSize: Screen.width(28)),),
                          width: Screen.weightWidth(context) / 6.669,
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
                                    GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      child: Container(
                                        child: Text('${list[index]["username"]}', style: TextStyle(fontSize: Screen.width(26), decoration: list[index]["child_count"] < 1 ? TextDecoration.none :TextDecoration.underline),),
                                        width: Screen.weightWidth(context) / 4,
                                        alignment: Alignment.center,
                                      ),
                                      onTap: () {
                                        if(list[index]['child_count'] < 1) {
                                          DialogComponents.toast(context, content: '没有下级');
                                          return;
                                        }
                                        setState(() {
                                          pageFlag = true;
                                          page = 1;
                                          titleList.add({'username': list[index]['username'], 'id': list[index]['hash_id'], 'index': titleList.length});
                                        });
                                        _getData(parentId: list[index]['hash_id']);
                                        setState(() {
                                          list = [];
                                        });
                                      },
                                    ),
                                    Container(
                                      child: Text('${list[index]["prize_group"]}', style: TextStyle(fontSize: Screen.width(26)),),
                                      width: Screen.weightWidth(context) / 5,
                                      alignment: Alignment.center,
                                    ),
                                    Container(
                                      child: Text('${balanceList[list[index]["hash_id"]]}', style: TextStyle(fontSize: Screen.width(26)),),
                                      width: Screen.weightWidth(context) / 4,
                                      alignment: Alignment.center,
                                    ),
                                    Container(
                                      child: Text('${list[index]["direct_child_count"]}', style: TextStyle(fontSize: Screen.width(26)),),
                                      width: Screen.weightWidth(context) / 6.669,
                                      alignment: Alignment.center,
                                    ),
                                    GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      child: Container(
                                        child: Icon(list[index]['flag'] ? Icons.keyboard_arrow_down : Icons.keyboard_arrow_right, size: Screen.width(40),),
                                        width: Screen.weightWidth(context) / 6.669,
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
                                offstage: !list[index]['flag'],
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
                                          Text('玩家身份', style: TextStyle(fontSize: Screen.width(26)),),
                                          Text('${list[index]["type_desc"]}', style: TextStyle(fontSize: Screen.width(26)),)
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text('注册时间', style: TextStyle(fontSize: Screen.width(26)),),
                                          Text('${list[index]["register_time"]}', style: TextStyle(fontSize: Screen.width(26)),)
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text('注册IP', style: TextStyle(fontSize: Screen.width(26)),),
                                          Text('${list[index]["register_ip"]}', style: TextStyle(fontSize: Screen.width(26)),)
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text('上次登陆时间', style: TextStyle(fontSize: Screen.width(26)),),
                                          Text('${list[index]["last_login_time"]}', style: TextStyle(fontSize: Screen.width(26)),)
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text('上次登陆IP', style: TextStyle(fontSize: Screen.width(26)),),
                                          Text('${list[index]["last_login_ip"]}', style: TextStyle(fontSize: Screen.width(26)),)
                                        ],
                                      ),
                                      Wrap(
                                        children: <Widget>[
                                          Offstage(
                                            offstage: titleList.length > 1,
                                            child: Container(
                                              margin: EdgeInsets.only(right: Screen.width(15), top: Screen.width(15)),
                                              child: OutlineButton(
                                                  child: Text('奖金组', style: TextStyle(fontSize: Screen.width(26)),),
                                                  padding: EdgeInsets.all(0),
                                                  highlightedBorderColor: Colors.grey,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(5)
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      prizeGroup = double.parse(list[index]['prize_group'].toString());
                                                    });
                                                    var prize = prizeGroup;
                                                    DialogComponents.sheet(
                                                      context,
                                                      item: [
                                                        StatefulBuilder(
                                                          builder: (context, changeState) {
                                                            return Column(
                                                              children: <Widget>[
                                                                Slider(
                                                                    value: prizeGroup,
                                                                    max: double.parse(childLists["maxbonusgroup"].toString()),
                                                                    min: prize,
                                                                    activeColor: Colors.blue,
                                                                    onChanged: (double val) {
                                                                      changeState(() {
                                                                        prizeGroup = val;
                                                                      });
                                                                    }
                                                                ),
                                                                SizedBox(height: Screen.width(30),),
                                                                Text('当前 ${prizeGroup.ceil()} 奖金组 最大 ${childLists["maxbonusgroup"]}', style: TextStyle(fontSize: Screen.width(28))),
                                                                SizedBox(height: Screen.width(30),),
                                                                ButtonComponent.material(title: '确认', width: .5 , pressed: () async{
                                                                  var data = {
                                                                    'id': list[index]['hash_id'],
                                                                    'prize_group': prizeGroup.ceil()
                                                                  };
                                                                  // var response = await Api.prizeGroupSet(data);
                                                                  // if(response['success']) {
                                                                  //   setState(() {
                                                                  //     list[index]['prize_group'] = prizeGroup.ceil();
                                                                  //   });
                                                                  //   Navigator.pop(context);
                                                                  //   DialogComponents.toast(context, content: response['msg']);
                                                                  // }
                                                                },),
                                                              ],
                                                            );
                                                          },
                                                        )
                                                      ],);

                                                  }),
                                              width: Screen.width(130),
                                              height: Screen.width(65),
                                            ),
                                          ),

                                          Offstage(
                                            offstage: childLists['allowed_transfer'] == 0,
                                            child: Container(
                                              margin: EdgeInsets.only(right: Screen.width(15), top: Screen.width(15)),
                                              child: OutlineButton(
                                                  child: Text('转账', style: TextStyle(fontSize: Screen.width(26)),),
                                                  padding: EdgeInsets.all(0),
                                                  highlightedBorderColor: Colors.grey,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(5)
                                                  ),
                                                  onPressed: () {
                                                    if(!userDetails['fund_password']) {
                                                      DialogComponents.alertIos(
                                                          context,
                                                          content: [
                                                            Text('请先设置资金密码！！！', style: TextStyle(fontSize: Screen.width(28))),
                                                          ],
                                                          confirm: () {
                                                            Navigator.of(context).pushReplacementNamed('/setPassword');
                                                          }
                                                      );
                                                    } else if(bankList.length == 0) {
                                                      DialogComponents.toast(context, content: '请先绑定银行卡');
                                                      Timer(Duration(seconds: 2), () {
                                                        Navigator.pushReplacementNamed(context, '/bank');
                                                      });
                                                    } else {
                                                      Navigator.push(context, CupertinoPageRoute(builder: (context) => TransferPages(arguments: {
                                                        'list': list[index],
                                                        'userDetails': userDetails,
                                                        'bankList': bankList
                                                      },))).then((data) {
                                                        if(data != null) {
                                                          var balance = balanceList[list[index]["hash_id"]];
                                                          setState(() {
                                                            if(balance.substring(0, balance.indexOf('.')) == -1) {
                                                              balanceList[list[index]["hash_id"]] = (int.parse(balance) + int.parse(data['amount'])).toString();
                                                            } else {
                                                              balanceList[list[index]["hash_id"]] = (int.parse(balance.substring(0, balance.indexOf('.'))) + int.parse(data['amount'])).toString() + balance.substring(balance.indexOf('.'), balance.length);
                                                            }
                                                          });
                                                        }
                                                      });
                                                    }
                                                  }),
                                              width: Screen.width(130),
                                              height: Screen.width(65),
                                            ),
                                          ),

                                          Offstage(
                                            offstage: childLists['can_set_bonus'] == 0 || list[index]['type'] != 2,
                                            child: Container(
                                              margin: EdgeInsets.only(right: Screen.width(15), top: Screen.width(15)),
                                              child: OutlineButton(
                                                  child: Text('分红', style: TextStyle(fontSize: Screen.width(26)),),
                                                  padding: EdgeInsets.all(0),
                                                  highlightedBorderColor: Colors.grey,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(5)
                                                  ),
                                                  onPressed: () {
                                                    Navigator.push(context, CupertinoPageRoute(builder: (context) => ShareMoneyPages(arguments: {
                                                      'hash_id': list[index]['hash_id'],
                                                      'bonus_percentage': list[index]['bonus_percentage']
                                                    },)));
                                                  }),
                                              width: Screen.width(130),
                                              height: Screen.width(65),
                                            ),
                                          ),

                                          Offstage(
                                            offstage: childLists['can_set_salary'] == 0 || list[index]['type'] != 2,
                                            child: Container(
                                              margin: EdgeInsets.only(right: Screen.width(15), top: Screen.width(15)),
                                              child: OutlineButton(
                                                  child: Text('日工资', style: TextStyle(fontSize: Screen.width(26)),),
                                                  padding: EdgeInsets.all(0),
                                                  highlightedBorderColor: Colors.grey,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(5)
                                                  ),
                                                  onPressed: () {
                                                    Navigator.push(context, CupertinoPageRoute(builder: (context) => DailyWagesPages(arguments: {
                                                      'hash_id': list[index]['hash_id'],
                                                      'salary_percentage': list[index]['salary_percentage']
                                                    },)));
                                                  }),
                                              width: Screen.width(130),
                                              height: Screen.width(65),
                                            ),
                                          ),
                                        ],
                                      )
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
                  ),
                ],
              ),
            ),
          )

      )
    );
  }

  // 获取数据
  _getData({parentId, username, startTime, endTime}) async{
    if(pageFlag == false) return;
    var childListData = {
      'page_index': page,
      'page_size': 20,
      'parent_id': parentId ?? '',
      'username': username ?? '',
      'start_time': startTime ?? '',
      'end_time': endTime ?? '',
    };

    // 获取团队列表
    // var childList = await Api.childList(childListData);
    // if(childList['success']) {
    //   setState(() {
    //     childLists = childList['data'];
    //   });
    //   var childListResponse = childList['data']['data'];
    //
    //   // 控制更多菜单
    //   for(var i = 0; i < childListResponse.length; i++) {
    //     childListResponse[i]['flag'] = false;
    //   }
    //   // 获取团队余额传参
    //   var childTeamBalanceDate = {
    //     'id': []
    //   };
    //   for(var i = 0; i < childListResponse.length; i++) {
    //     childTeamBalanceDate['id'].add(childListResponse[i]['hash_id']);
    //   }
    //   // 获取团队余额
    //   var childTeamBalance = await Api.childTeamBalance(childTeamBalanceDate);
    //
    //   if(childTeamBalance['success']) {
    //     if(childTeamBalance['data'] is Map) {
    //       setState(() {
    //         balanceList.addAll(childTeamBalance['data']);
    //       });
    //     }
    //   }
    //   setState(() {
    //     list.addAll(childListResponse);
    //     page++;
    //     if(childListResponse.length < 20) {
    //       pageFlag = false;
    //     }
    //   });
    //
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