import 'package:flutter/material.dart';

import '../api/api.dart';
import '../services/utils.dart';

var getBaseConfig = {
};
var globeBuildContext;
var pageSizeState = 20;

class Providers with ChangeNotifier{
  Providers (){}

//  改变states值要通知其他地方刷新
  notifyListener() {
    notifyListeners();
  }
  // 我的钱包是否显示 余额
  var showMoney = false;
  showMoneyFn () {
    // 获取是否显示余额配置
    Storage.getBool('walletShowMoney').then((response) {
      if(response != null) {
        showMoney = response;
        notifyListeners();
      }
    });
  }

  // 当前游戏信息
  var currentGame = {
    'series': '',
    'multiple': '1',
    'methods': '',
    'methodsName': '',
    'childMethodsName': '',
    'grandSonMethodsName': '',
  };
  // 游戏列表
  var lotteryList;

  // 游戏配置
  var lotteryInfo;
}