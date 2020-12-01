import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xw/app/pages/my/team/teamManage/teamManage.dart';
import '../app/home.dart';
import '../app/pages/myWallet/recharge/recharge.dart';
import '../app/pages/myWallet/bank/bank.dart';
import '../app/pages/myWallet/bank/addBankValidation.dart';
import '../app/pages/myWallet/password/setPassword.dart';
import '../app/pages/myWallet/bank/addBank.dart';
import '../app/pages/myWallet/withdrawal/withdrawal.dart';
import '../app/pages/myWallet/yubao/yubao.dart';
import '../app/pages/myWallet/transformation/transformation.dart';
import '../app/pages/myWallet/transactionRecord/transactionRecord.dart';
import '../app/pages/my/orderRecord/orderType.dart';
import '../app/pages/my/orderRecord/orderRecord.dart';
import '../app/pages/my/orderRecord/traces/tracesRecord.dart';
import '../app/pages/my/taskCenter/taskCenter.dart';
import '../app/pages/my/activity/activity.dart';
import '../app/pages/my/team/team.dart';
import '../app/pages/my/team/teamReport/teamReport.dart';
import '../app/pages/my/team/teamReport/details.dart';
import '../app/pages/my/team/openAccount/openAcconunt.dart';
import '../app/pages/my/team/openAccount/linkOpenAccount.dart';
import '../app/pages/my/team/statistical/statistical.dart';
import '../app/pages/my/team/dailyWages/dailyWage.dart';
import '../app/pages/my/team/shareMoney/shareMoney.dart';
import '../app/pages/my/team/teamProfit/teamProfit.dart';
import '../app/pages/my/memberLevel/memberLevel.dart';
import '../app/pages/my/settings/settings.dart';
import '../app/pages/my/userInfo/avatar.dart';
import '../app/pages/service/contact.dart';
import '../app/pages/service/proposal.dart';
import '../app/pages/other/message.dart';
import '../app/pages/other/details.dart';
import '../app/pages/other/login.dart';
import '../app/pages/other/regsiter.dart';
import '../app/game/game.dart';

// 配置路由
// '/my':(context) => MyPages(),
// '/search':(context, { arguments }) => SearchPage(arguments: arguments),
// class LoginPages extends StatefulWidget{
//  var arguments;
//  LoginPages({this.arguments});
//  createState() => _LoginPages(this.arguments);
//}
//class _LoginPages extends State {
//  var arguments;
//
//  _LoginPages(this.arguments);
//}
var routes = {
  '/index':(context) => HomePages(),
  '/recharge':(context) => RechargePages(),
  '/setPassword':(context) => SetPasswordPages(),
  '/bank':(context) => BankPages(),
  '/addBank':(context, { arguments }) => AddBankPages(arguments: arguments),
  '/addBankValidation':(context, { arguments }) => AddBankValidation(arguments: arguments),
  '/withdrawal':(context, { arguments }) => WithdrawalPages(arguments: arguments),
  '/yubao':(context) => YubaoPages(),
  '/transformation':(context, { arguments }) => TransformationPages(arguments: arguments),
  '/transactionRecord':(context) => TransactionRecord(),
  '/orderType':(context) => OrderTypePages(),
  '/orderRecord':(context) => OrderRecordPages(),
  '/tracesRecord':(context) => TracesRecordPages(),
  '/taskCenter':(context) => TaskCenterPages(),
  '/activity':(context) => ActivityPages(),
  '/team':(context) => TeamPages(),
  '/teamReport':(context) => TeamRecordPages(),
  '/teamReportDetails':(context, { arguments }) => TeamDetailsPages(arguments: arguments),
  '/statistical':(context) => Statistical(),
  '/teamManage':(context) => TeamManage(),
  '/dailyWages':(context) => DailyWagesPages(),
  '/shareMoney':(context) => ShareMoneyPages(),
  '/teamProfit':(context) => TeamProfitPages(),
  '/openAccount':(context) => OpenAccountPages(),
  '/linkOpenAccount':(context) => LinkOpenPages(),
  '/memberLevel':(context) => MemberLevelPages(),
  '/contact':(context) => ContactPages(),
  '/proposal':(context) => ProposalPages(),
  '/message':(context) => MessagePages(),
  '/setting':(context) => SettingPages(),
  '/avatar':(context, { arguments }) => AvatarPages(arguments: arguments),
  '/details':(context, { arguments }) => DetailsPages(arguments: arguments),
  '/games':(context, { arguments }) => GamePages(),
  '/':(context, { arguments }) => LoginPages(arguments: arguments ?? {'autoLogin': true}),
  '/regsiter':(context) => RegsiterPages(),
};

// 固定写法
// Navigator.pushNamed(context, '/recharge');
var onGenerateRoute=(RouteSettings settings) {
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = CupertinoPageRoute(
          builder: (context) => pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route = CupertinoPageRoute(
          builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
};