import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:r_upgrade/r_upgrade.dart';
import 'dart:io';

import '../../api/api.dart';


class UpApp extends StatefulWidget {
  @override
  _UpAppState createState() => _UpAppState();
}

class _UpAppState extends State<UpApp> {
  int id = 1;

  bool isClickHotUpgrade;

  GlobalKey<ScaffoldState> _state = GlobalKey();

  String iosVersion = "";

  @override
  void initState() {
    super.initState();
  }

  int lastId;

  DownloadStatus lastStatus;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _state,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('版本更新', style: TextStyle(fontSize: 16)),
      ),
      body: _buildMultiPlatformWidget(),
    );
  }

  Widget _buildMultiPlatformWidget() {
    if (Platform.isAndroid) {
      return _buildAndroidPlatformWidget();
    } else if (Platform.isIOS) {
      return _buildIOSPlatformWidget();
    } else {
      return Container(
        child: Text('Sorry, your platform is not support', style: TextStyle(fontSize: 16)),
      );
    }
  }
//ios更新页面
  Widget _buildIOSPlatformWidget() => ListView(
    children: <Widget>[
      ListTile(
        title: Text('Go to url(WeChat)'),
        onTap: () async {
          RUpgrade.upgradeFromUrl(
            'https://apps.apple.com/cn/app/wechat/id414478124?l=en',
          );
        },
      ),
      ListTile(
        title: Text('Go to appStore from appId(WeChat)'),
        onTap: () async {
          RUpgrade.upgradeFromAppStore(
            '414478124',
          );
        },
      ),
      ListTile(
        title: Text('get version from app store(WeChat)'),
        trailing: iosVersion != null
            ? Text(iosVersion,
            style: Theme.of(context).textTheme.subtitle.copyWith(
              color: Colors.grey,
            ))
            : null,
        onTap: () async {
          String versionName =
          await RUpgrade.getVersionFromAppStore('414478124');
          setState(() {
            iosVersion = versionName;
          });
        },
      ),
    ],
  );

//安卓更新页面
  Widget _buildAndroidPlatformWidget() => ListView(
    children: <Widget>[
      _buildDownloadWindow(),
//      GestureDetector(
//        behavior: HitTestBehavior.opaque,
//        child: Text('跳转AppStore应用商店更新', style: TextStyle(fontSize: 14, decoration: TextDecoration.underline), textAlign: TextAlign.center),
//        onTap: () async{
//          bool isSuccess = await RUpgrade.upgradeFromAndroidStore(AndroidStore.BAIDU);
//          print('${isSuccess ? '跳转成功' : '跳转失败'}');
//        },
//      ),
      FractionallySizedBox(
        widthFactor: .6,
        child: RaisedButton(
            child: Text('开始更新', style: TextStyle(fontSize: 14, color: Colors.white), textAlign: TextAlign.center),
            color: Color(0xff5f9afa),
            onPressed: () async{
              if (isClickHotUpgrade != null) {
//                _state.currentState.showSnackBar(SnackBar(content: Text('已开始下载')));
                if (isClickHotUpgrade == true) {
                  _state.currentState.showSnackBar(SnackBar(content: Text('请进行更新')));
                  return;
                }
                bool isSuccess = await RUpgrade.install(id);
                if (isSuccess) {
//                  _state.currentState.showSnackBar(SnackBar(content: Text('请求成功')));
                }
                return;
              }
              isClickHotUpgrade = false;
              if (!await canReadStorage()) return;
              id = await RUpgrade.upgrade(
                  'http://lingji-invoice.oss-cn-shenzhen.aliyuncs.com/lonely/20200615/43ee8357d49141da959bb5be5ea78953.apk',
                  apkName: 'longli.apk',
                  isAutoRequestInstall: true,
                  useDownloadManager: false
              );
            },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
      ),
      FractionallySizedBox(
        widthFactor: .6,
        child: RaisedButton(
            child: Text('跳转到浏览器更新', style: TextStyle(fontSize: 14, color: Colors.white), textAlign: TextAlign.center),
            color: Color(0xff5f9afa),
            onPressed: () async{
              bool isSuccess = await RUpgrade.upgradeFromUrl(Api.downloadUrl);
              print(isSuccess);
            },
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0))),
      ),
//      ListTile(
//        title: Text('安装apk'),
//        onTap: () async {
//          if (isClickHotUpgrade == true) {
//            _state.currentState.showSnackBar(SnackBar(content: Text('请进行更新')));
//            return;
//          }
//          bool isSuccess = await RUpgrade.install(id);
//          if (isSuccess) {
//            _state.currentState.showSnackBar(SnackBar(content: Text('请求成功')));
//          }
//        },
//      ),
//      ListTile(
//        title: Text('继续更新'),
//        onTap: () async {
//          if (id == null) {
//            _state.currentState
//                .showSnackBar(SnackBar(content: Text('当前没有ID可升级')));
//            return;
//          }
//          await RUpgrade.upgradeWithId(id);
//          setState(() {});
//        },
//      ),
//      ListTile(
//        title: Text('暂停更新'),
//        onTap: () async {
//          bool isSuccess = await RUpgrade.pause(id);
//          if (isSuccess) {
//            _state.currentState.showSnackBar(SnackBar(content: Text('暂停成功')));
//            setState(() {});
//          }
//          print('cancel');
//        },
//      ),
//      ListTile(
//        title: Text('取消更新'),
//        onTap: () async {
//          bool isSuccess = await RUpgrade.cancel(id);
//          if (isSuccess) {
//            _state.currentState.showSnackBar(SnackBar(content: Text('取消成功')));
//            id = null;
//            isClickHotUpgrade = null;
//            setState(() {});
//          }
//          print('cancel');
//        },
//      ),
//      Divider(),
//      ListTile(
//        title: Text(
//          '热更新相关',
//          style: Theme.of(context).textTheme.title.copyWith(fontWeight: FontWeight.w600,
//          ),
//        ),
//      ),
//      ListTile(
//        title: Text('开始热更新'),
//        onTap: () async {
//          if (isClickHotUpgrade != null) {
//            _state.currentState.showSnackBar(SnackBar(content: Text('已开始下载')));
//            return;
//          }
//          isClickHotUpgrade = true;
//
//          if (!await canReadStorage()) return;
//          id = await RUpgrade.upgrade(
//              'http://lingji-invoice.oss-cn-shenzhen.aliyuncs.com/lonely/20200424/f1f584483ae04a98982ecdfd47e91d0b.apk',
//              apkName: 'longli.apk',
//              isAutoRequestInstall: true,
//              notificationStyle: NotificationStyle.speech,
//          );
//
//          setState(() {});
//        },
//      ),
//      ListTile(
//        title: Text('进行热更新'),
//        onTap: () async {
//          if (isClickHotUpgrade == false) {
//            _state.currentState.showSnackBar(SnackBar(content: Text('请进行安装应用')));
//            return;
//          }
//          if (id == null) {
//            _state.currentState.showSnackBar(SnackBar(content: Text('请点击开始热更新')));
//            return;
//          }
//          bool isSuccess = await RUpgrade.hotUpgrade(id);
//          if (isSuccess) {
//            _state.currentState.showSnackBar(
//                SnackBar(content: Text('热更新成功，3s后退出应用，请重新进入')));
//            Future.delayed(Duration(seconds: 3)).then((_) {
//              SystemNavigator.pop(animated: true);
//            });
//          } else {
//            _state.currentState.showSnackBar(SnackBar(content: Text('热更新失败，请等待更新包下载完成')));
//          }
//        },
//      ),
    ],
  );
  //进度 可替换为进度条
  Widget _buildDownloadWindow() => Container(
    height: 200,
    alignment: Alignment.center,
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: StreamBuilder(
      stream: RUpgrade.stream,
      builder: (BuildContext context,
          AsyncSnapshot<DownloadInfo> snapshot) {
        if (snapshot.hasData) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('${snapshot.data.planTime.toStringAsFixed(0)}s后完成', style: TextStyle(fontSize: 12)),
              SizedBox(
                height: 10,
              ),

              SizedBox(
                height: 120,
                width: 120,
                child: CircleDownloadWidget(
                  backgroundColor: snapshot.data.status ==
                      DownloadStatus.STATUS_SUCCESSFUL
                      ? Colors.green
                      : null,
                  progress: snapshot.data.percent / 100,
                  child: Center(
                    child: Text(
                      snapshot.data.status ==
                          DownloadStatus.STATUS_RUNNING
                          ? getSpeech(snapshot.data.speed)
                          : getStatus(snapshot.data.status),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        } else {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text('  ', style: TextStyle(fontSize: 12)),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 120,
                width: 120,
                child: CircleDownloadWidget(
                  progress: 0,
                  child: Center(
                    child: Text('0%', style: TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
              )
            ],
          );
        }
      },
    )
  );

  String getStatus(DownloadStatus status) {
    if (status == DownloadStatus.STATUS_FAILED) {
      id = null;
      isClickHotUpgrade = null;
      return "下载失败";
    } else if (status == DownloadStatus.STATUS_PAUSED) {
      return "下载暂停";
    } else if (status == DownloadStatus.STATUS_PENDING) {
      return "获取资源中";
    } else if (status == DownloadStatus.STATUS_RUNNING) {
      return "下载中";
    } else if (status == DownloadStatus.STATUS_SUCCESSFUL) {
      return "下载成功";
    } else if (status == DownloadStatus.STATUS_CANCEL) {
      id = null;
      isClickHotUpgrade = null;
      return "下载取消";
    } else {
      id = null;
      isClickHotUpgrade = null;
      return "未知";
    }
  }

  Future<bool> canReadStorage() async {
    if (Platform.isIOS) return true;
    var status = await PermissionHandler()
        .checkPermissionStatus(PermissionGroup.storage);
    if (status != PermissionStatus.granted) {
      var future = await PermissionHandler()
          .requestPermissions([PermissionGroup.storage]);
      for (final item in future.entries) {
        if (item.value != PermissionStatus.granted) {
          return false;
        }
      }
    } else {
      return true;
    }
    return true;
  }
  //网速
  String getSpeech(double speech) {
    String unit = 'kb/s';
    String result = speech.toStringAsFixed(2);
    if (speech > 1024 * 1024) {
      unit = 'gb/s';
      result = (speech / (1024 * 1024)).toStringAsFixed(2);
    } else if (speech > 1024) {
      unit = 'mb/s';
      result = (speech / 1024).toStringAsFixed(2);
    }
    return '$result$unit';
  }
}
//进度球
class CircleDownloadWidget extends StatelessWidget {
  final double progress;
  final Widget child;
  final Color backgroundColor;

  const CircleDownloadWidget(
      {Key key, this.progress, this.child, this.backgroundColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: CustomPaint(
        painter: CircleDownloadCustomPainter(
          backgroundColor ?? Colors.grey[400],
          Theme.of(context).primaryColor,
          progress,
        ),
        child: child,
      ),
    );
  }
}

class CircleDownloadCustomPainter extends CustomPainter {
  final Color backgroundColor;
  final Color color;
  final double progress;

  Paint mPaint;

  CircleDownloadCustomPainter(this.backgroundColor, this.color, this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    if (mPaint == null) mPaint = Paint();
    double width = size.width;
    double height = size.height;

    Rect progressRect =
    Rect.fromLTRB(0, height * (1 - progress), width, height);
    Rect widgetRect = Rect.fromLTWH(0, 0, width, height);
    canvas.clipPath(Path()..addOval(widgetRect));

    canvas.drawRect(widgetRect, mPaint..color = backgroundColor);
    canvas.drawRect(progressRect, mPaint..color = color);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
