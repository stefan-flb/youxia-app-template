import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../../services/utils.dart';

class UpDown extends StatefulWidget{
  UpDown({Key key});
  _UpDown createState() => _UpDown();
}

class _UpDown extends State<UpDown> {
  var page = 1;
  var pageSize = 20;
  var pageFlag = true;
  var dropDownFlag = false;
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
    if(pageFlag == false) return;
    var response = await Dio().get('http://www.phonegap100.com/appapi.php?a=getPortalList&catid=20&page=${page}');
    var res = json.decode(response.data)['result'];
    setState(() {
      list.addAll(res);
      page++;
    });
    if(res.length < 20) {
      setState(() {
        pageFlag = false;
      });
    }
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return list.length > 0 ? RefreshIndicator(
      onRefresh: () async{
        await Future.delayed(Duration(milliseconds: 2000), () {
          setState(() {
            list = [];
            page = 1;
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
              Text('12312'), // 只有这一部分是自己的内容
              Offstage(
                offstage: index != list.length - 1,
                child: getMoreTips(flag: pageFlag),
              )
            ],
          );
        },
      ),
    ) : getMoreTips(flag: pageFlag);
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