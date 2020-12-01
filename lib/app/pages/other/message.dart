import 'dart:async';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:dio/dio.dart';

import '../../../services/utils.dart';
import '../../../services/state.dart';
import '../../component/component.dart';
import '../../component/dialog.dart';
import '../../../api/api.dart';

class MessagePages extends StatefulWidget{

  createState() => _MessagePages();
}

class _MessagePages extends State with SingleTickerProviderStateMixin {

  var page = 1;
  var pageFlag = true;
  var _scrollController = ScrollController();

  var tabController;
  // 公告
  var noticeList = [];

  // 站内信
  var messageList = [];
  @override
  initState() {
    super.initState();

    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    _getData();
    _scrollController.addListener(() {     // 上拉加载
      var _scrollTop = _scrollController.position.pixels; //获取滚动条下拉的距离
      var _scrollHeight = _scrollController.position.maxScrollExtent; //获取整个页面的高度
      if(_scrollTop >= _scrollHeight) {
        _getData();
      }
    });
    tabController.addListener(() {
      setState(() {
        page = 1;
        pageFlag = true;
        noticeList = [];
        messageList = [];
      });
      _scrollController.jumpTo(0);
    });
  }
  deactivate() {
    super.deactivate();
    var bool = ModalRoute.of(context).isCurrent;
    if (bool) {_getData();}
  }
  dispose() {
    super.dispose();
    tabController.dispose();
    _scrollController.dispose(); //手动停止滑动监听
  }
  // 获取数据
  _getData({type}) async{
    // if(pageFlag == false) return;
    // var pages = {
    //   'index': page,
    //   'page_size': 20
    // };
    // if(type == 'message') {
    //   var response = await Api.getMessageList(pages);
    //   if(response['success']) {
    //     setState(() {
    //       messageList.addAll(response['data']['data']);
    //       page++;
    //     });
    //     if(response['data']['data'].length < 20) {
    //       setState(() {
    //         pageFlag = false;
    //       });
    //     }
    //   }
    // } else {
    //   var response = await Api.noticeList(pages);
    //   if(response['success']) {
    //     setState(() {
    //       noticeList.addAll(response['data']['data']);
    //       page++;
    //     });
    //     if(response['data']['data'].length < 20) {
    //       setState(() {
    //         pageFlag = false;
    //       });
    //     }
    //   }
    // }
  }
  Widget build(BuildContext context) {
    Screen.init(context);
    // TODO: implement build
    return Scaffold(
        appBar: HeadersComponent.Appbars(Text('消息中心', style: TextStyle(fontSize: Screen.width(32)))),
        body: Container(
            width: double.infinity,
            color: ColorGather.colorBg(),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: Screen.width(20)),
                  color: Colors.white,
                  height: Screen.width(80),
                  child: TabBar(
                    labelPadding: EdgeInsets.all(0),
                    controller: tabController,
                    indicatorColor: ColorGather.colorMain(),
                    onTap: (index) {
                      index == 0 ? _getData() : _getData(type: 'message');
                    },
                    tabs: <Widget>[
                      Tab(child: Text('公告', style: TextStyle(fontSize: Screen.width(28,), color: Colors.black))),
                      Tab(child: Text('私信', style: TextStyle(fontSize: Screen.width(28,), color: Colors.black)))
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    controller: tabController,
                    children: <Widget>[
                      noticeList.length > 0 ? RefreshIndicator(
                        onRefresh: () async{
                          await Future.delayed(Duration(milliseconds: 2000), () {
                            setState(() {
                              noticeList = [];
                              page = 1;
                            });
                            _getData();
                          });
                        },
                        child: ListView.builder(
                            controller: _scrollController,
                            itemCount: noticeList.length,
                            itemBuilder: (context, index) {
                              return  Column(
                                children: <Widget>[
                                  GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border(bottom: BorderSide(width: Screen.width(1), color: ColorGather.colorBg()))
                                      ),
                                      child: ListTitleComponent(
                                          height: 135,
                                          //                              leading: Container(
                                          //                                  width: Screen.width(15),
                                          //                                  height: Screen.width(15),
                                          //                                  decoration: BoxDecoration(
                                          //                                      borderRadius: BorderRadius.circular(7),
                                          //                                      color: Colors.red
                                          //                                  )),
                                          //                              leadingRight: 10,
                                          title: Text('${noticeList[index]["title"]}', style: TextStyle(fontSize: Screen.width(28)), overflow: TextOverflow.ellipsis, maxLines: 1,),
                                          subTitle: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text('${noticeList[index]["type_desc"]}', style: TextStyle(fontSize: Screen.width(26), color: Colors.grey), overflow: TextOverflow.ellipsis, maxLines: 1,),
                                              Text('${noticeList[index]["start_time"]}', style: TextStyle(fontSize: Screen.width(22), color: Colors.grey))
                                            ],
                                          )
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.pushNamed(context, '/details', arguments: {
                                        'title': '公告详情',
                                        'contentTitle': Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only( top: Screen.width(15)),
                                          child: Text('${noticeList[index]["title"]}', style: TextStyle(fontSize: Screen.width(30)),),
                                        ),
                                        'time': Container(
                                          alignment: Alignment.bottomRight,
                                          margin: EdgeInsets.only(top: Screen.width(30), right: Screen.width(30)),
                                          child: Text('${noticeList[index]["start_time"]}', style: TextStyle(fontSize: Screen.width(28)),),
                                        ),
                                        'content': '${noticeList[index]["content"]}'
                                      });
                                    },
                                  ),
                                  Offstage(offstage: index != noticeList.length - 1, child: getMoreTips(flag: pageFlag),)
                                ],
                              );
                            }
                        ),
                      ) : getMoreTips(flag: pageFlag),


                      messageList.length > 0 ? RefreshIndicator(
                        onRefresh: () async{
                          await Future.delayed(Duration(milliseconds: 2000), () {
                            setState(() {
                              messageList = [];
                              page = 1;
                            });
                            _getData(type: 'message');
                          });
                        },
                        child: ListView.builder(
                            controller: _scrollController,
                            itemCount: messageList.length,
                            itemBuilder: (context,index) {
                              return Column(
                                children: <Widget>[
                                  Slidable(
                                    actionPane: SlidableScrollActionPane(),//滑出选项的面板 动画
                                    actionExtentRatio: 0.25,
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            border: Border(bottom: BorderSide(width: Screen.width(1), color: ColorGather.colorBg()))
                                        ),
                                        child: ListTitleComponent(
                                            height: 135,
                                            leading: Container(
                                                width: Screen.width(15),
                                                height: Screen.width(15),
                                                decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(7),
                                                    color: messageList[index]['read'] == 0 ? Colors.red : Colors.grey
                                                )),
                                            leadingRight: 10,
                                            title: Text('${messageList[index]["title"]}', style: TextStyle(fontSize: Screen.width(28)), overflow: TextOverflow.ellipsis, maxLines: 1,),
                                            subTitle: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text('${messageList[index]["type_desc"]}这是一封来自星星的信', style: TextStyle(fontSize: Screen.width(26), color: Colors.grey), overflow: TextOverflow.ellipsis, maxLines: 1,),
                                                Text('${messageList[index]["created_at"]}', style: TextStyle(fontSize: Screen.width(22), color: Colors.grey))
                                              ],
                                            )
                                        ),
                                      ),
                                      onTap: () {
                                        setState(() {
                                          messageList[index]['read'] = 1;
                                        });
                                        var data = {
                                          'id': messageList[index]['id']
                                        };
                                        // Api.readMessage(data);
                                        Navigator.pushNamed(context, '/details', arguments: {
                                          'title': '站内信详情',
                                          'contentTitle': Container(
                                            alignment: Alignment.center,
                                            margin: EdgeInsets.only( top: Screen.width(15)),
                                            child: Text('${messageList[index]["title"]}', style: TextStyle(fontSize: Screen.width(30)),),
                                          ),
                                          'time': Container(
                                            alignment: Alignment.bottomRight,
                                            margin: EdgeInsets.only(top: Screen.width(30), right: Screen.width(30)),
                                            child: Text('${messageList[index]["created_at"]}', style: TextStyle(fontSize: Screen.width(28)),),
                                          ),
                                          'content': '${messageList[index]["content"]}'
                                        });
                                      },
                                    ),
                                    secondaryActions: <Widget>[//右侧按钮列表
                                      IconSlideAction(
                                        caption: '删除',
                                        color: ColorGather.colorMain(),
                                        icon: Icons.delete,
                                        onTap: () async{
                                          var data = {
                                            'id': messageList[index]['id']
                                          };
                                          // var response = await Api.deleteMessage(data);
                                          // if(response['success']) {
                                          //   setState(() {
                                          //     messageList.removeAt(index);
                                          //   });
                                          // }
                                        },
                                      ),
                                    ],
                                  ),
                                  Offstage(offstage: index != messageList.length - 1, child: getMoreTips(flag: pageFlag),)
                                ],
                              );
                            }
                        ),
                      ) : getMoreTips(flag: pageFlag),
                    ],
                  ),
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