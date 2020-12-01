//import 'dart:io';
//import 'dart:ui';
//import 'dart:isolate';
//import 'package:flutter/foundation.dart';
//import 'package:open_file/open_file.dart';
//import 'package:dio/dio.dart';
//import 'package:package_info/package_info.dart';
//import 'package:device_info/device_info.dart';
//import 'package:path_provider/path_provider.dart';
//import 'package:permission_handler/permission_handler.dart';
//import 'package:flutter_downloader/flutter_downloader.dart';
//import 'eventBus.dart';
//
//var _localPath;
//var update = false;
//var savedDir;
//var taskId;
//var cancleLoggedInEvent;
//
//// 获取存储路径
//Future<String> _findLocalPath() async {
//  // 因为Apple没有外置存储，所以第一步我们需要先对所在平台进行判断
//  // 如果是android，使用getExternalStorageDirectory
//  // 如果是iOS，使用getApplicationSupportDirectory
//  final directory = defaultTargetPlatform== TargetPlatform.android
//      ? await getExternalStorageDirectory()
//      : await getApplicationSupportDirectory();
//  return directory.path;
//}
//
//// 根据 _localPath 下载文件
//_downloadFile() async {
//  // 获取存储路径
//  _localPath = await _findLocalPath();
//  print(_localPath);
//  taskId = await FlutterDownloader.enqueue(
//    url: 'https://jderp.3mzz.cn/update/app/jderp.apk',
////    url: 'https://jderp.3mzz.cn/update/app/version.txt',
//    savedDir: _localPath,
//    showNotification: true,
//    // show download progress in status bar (for Android)
//    openFileFromNotification: true, // click on notification to open downloaded file (for Android)
//  );
//
//}
//// 根据taskId打开下载文件
//Future<bool> _openDownloadedFile(taskId) {
//  return FlutterDownloader.open(taskId: taskId);
//}
//
//class Update {
//  // 下载完成之后的回调
//  static downloadCallback(id, status, progress) {
////    final send = IsolateNameServer.lookupPortByName('downloader_send_port');
//    print('Background Isolate Callback: task ($id) is in status ($status) and process ($progress)');
//    print('12345678');
//
//    if (status == DownloadTaskStatus.complete) {
//      print('DownloadTaskStatus.complete111111');
//
////      _openDownloadedFile(taskId);
////    OpenFile.open('/storage/emulated/0/Android/data/com.example.xw/files/jderp.apk');
////    _openDownloadedFile(id);
////    _installApk();
//    }
////    send.send([id, status, progress]);
//  }
//
//  static registerCallback() {
//    return FlutterDownloader.registerCallback(downloadCallback);
//  }
//
//  static check() async{
////    WidgetsFlutterBinding.ensureInitialized();
////    FlutterDownloader.initialize();
//    PackageInfo packageInfo = await PackageInfo.fromPlatform();
//    var version = packageInfo.version;
//
//    var result = await Dio().get('http://rap2.taobao.org:38080/app/mock/template/1537058');
//    var data = result.data;
//
//    print('112223333');
//    print(data);
//    if(result.statusCode == 200) {
//      // ignore: unrelated_type_equality_checks
//      if(defaultTargetPlatform == TargetPlatform.android && double.parse(data['version']) != version) {
//
//        var status = await Permission.storage.status;
//        if (status.isUndetermined) {
//          // We didn't ask for permission yet.
//        }
//// You can can also directly ask the permission about its status.
//        if (await Permission.storage.isRestricted) {
//          // The OS restricts access, for example because of parental controls.
//          if (await Permission.storage.request().isGranted) {
//            // Either the permission was already granted before or the user just granted it.
//          }
//// You can request multiple permissions at once.
////          Map<Permission, PermissionStatus> statuses = await [
////            Permission.location,
////            Permission.storage,
////          ].request();
//        }
//        _downloadFile();
//        FlutterDownloader.registerCallback(downloadCallback);
//      } else {
//        return false;
//      }
//    } else {
//      return false;
//    }
//  }
//}