import 'dart:async';
import 'dart:convert';

import 'package:dio/adapter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

import '../../../../../services/utils.dart';
import '../../../../component/component.dart';
import '../../../../component/dialog.dart';
import '../../../../component/picker.dart';


class TeamRecordPages extends StatefulWidget{
  createState() => _TeamRecordPages();
}

class _TeamRecordPages extends State{
  var page = 1;
  var pageSize = 20;
  var pageFlag = true;
  var dropDownFlag = false;
  var list = [];
  var _scrollController = ScrollController();

  // 状态选择
  var whichState = 0;
  // 开始时间
  var startTime = '2020-01-01';
  // 结束时间
  var endTime = '2020-01-01';

  // 搜索
  var serach = TextEditingController();

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
    // var dio = Dio();
    // var response = await dio.get('http://www.phonegap100.com/appapi.php?a=getPortalList&catid=20&page=${page}');
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
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {FocusScope.of(context).requestFocus(FocusNode());},
        child: Scaffold(
            appBar: HeadersComponent.Appbars(
              Text('团队报表', style: TextStyle(fontSize: Screen.width(32)),),
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
                      list = []; page = 1; startTime = ''; endTime = '';  whichState = 0;
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
                                Text('全部状态', style: TextStyle(fontSize: Screen.width(28), color: Colors.black),),
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
                                            color: whichState == 0 ? ColorGather.colorMain() : Colors.white, textColor: whichState == 0 ? Colors.white : Colors.black,
                                            pressed: () {
                                              changeState(() {whichState = 0;print(whichState);});
                                              setState(() {whichState = 0;print(whichState);});
                                            },
                                          ),
                                          SizedBox(width: Screen.width(10), height: 0,),
                                          ButtonComponent.material(
                                              width: .3, title: '全部类型', elevation: 0.0,
                                              color: whichState == 1 ? ColorGather.colorMain() : Colors.white, textColor: whichState == 1 ? Colors.white : Colors.black,
                                              pressed: () {
                                                changeState(() {whichState = 1;print(whichState);});
                                                setState(() {whichState = 1;print(whichState);});
                                              }
                                          )
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
                    Divider(height: 0),
                    Container(
                      color: Colors.white,
                      height: Screen.height(115),
                      child: Row(
                        children: <Widget>[
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            child: Container(
                              width: Screen.width(110),
                              child: Icon(Icons.search, size: Screen.width(60),),
                            ),
                          ),
                          Expanded(
                            child: InputComponent.text(
                                labelText: '请输入账号', controller: serach,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(18)
                                ]),
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
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: Screen.width(2)),
                                    child: ListTitleComponent(
                                        height: 210,
                                        title: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            RichText(
                                              text: TextSpan(
                                                  style: TextStyle(fontSize: Screen.width(32), color: Colors.grey),
                                                  children: [
                                                    TextSpan(text: '账    号: ', ),
                                                    TextSpan(text: 'test960', style: TextStyle(color: Colors.black))
                                                  ]
                                              ),
                                            ),
                                            SizedBox(width: 0, height: Screen.width(7),),
                                            RichText(
                                              text: TextSpan(
                                                  style: TextStyle(fontSize: Screen.width(32), color: Colors.grey),
                                                  children: [
                                                    TextSpan(text: '总购买: ', ),
                                                    TextSpan(text: '12035', style: TextStyle(color: Colors.red))
                                                  ]
                                              ),
                                            ),
                                            SizedBox(width: 0, height: Screen.width(7),),
                                            RichText(
                                              text: TextSpan(
                                                  style: TextStyle(fontSize: Screen.width(32), color: Colors.grey),
                                                  children: [
                                                    TextSpan(text: '总盈亏: ', ),
                                                    TextSpan(text: '100000', style: TextStyle(color: Colors.green))
                                                  ]
                                              ),
                                            ),
                                            SizedBox(width: 0, height: Screen.width(7),),
                                            RichText(
                                              text: TextSpan(
                                                  style: TextStyle(fontSize: Screen.width(32), color: Colors.grey),
                                                  children: [
                                                    TextSpan(text: '状   态: ', ),
                                                    TextSpan(text: '在线', style: TextStyle(color: Colors.green))
                                                  ]
                                              ),
                                            ),
                                          ],
                                        )
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.pushNamed(context, '/teamReportDetails', arguments: {
                                      'title': '13213'
                                    });
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
                    )
                  ],
                )
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