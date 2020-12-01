import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../services/utils.dart';
import '../../../component/component.dart';
import '../../../component/dialog.dart';
import '../../../pages/my/activity/activityContent.dart';


class ActivityPages extends StatefulWidget{
  createState() => _ActivityPages();
}

class _ActivityPages extends State with SingleTickerProviderStateMixin {
  var tabController;
  // 任务是否完后
  var isFinish;
  @override
  initState() {
    super.initState();
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
        appBar: HeadersComponent.Appbars(Text('活动中心', style: TextStyle(fontSize: Screen.width(32)),)),
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
                      Tab(child: Text('最新活动', style: TextStyle(fontSize: Screen.width(28,), color: Colors.black))),
                      Tab(child: Text('所有活动', style: TextStyle(fontSize: Screen.width(28,), color: Colors.black))),
                      Tab(child: Text('历史优惠', style: TextStyle(fontSize: Screen.width(28,), color: Colors.black))),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: <Widget>[
                      ActivityContentPages(sign: 'newest'),
                      ActivityContentPages(sign: 'all'),
                      ActivityContentPages(sign: 'history'),
                    ],
                  ),
                )
              ],
            )
        )
    );
  }
}