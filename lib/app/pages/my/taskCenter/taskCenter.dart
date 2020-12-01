import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xw/api/api.dart';

import '../../../../services/utils.dart';
import '../../../component/component.dart';
import '../../../component/dialog.dart';
import '../../../pages/my/taskCenter/prizeTask.dart';


class TaskCenterPages extends StatefulWidget{
  createState() => _TaskCenterPages();
}

class _TaskCenterPages extends State with SingleTickerProviderStateMixin {
  var tabController;
  // 左侧图标背景色
  var leadingBgColor = [
    Color.fromRGBO(202,109,254, 1),
    Color.fromRGBO(595,182,252, 1),
    Color.fromRGBO(0,202,57, 1),
    Color.fromRGBO(110,142,253, 1),
    Color.fromRGBO(255,178,105, 1),
    Color.fromRGBO(255,106,146, 1),
    Color.fromRGBO(246,225,0, 1),
    Color.fromRGBO(62,56,0, 1),
    Color.fromRGBO(120,120,117, 1),
    Color.fromRGBO(255,0,0, 1),
    Color.fromRGBO(255,92,99, 1),
    Color.fromRGBO(207,0,0, 1),
  ];
  // 任务是否完后
  var isFinish;
  @override
  initState() {
    super.initState();
    _init();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() {
      print(tabController.index);
    });
  }
  dispose() {
    super.dispose();
    tabController.dispose();
  }
  Widget build(BuildContext context) {
    Screen.init(context);
    // TODO: implement build
    return Scaffold(
        appBar: HeadersComponent.Appbars(Text('任务中心', style: TextStyle(fontSize: Screen.width(32)),)),
        body: Container(
          width: double.infinity,
          color: ColorGather.colorBg(),
          child: Column(
            children: <Widget>[
              Container(
                color: Colors.white,
                height: Screen.width(80),
                child: TabBar(
                  labelPadding: EdgeInsets.all(0),
                  controller: tabController,
                  indicatorColor: ColorGather.colorMain(),
                  tabs: <Widget>[
                    Tab(child: Text('有奖任务', style: TextStyle(fontSize: Screen.width(28,), color: Colors.black))),
                    Tab(child: Text('今日任务', style: TextStyle(fontSize: Screen.width(28,), color: Colors.black))),
                    Tab(child: Text('已完成', style: TextStyle(fontSize: Screen.width(28,), color: Colors.black))),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: <Widget>[
                    PrizeTaskPages(sign: 'przie'),
                    PrizeTaskPages(sign: 'today'),
                    PrizeTaskPages(sign: 'finish'),
                  ],
                ),
              )
            ],
          )
        )
    );
  }

  _init () async{
    // var response = await Api.recordJob();
    // print(response);
    // if(response['success']) {
    //
    // }
  }
}