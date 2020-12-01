import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import 'services/state.dart';
import 'routes/index.dart';
import 'api/api.dart';
import 'app/component/upApp.dart';

var version = '2.0';
var update = false;

void main() async{
//   var result = await Dio().get('http://rap2.taobao.org:38080/app/mock/template/1537058');
//   var data = result.data;
//   if(result.statusCode == 200) {
// //    if(defaultTargetPlatform == TargetPlatform.android && data['version'].toString() != version) {
//     if(data['version'].toString() != version) {
//       update = true;
//     } else {
//       update = false;
//     }
//   }
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  createState() => _MyApp();
}

class _MyApp extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _init();
  }
  Widget build(BuildContext context) {
    globeBuildContext = context;
    return update == false ? MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Providers()),
      ],
      child: FlutterEasyLoading(
        child: MaterialApp(
          debugShowCheckedModeBanner: false, // 去掉软件右上角的debug
          initialRoute: '/', // 默认显示的路由
          onGenerateRoute: onGenerateRoute, // 路由配置
        )
      )
    ) : MaterialApp(
      debugShowCheckedModeBanner: false, // 去掉软件右上角的debug
      home: UpApp(),
    );
  }

  _init () {
//    Api.baseConfig(flag: false).then((response) {
//      if(response['success']) {
//        setState(() {getBaseConfig = response['data'];});
//      }
//    });
  }
}

//class UpdateVersionDialog extends StatefulWidget {
//  @override
//   createState() => _UpdateVersionDialogState();
//}
//
//class _UpdateVersionDialogState extends State<UpdateVersionDialog> {
//
//  @override
//  initState(){
//    super.initState();
//  }
//  Widget build(BuildContext context) {
//    final screenSize = MediaQuery.of(context).size;
//
//    return Material(
//        type: MaterialType.transparency,
//        child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//            ]));
//  }
//
//}
