import '../services/http.dart';


class Api {
//  static const domain = 'https://web-yx-api.play322.com/';
  static const domain = 'https://web-jcn-api.play322.com/';
  static const downloadUrl = 'https://dev1.mifengff.com/ob9zm';

  // 登录
  static login(data) {
    return DioHttp.post(domain + 'web-api/login', data: data);
  }

  // 用户信息
  static userDetail({params}) {
    return DioHttp.post(domain + 'web-api/player/detail?${params ?? ""}');
  }

  // 注册
  static register(data) {
    return DioHttp.post(domain + 'web-api/register', data: data);
  }
  // 基础配置
  static baseConfig({flag: true}) {
    return DioHttp.post(domain + 'web-api/site/baseConfig${flag ? '?home' : ''}');
  }

  // 公告
  static noticeList(data) {
    return DioHttp.post(domain + 'web-api/noticeList', data: data);
  }

  // 站内信
  static getMessageList(data) {
    return DioHttp.post(domain + 'web-api/getMessageList', data: data);
  }

  // 阅读站内信
  static readMessage(data) {
    return DioHttp.post(domain + 'web-api/readMessage', data: data);
  }

  // 删除站内信
  static deleteMessage(data) {
    return DioHttp.post(domain + 'web-api/deleteMessage', data: data);
  }

  // 获取充值渠道
  static getRechargeChannel() {
    return DioHttp.post(domain + 'web-api/player/getRechargeChannel', data: {'device': 'mobile'});
  }

  // 发起充值
  static submitRecharge(data) {
    return DioHttp.post(domain + 'web-api/player/recharge', data: data);
  }

  // 获取提现 和 银行卡 提示信息
  static configureList({data}) {
    return DioHttp.post(domain + 'web-api/player/configureList', data: data);
  }

  // 获取银行卡
  static getBankList() {
    return DioHttp.get(domain + 'web-api/player/cardList');
  }

  // 添加银行卡
  static getCityList(data) {
    return DioHttp.post(domain + 'web-api/player/cityList', data: data);
  }

  // 添加银行卡验证
  static bindCardCheck(data) {
    return DioHttp.post(domain + 'web-api/player/bindCardCheck', data: data);
  }

  // 获取银行卡开户城市
  static bindBankCard(data) {
    return DioHttp.post(domain + 'web-api/player/bindCard', data: data);
  }

  // 确认提现
  static withdraw(data) {
    return DioHttp.post(domain + 'web-api/player/withdraw', data: data);
  }

  // 额度转换 获取平台
  static getCasinoPlat() {
    return DioHttp.post(domain + 'casino-api/casino/gamePlat');
  }

  // 额度转换 获取余额
  static getCasinoBalance(data) {
    return DioHttp.post(domain + 'casino-api/casino/getBalance', data: data);
  }

  // 额度转换 转入第三方
  static transferIn(data) {
    return DioHttp.post(domain + 'casino-api/casino/transferIn', data: data);
  }

  // 额度转换 从第三方转入到主钱包
  static transferTo(data) {
    return DioHttp.post(domain + 'casino-api/casino/transferTo', data: data);
  }

  // 团队 团队首页
  static proxyMain(data) {
    return DioHttp.post(domain + 'web-api/proxy/main', data: data);
  }

  // 团队 团队管理
  static childList(data) {
    return DioHttp.post(domain + 'web-api/proxy/childList', data: data);
  }

  // 团队 团队余额
  static childTeamBalance(data) {
    return DioHttp.post(domain + 'web-api/proxy/childTeamBalance', data: data);
  }

  // 团队 设置奖金组
  static prizeGroupSet(data) {
    return DioHttp.post(domain + 'web-api/proxy/prizeGroupSet', data: data);
  }

  // 团队 上下级转账
  static transferToChild(data) {
    return DioHttp.post(domain + 'web-api/proxy/transferToChild', data: data);
  }

  // 团队 获取分红配置
  static childsDividend(data) {
    return DioHttp.post(domain + 'web-api/proxy/childsDividend', data: data);
  }

  // 团队 设置分红信息
  static bonusSet(data) {
    return DioHttp.post(domain + 'web-api/proxy/bonusSet', data: data);
  }

  // 团队 设置日工资
  static salarySet(data) {
    return DioHttp.post(domain + 'web-api/proxy/salarySet', data: data);
  }

  // 团队 日工资报表
  static salaryList(data) {
    return DioHttp.post(domain + 'web-api/report/team/salaryList', data: data);
  }

  // 团队 代理分红报表
  static dividendList(data) {
    return DioHttp.post(domain + 'web-api/report/team/dividendList', data: data);
  }

  // 团队 发放分红
  static playerDividendSend(data) {
    return DioHttp.post(domain + 'web-api/report/playerDividendSend', data: data);
  }

  // 团队 团队盈亏
  static profitList(data) {
    return DioHttp.post(domain + 'web-api/report/team/profitList', data: data);
  }

  // 团队 团队盈亏 第三方平台
  static casinoProfitList(data) {
    return DioHttp.post(domain + 'web-api/report/team/casinoProfitList', data: data);
  }

  // 团队 开户
  static addChild(data) {
    return DioHttp.post(domain + 'web-api/proxy/addChild', data: data);
  }

  // 团队 链接开户
  static addInviteLink(data) {
    return DioHttp.post(domain + 'web-api/proxy/addInviteLink', data: data);
  }

  // 团队 查询链接开户
  static inviteLinkList() {
    return DioHttp.post(domain + 'web-api/proxy/inviteLinkList');
  }

  // 团队 删除链接
  static delInviteLink(data) {
    return DioHttp.post(domain + 'web-api/proxy/delInviteLink', data: data);
  }

  // 活动记录
  static getRecords() {
    return DioHttp.get(domain + 'web-api/activity/get-records');
  }

  // 订单记录
  static projectHistory(data) {
    return DioHttp.post(domain + 'web-api/lottery/projectHistory', data: data);
  }

  // 追加列表
  static traceHistory(data) {
    return DioHttp.post(domain + 'web-api/lottery/traceHistory', data: data);
  }

  // 追加列表详细
  static traceDetail(data) {
    return DioHttp.post(domain + 'web-api/lottery/traceDetail/${data}');
  }

  // 追加列表 撤销单个
  static cancelTraceDetail(data) {
    return DioHttp.post(domain + 'web-api/lottery/cancelTraceDetail', data: data);
  }

  // 追加列表 撤销全部
  static cancelTrace(data) {
    return DioHttp.post(domain + 'web-api/lottery/cancelTrace', data: data);
  }

  // 游戏列表
  static lotteryList() {
    return DioHttp.post(domain + 'web-api/lottery/lotteryList');
  }

  // 游戏配置
  static lotteryInfo() {
    return DioHttp.post(domain + 'web-api/lottery/lotteryInfo');
  }

  // 撤销订单
  static cancelProject(data) {
    return DioHttp.post(domain + 'web-api/lottery/cancelProject', data: data);
  }

  // 活动列表
  static getLists() {
    return DioHttp.post(domain + 'web-api/activity/getLists');
  }

  // 个人资料 头像
  static getInfo() {
    return DioHttp.post(domain + 'web-api/player/info');
  }

  // 设置个人资料
  static resetSpecificInfos(data) {
    return DioHttp.post(domain + 'web-api/player/setInfo', data: data);
  }

  // 退出
  static logout() {
    return DioHttp.post(domain + 'web-api/logout');
  }

  // 修改登录密码
  static changeLoginPassword(data) {
    return DioHttp.post(domain + 'web-api/player/changeLoginPassword', data: data);
  }

  // 设置资金密码
  static setFundPassword(data) {
    return DioHttp.post(domain + 'web-api/player/setFundPassword', data: data);
  }

  // 修改资金密码
  static changeFundPassword(data) {
    return DioHttp.post(domain + 'web-api/player/changeFundPassword', data: data);
  }

  // 任务中心
  static recordJob() {
    return DioHttp.post(domain + 'web-api/player/recordJob');
  }

  // 任务中心
  static trackJob(data) {
    return DioHttp.post(domain + 'web-api/player/trackJob', data: data);
  }

  // 任务中心
  static jobHistory(data) {
    return DioHttp.post(domain + 'web-api/player/jobHistory', data: data);
  }

}

//var response = await Api.login();
//print(response);
//if(response['success']) {
//
//}