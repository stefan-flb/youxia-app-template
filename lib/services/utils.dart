import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart'; // 适配设备各种分辨率
import 'package:shared_preferences/shared_preferences.dart';

// 颜色
class ColorGather{
  static colorMain() {
    return Colors.red; // 主题色
  }
  static colorBg() {
    return Color.fromRGBO(236, 236, 236, 1); // 浅灰色
  }
  static colorFont() {
    return Color.fromRGBO(150, 150, 150, 1); // 稍深 浅灰色
  }
  static colorFontYwllow() {
    return Color.fromRGBO(255,185,112, 1); // 字体黄色
  }
  static colorBgYwllow() {
    return Color.fromRGBO(252,253,235, 1); // 背景浅黄色
  }
}

// 适配设备各种分辨率
class Screen{
  static init(context, {width = 750, height = 1334}) {
    ScreenUtil.init(context, width: width, height: height); //初始化 每个页面的 build 都要引入
  }
  static width(value) {
    return ScreenUtil().setWidth(value); //设置 宽度
  }
  static height(value) {
    return ScreenUtil().setHeight(value); //设置 高度
  }
  static screenWidth() {
    return ScreenUtil.screenWidth; //设备宽度
  }
  static screenHeight() {
    return ScreenUtil.screenHeight; //设备高度
  }
  static weightWidth(context) {
    return MediaQuery.of(context).size.width; //weight宽度
  }
  static weightHeight(context) {
    return MediaQuery.of(context).size.height; //weight高度
  }
  static appbarHeight() {
    return 80; //appbar高度
  }
  static pixelRatio() {
    return ScreenUtil.pixelRatio; //设备的像素密度
  }
  static statusBarHeight() {
    return ScreenUtil.statusBarHeight; //状态栏高度 刘海屏会更高  单位px
  }
  static bottomBarHeight() {
    return ScreenUtil.bottomBarHeight; //底部安全区距离，适用于全面屏下面有按键的
  }
  static scaleWidth() {
    return ScreenUtil().scaleWidth; // 实际宽度的dp与设计稿px的比例
  }
  static scaleHeight() {
    return ScreenUtil().scaleHeight; // 实际高度的dp与设计稿px的比例
  }
  static textScaleFactor() {
    return ScreenUtil.textScaleFactor ; //系统字体缩放比例
  }
}

// 本地存储
// get获取
//Storage.getBool('autoLogin').then((val) {
//if (val != null) {
//setState(() {autoLogin = val;});
//}
//});
class Storage{
  static setString(key,value) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString(key, value);
  }
  static setBool(key,value) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool(key, value);
  }
  static setDouble(key,value) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setDouble(key, value);
  }
  static setInt(key,value) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setBool(key, value);
  }
  static setStringList(key,value) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setStringList(key, value);
  }
  static Future<String> getString(key) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(key);
  }
  static getBool(key) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getBool(key);
  }
  static getDouble(key) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getDouble(key);
  }
  static getInt(key) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getInt(key);
  }
  static getStringList(key) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getStringList(key);
  }
  static Future<void> remove(key) async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove(key);
  }
  static Future<void> clear() async{
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.clear();
  }
}

// 正则
class Regular{
//  验证手机号 13+任意数 * 15+除4的任意数 * 18+除1和4的任意数 * 17+除9的任意数 * 147
  static isChinaPhoneLegal(str) {
    return RegExp('^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$').hasMatch(str);
  }

//  验证中文
  static isChinese(str) {
    return RegExp(r"[\u4e00-\u9fa5]").hasMatch(str);
  }
//  验证Email
  static isEmail(str) {
    return RegExp('^\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*\$').hasMatch(str);
  }
}


class Utils {
    /*
    * 显示小数点后面几位
    * str 字符串
    * num 显示小数点后几位小数
    */
  static toFixed (str, {num: 2}) {
    if (str is String == false) {
      str = str.toString();
    }
    if (str.indexOf('.') > -1) {
      var zeo = '';
      var subLength = str.substring(str.lastIndexOf('.') + 1, str.length).length;
      for (var i = 0; i < (num - subLength); i++) {
        zeo += '0';
      }
      if(subLength <= num) {
        return str + zeo;
      } else {
        return str.substring(0, str.indexOf('.') + 1) + str.substring(str.indexOf('.') + 1, str.indexOf('.') + 1 + num);
      }
    } else {
      var zeo = '';
      for (var i = 0; i < num; i++) {
        zeo += '0';
      }
      return str + '.' + zeo;
    }
  }

  // 加密密码
  static randomBit(int len) {
    String scopeF = '123456789';//首位
    String scopeC = '0123456789';//中间
    String result = '';
    for (int i = 0; i < len; i++) {
      if (i == 1) {
        result = scopeF[Random().nextInt(scopeF.length)];
      } else {
        result = result + scopeC[Random().nextInt(scopeC.length)];
      }
    }
    return result;
  }

  static password(password) {
    var head = int.parse(randomBit(19)).toRadixString(36).substring(2, 7);
    var floor = int.parse(randomBit(19)).toRadixString(36).substring(2, 6);

    var bytes = utf8.encode(head + password);
    return base64Encode(utf8.encode(base64Encode(bytes)) + utf8.encode(floor));
  }
}

