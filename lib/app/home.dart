import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../api/api.dart';
import '../services/utils.dart';
import 'home/index.dart';
import 'home/wallet.dart';
import 'home/service.dart';
import 'home/my.dart';


class HomePages extends StatefulWidget{
  var currentIndex;

  HomePages({Key key, this.currentIndex = 0}) : super(key: key);
  _HomePages createState() => _HomePages(this.currentIndex);
}

class _HomePages extends State {
  var currentIndex;
  var _tabList = [IndexPages(), WalletPages(), ServicePages(), MyPages()];
  var states;
  var cancelLotteryList;
  @override
  _HomePages(index) {
    currentIndex = index;
  }
  initState() {
    super.initState();
    _init();
  }
  dispose(){
    super.dispose();
    cancelLotteryList.cancle(); // 取消监听
  }
//  PageView(
//        controller: PageController(
//          initialPage: 0,
//          viewportFraction: 1,
//          keepPage: true,
//        ),
//        children: _tabList,
//        onPageChanged: (val) {
//          setState(() {
//            currentIndex = val;
//          });
//          print(val);
//        },
//      ),
  Widget build(BuildContext context) {
    // TODO: implement build
    Screen.init(context, height: 1445);
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {FocusScope.of(context).requestFocus(FocusNode());},
      child: Scaffold(
        body: _tabList[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.red,
            unselectedItemColor: Color.fromRGBO(100,100,100, 1),
            selectedFontSize: Screen.width(28),
            unselectedFontSize: Screen.width(26),
            currentIndex: currentIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (val) {
              setState(() {
                currentIndex = val;
              });
            },
            items: [
              BottomNavigationBarItem(
                  title: Text('首页',),
                  icon: Image.asset(
                      'images/home/bottom_home.png', width: Screen.width(55), color: currentIndex == 0 ? Colors.red : Color.fromRGBO(100,100,100, 1))
              ),
              BottomNavigationBarItem(
                  title: Text('钱包'),
                  icon: Image.asset(
                      'images/home/bottom_wallte.png', width: Screen.width(50), color: currentIndex == 1 ? Colors.red : Color.fromRGBO(100,100,100, 1))
              ),
              BottomNavigationBarItem(
                  title: Text('客服'),
                  icon: Image.asset(
                      'images/home/bottom_service.png', width: Screen.width(55), color: currentIndex == 2 ? Colors.red : Color.fromRGBO(100,100,100, 1))
              ),
              BottomNavigationBarItem(
                  title: Text('我的'),
                  icon: Image.asset(
                      'images/home/bottom_my.png', width: Screen.width(50), color: currentIndex == 3 ? Colors.red : Color.fromRGBO(100,100,100, 1))
              )
            ]
        ),
      ),
    );
  }

  _init () {
//    Api.lotteryList().then((response) {
//      if (response['success']) {
//        Storage.setString('lotteryList', json.encode(response['data']['data']));
//      }
//    });
//    Api.lotteryInfo().then((response) {
//      if (response['success']) {
//        Storage.setString('lotteryInfo', json.encode(response['data']));
//      }
//    });
  }
}