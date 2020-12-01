import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'utils.dart';
import '../services/utils.dart';
import '../api/api.dart';

var dio = Dio();
Map cancelList = Map();
var noCancelList = [
  Api.domain + 'casino-api/casino/getBalance',
];
var _globalptions;
var hideLoading = [
  Api.domain + 'web-api/site/baseConfig?home',
  Api.domain + 'web-api/site/baseConfig',
  Api.domain + 'web-api/player/detail?',
  Api.domain + 'web-api/noticeList',
  Api.domain + 'web-api/getMessageList',
  Api.domain + 'web-api/readMessage',
  Api.domain + 'web-api/deleteMessage',
  Api.domain + 'web-api/proxy/childTeamBalance',
  Api.domain + 'web-api/proxy/childList',
  Api.domain + 'web-api/player/cardList',
  Api.domain + 'web-api/report/team/salaryList',
  Api.domain + 'web-api/report/team/dividendList',
  Api.domain + 'web-api/report/team/casinoProfitList',
  Api.domain + 'web-api/report/team/profitList',
  Api.domain + 'web-api/proxy/inviteLinkList',
  Api.domain + 'web-api/lottery/projectHistory',
  Api.domain + 'web-api/lottery/traceHistory',
  Api.domain + 'web-api/lottery/lotteryList',
  Api.domain + 'web-api/lottery/lotteryInfo',
  Api.domain + 'web-api/logout',
  Api.domain + 'casino-api/casino/getBalance',
];

interceptors () async{
  // loading 样式
  EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.ring;
  EasyLoading.instance.maskType = EasyLoadingMaskType.black;
  EasyLoading.instance.lineWidth = 3.0;
  EasyLoading.instance.indicatorSize = 35.0;

//  (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
//      (client) {
//    client.findProxy = (uri) {
//      return 'PROXY 192.168.0.102:8888';
//    };
//  };
  //  dio.options.responseType = ResponseType.json;
  //  dio.options.contentType = 'application/json;charset=UTF-8';
  dio.options.connectTimeout = 15000;
  dio.options.receiveTimeout = 15000;
  dio.interceptors.add(
    InterceptorsWrapper(
        onRequest: (options) async {
          _globalptions = options;
          // 此处可网络请求之前做相关配置，比如会所有请求添加token
          var tokens = await Storage.getString('token');
//           options.queryParameters['authorization'] = 'Bearer ${tokens}';
          if(tokens != '') {
            options.headers['authorization'] = 'Bearer ${tokens}';
          }
          if(options.path == Api.domain + 'web-api/site/baseConfig') {
            EasyLoading.show(status: '初始化中...');
          }
          if(hideLoading.indexOf(_globalptions.path) == -1) {
            EasyLoading.show();
          }
//          print("method = ${options.method.toString()}");
//          print("url = ${options.uri.toString()}");
//          print("headers = ${options.headers}");
//          print("params = ${options.queryParameters}");
          return options;
        },
        onResponse: (response) {
          //此处拦截工作在数据返回之后，可在此对dio请求的数据做二次封装或者转实体类等相关操作
          EasyLoading.dismiss();
          return response;
        },
        onError: (error) {
          //处理错误请求
          EasyLoading.dismiss();
          return error;
        }),
  );

}

class DioHttp {

//  DioHttp.get(
//  'http://www.phonegap100.com/appapi.php?a=getPortalList',
//  queryParameters: {
//  'catid': 20, 'page': page
//  },
//  success: (e) {
//  setState(() {list.addAll(e);page++;});
//  if(e.length < 20) {setState(() {pageFlag = false;});}
//  });

  static get (url, {queryParameters}) async{
    interceptors();
    print('post参数:');
    try{
      var response = await dio.get(url, queryParameters: queryParameters ?? {});
      if(response.statusCode == 200) {
        if(!response.data['success']) {
          showToast(response.data['msg']);
        }
      }
      return response.data;
    } catch (e) {
      formatError(e);
      throw Exception('erroor: $e');
    }
  }

  static post (url, { data }) async{
    interceptors();
    print('post参数:');
    print(url);
    print(data);
    try {
      // 重复请求 拦截取消
      var cancelTokens = CancelToken();
      // 特殊情况  取消重复请求限制
      if(noCancelList.indexOf(url) == -1) {
        // 创建新map 把url插入到map  存在就取消上一个 取消完删除map对应的数据
        if(cancelList.containsKey(url)) {
          cancelList[url].cancel("cancelled");
          cancelList.remove(url);
        }
        cancelList[url] = cancelTokens;
      }
      var response = await dio.post(url, data: data ?? {}, cancelToken: cancelTokens);
      if(response.statusCode == 200) {
        if(!response.data['success']) {
          showToast(response.data['msg']);
        }
      }
      // 拦截重复请求 返回完之后删除url
//      cancelList.remove(url);
      return response.data;
    } catch (e) {
      formatError(e);
      throw Exception('erroor: $e');
    }
  }
  static post2 (url, {data, success = '', error = '', headers = '', requests = '', statusCodes = '', onSendProgress}) async{
    interceptors();
    try{
      var response = await dio.post(url, data: data ?? {}, onSendProgress: onSendProgress ?? () {});

      if(headers != '') {headers(response.headers);}
      if(requests != '') {requests(response.request);}
      if(statusCodes != '') {statusCodes(response.statusCode);}

      if(response.statusCode == 200) {
        var res = json.decode(response.data)['result'];
        if(success != '') {success(res);}
      } else {
        if(error != '') {error(response);}
        throw Exception('erroor: $response');
      }
    } catch (e) {
      formatError(e);
      throw Exception('erroor: $e');
    }
  }

  static download (url, saveUrl, {success, error, onReceiveProgress}) async{
    interceptors();
    try{
      var response = await dio.download(url, saveUrl, onReceiveProgress: onReceiveProgress ?? () {});

      if(response.statusCode == 200) {
        var res = json.decode(response.data)['result'];
        if(success != '') {success(res);}
      } else {
        if(error != '') {error(response);}
        throw Exception('erroor: $response');
      }
    } catch (e) {
      formatError(e);
      throw Exception('erroor: $e');
    }
  }

  static formData (url, data, {success, error}) async{
    interceptors();
//    var formData = FormData.fromMap({
//      'name': 'wendux',
//      'age': 25,
//    });
    try{
      var response = await dio.post(url, data: data ?? {});

      if(response.statusCode == 200) {
        var res = json.decode(response.data)['result'];
        if(success != '') {success(res);}
      } else {
        if(error != '') {error(response);}
        throw Exception('erroor: $response');
      }
    } catch (e) {
      formatError(e);
      throw Exception('erroor: $e');
    }
  }
}
//  error统一处理
void formatError(DioError e) {
  if (e.type == DioErrorType.CONNECT_TIMEOUT) {
    showToast('连接超时');
    print("连接超时");
  } else if (e.type == DioErrorType.SEND_TIMEOUT) {
    showToast('请求超时');
    print("请求超时");
  } else if (e.type == DioErrorType.RECEIVE_TIMEOUT) {
    showToast('响应超时');
    print("响应超时");
  } else if (e.type == DioErrorType.RESPONSE) {
    showToast('${e.message}');
    print("出现异常 404 401");
  } else if (e.type == DioErrorType.CANCEL) {
    print("请求取消");
  } else {
    showToast('失败 请重试');
    print("未知错误");
  }

}

// toast
showToast (msg) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 14.0
  );
}
loading() {
  return Center(
    child: Container(
      margin: EdgeInsets.only(top: 0),
      decoration: BoxDecoration(
          color: Color.fromRGBO(0, 0, 0, 1.0),
          borderRadius: BorderRadius.circular(Screen.width(8))
      ),
      height: Screen.width(130),
      width: Screen.width(130),
      child: Container(
        alignment: Alignment.center,
        width: Screen.width(40),
        height: Screen.width(40),
        margin: EdgeInsets.only(bottom: Screen.height(15), top: Screen.width(15)),
        child: CircularProgressIndicator(
          strokeWidth: Screen.width(6),
          backgroundColor: Colors.black,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      ),
    ),
  );
}