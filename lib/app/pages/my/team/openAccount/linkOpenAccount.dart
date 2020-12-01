import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

import '../../../../../services/utils.dart';
import '../../../../../api/api.dart';
import '../../../../component/component.dart';
import '../../../../component/dialog.dart';


class LinkOpenPages extends StatefulWidget{
  createState() => _LinkOpenPages();
}

class _LinkOpenPages extends State{
  var page = 1;
  var pageFlag = true;
  var list = [];
  var _scrollController = ScrollController();

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
    // var response = await Api.inviteLinkList();
    // if(response['success']) {
    //   var data = response['data']['links']['data'];
    //   print(data.length);
    //   for(var i = 0; i < data.length; i++) {
    //     data[i]['flag'] = false;
    //   }
    //   setState(() {
    //     list.addAll(data);
    //     page++;
    //   });
    //   if(data.length < 20) {
    //     setState(() {
    //       pageFlag = false;
    //     });
    //   }
    // }
  }
  Widget build(BuildContext context) {
    Screen.init(context);
    // TODO: implement build
    return Scaffold(
        appBar: HeadersComponent.Appbars(Text('链接开户列表', style: TextStyle(fontSize: Screen.width(32)),),
          leading: GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Icon(Icons.chevron_right, size: Screen.width(40),),
            onTap: () {
              Navigator.pop(context, {'list': list});
            },
          )
        ),
        body: Container(
            alignment: Alignment.centerLeft,
            width: double.infinity,
            color: ColorGather.colorBg(),
            child: Column(
              children: <Widget>[
                // 数据标题
                Container(
                  padding: EdgeInsets.only(top: Screen.width(20), bottom: Screen.width(16)),
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Text('渠道', style: TextStyle(fontSize: Screen.width(28)),),
                        width: Screen.weightWidth(context) / 5,
                        alignment: Alignment.center,
                      ),
                      Container(
                        child: Text('类型', style: TextStyle(fontSize: Screen.width(28)),),
                        width: Screen.weightWidth(context) / 6.7,
                        alignment: Alignment.center,
                      ),
                      Container(
                        child: Text('注册数', style: TextStyle(fontSize: Screen.width(28)),),
                        width: Screen.weightWidth(context) / 6.7,
                        alignment: Alignment.center,
                      ),
                      Container(
                        child: Text('链接', style: TextStyle(fontSize: Screen.width(28)),),
                        width: Screen.weightWidth(context) / 6.7,
                        alignment: Alignment.center,
                      ),
                      Container(
                        child: Text('操作', style: TextStyle(fontSize: Screen.width(28)),),
                        width: Screen.weightWidth(context) / 2.856,
                        alignment: Alignment.center,
                      ),
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
                          list = [];page = 1;pageFlag = true;
                        });
                        _getData();
                      });
                    },
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: <Widget>[
                            Container(
                              height: Screen.width(75),
                              color: Colors.white,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Container(
                                    child: Text('${list[index]["channel"]}', style: TextStyle(fontSize: Screen.width(28))),
                                    width: Screen.weightWidth(context) / 5,
                                    alignment: Alignment.center,
                                  ),
                                  Container(
                                    child: Text('${list[index]["is_agent"] == 0 ? "会员" : "代理"}', style: TextStyle(fontSize: Screen.width(28))),
                                    width: Screen.weightWidth(context) / 6.7,
                                    alignment: Alignment.center,
                                  ),
                                  Container(
                                    child: Text('${list[index]["total_register"]}', style: TextStyle(fontSize: Screen.width(28))),
                                    width: Screen.weightWidth(context) / 6.7,
                                    alignment: Alignment.center,
                                  ),
                                  GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    child: Container(
                                      child: Text('复制', style: TextStyle(fontSize: Screen.width(28), color: ColorGather.colorMain(), decoration: TextDecoration.underline)),
                                      width: Screen.weightWidth(context) / 6.7,
                                      alignment: Alignment.center,
                                    ),
                                    onTap: () {
                                      var data = ClipboardData(text: 'http://m.play322.com/register/${list[index]["url"]}');
                                      Clipboard.setData(data);
                                      DialogComponents.toast(context, content: '复制成功');
                                    },
                                  ),
                                  Container(
                                    width: Screen.weightWidth(context) / 2.856,
                                    child: Row(
                                      children: <Widget>[
                                        GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          child: Text('详情', style: TextStyle(fontSize: Screen.width(28), color: ColorGather.colorMain(), decoration: TextDecoration.underline)),
                                          onTap: () {
                                            setState(() {
                                              list[index]['flag'] = !list[index]['flag'];
                                            });
                                          },
                                        ),
                                        GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          child: Text('删除', style: TextStyle(fontSize: Screen.width(28), color: ColorGather.colorMain(), decoration: TextDecoration.underline)),
                                          onTap: () async {
                                            DialogComponents.alertIos(
                                                context,
                                                content: [
                                                  Text('确认删除吗', style: TextStyle(fontSize: Screen.width(28))),
                                                ],
                                                confirm: () async{
                                                  var data = {
                                                    'id': list[index]['id']
                                                  };
                                                  // var response = await Api.delInviteLink(data);
                                                  // print(response);
                                                  // if(response['success']) {
                                                  //   DialogComponents.toast(context, content: response['msg']);
                                                  //   setState(() {
                                                  //     list.removeAt(index);
                                                  //   });
                                                  // }
                                                  Navigator.pop(context, 'confirm');
                                                });
                                          },
                                        ),
                                      ],
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Offstage(
                              offstage: list[index]['flag'] == false,
                              child: Container(
                                padding: EdgeInsets.only(top: Screen.width(10), bottom: Screen.width(10)),
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Text('有效期', style: TextStyle(fontSize: Screen.width(26))),
                                        Text('${list[index]["expired_at"]}', style: TextStyle(fontSize: Screen.width(26))),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Text('奖金组', style: TextStyle(fontSize: Screen.width(26))),
                                        Text('${list[index]["prize_group"]}', style: TextStyle(fontSize: Screen.width(26))),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Text('生成时间', style: TextStyle(fontSize: Screen.width(26))),
                                        Text('${list[index]["created_at"]}', style: TextStyle(fontSize: Screen.width(26))),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Text('链接', style: TextStyle(fontSize: Screen.width(26))),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Text('http://m.play322.com/register/${list[index]["url"]}', style: TextStyle(fontSize: Screen.width(26))),
                                      ],
                                    ),
                                  ],
                                ),
                                decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(width: Screen.width(1), color: Colors.grey),
                                      bottom: BorderSide(width: Screen.width(1), color: Colors.grey),
                                    )
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
                    )
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