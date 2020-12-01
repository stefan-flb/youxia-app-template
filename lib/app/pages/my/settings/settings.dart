import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../services/utils.dart';
import '../../../../services/state.dart';
import '../../../../api/api.dart';
import '../../../component/component.dart';
import '../../../component/dialog.dart';
import 'userInfo.dart';


import '../about/about.dart';
import '../changePassword/changePassword.dart';

class SettingPages extends StatefulWidget{
  createState() => _SettingPages();
}

class _SettingPages extends State {
  Map userInfo = {};

  // 相册
  getAlbumImg() async {
    var album = await ImagePicker.pickImage(source: ImageSource.gallery, maxWidth: 100, maxHeight: 100);
//    uploadImg(album);
    setState(() {
      userInfo['user_icon'] = album.path;
    });
    print('999999');
    print(userInfo['user_icon']);
  }
  // 上传图片
//  uploadImg(imgUrl) async {
//    var path = imgUrl.path;
//    var formData = FormData.fromMap({
//      "name": "wendux",
//      "age": 25,
//      "file": MultipartFile.fromFileSync(path, filename: "upload.img")
//    });
//    var response = await Dio().post("https://pub.dev/packages/dio", data: formData);
//    print(response);
//  }
  @override
  initState() {
    super.initState();
    Storage.getString('userDetail').then((response) {
      if(response != null) {
        setState(() {
          userInfo = json.decode(response);
        });
      }
    });
  }
  Widget build(BuildContext context) {
    Screen.init(context);
    // TODO: implement build
    return Scaffold(
        appBar: HeadersComponent.Appbars(
            Text('设置', style: TextStyle(fontSize: Screen.width(32)),)
        ),
        body: Container(
          color: ColorGather.colorBg(),
          child: ListView(
            children: <Widget>[
              ListTitleComponent(
                title: Text('个人资料', style: TextStyle(fontSize: Screen.width(30))),
                onTap: () async{
                  Navigator.of(context).push(CupertinoPageRoute( builder: (context) => UserInfoPages(arguments: {})));
                  // var response = await Api.getInfo();
                  // if(response['success']) {
                  //   Navigator.of(context).push(CupertinoPageRoute( builder: (context) => UserInfoPages(arguments: response['data'])));
                  // }

                },
              ),
              Divider(height: 0,),
              ListTitleComponent(
                title: Text('头像', style: TextStyle(fontSize: Screen.width(30))),
                trailing: Row(
                  children: <Widget>[
                    ClipOval(
                       child: Image.asset('images/home/banner_01.jpg', width: Screen.width(80), height: Screen.width(80), fit: BoxFit.cover,)
                    ),
                    SizedBox(width: Screen.width(15),),
                    Icon(Icons.arrow_forward_ios, size: Screen.width(26), color: Colors.grey),
                  ],
                ),
                onTap: () async{
//                   var response = await Api.getInfo();
//                   if(response['success']) {
// //                    Navigator.pop(context);
//                     var result = await Navigator.pushNamed(context, '/avatar', arguments: response['data']);
//                     setState(() {userInfo['user_icon'] = result;});
//                   }
//                  DialogComponents.customSheetIos(
//                      context,
//                      content: Column(
//                        children: <Widget>[
//                          GestureDetector(
//                            behavior: HitTestBehavior.opaque,
//                            child: Container(
//                              alignment: Alignment.center,
//                              width: double.infinity, height: Screen.width(95),
//                              child: Text('系统头像', style: TextStyle(fontSize: Screen.width(30), decoration: TextDecoration.none, fontWeight: FontWeight.normal, color: Colors.black)),
//                            ),
//                            onTap: () async{
//                              var response = await Api.getInfo();
//                              if(response['success']) {
//                                Navigator.pop(context);
//                                var result = await Navigator.pushNamed(context, '/avatar', arguments: response['data']);
//                                setState(() {userInfo['user_icon'] = result;});
//                              }
//                            }
//                          ),
//                          Divider(height: 0,),
//                          GestureDetector(
//                            behavior: HitTestBehavior.opaque,
//                            child: Container(
//                              alignment: Alignment.center,
//                              width: double.infinity, height: Screen.width(95),
//                              child: Text('手机相册', style: TextStyle(fontSize: Screen.width(30), decoration: TextDecoration.none, fontWeight: FontWeight.normal, color: Colors.black)),
//                            ),
//                            onTap: () {
//                              getAlbumImg();
//                              Navigator.pop(context);
//                              setState(() {});
//                            },
//                          ),
//                        ],
//                      )
//                  );
                },
              ),

              Container(height: Screen.width(20),  color: ColorGather.colorBg()),
              ListTitleComponent(
                title: Text('修改密码', style: TextStyle(fontSize: Screen.width(30))),
                onTap: () {
                  Navigator.of(context).push(CupertinoPageRoute( builder: (context) => ChangePassword()));
                },
              ),
              Divider(height: 0,),
              ListTitleComponent(
                title: Text('关于我们', style: TextStyle(fontSize: Screen.width(30))),
                onTap: () {
                  Navigator.of(context).push(CupertinoPageRoute( builder: (context) => AboutPages()));
                },
              ),
              Divider(height: 0,),
              ListTitleComponent(
                title: Text('当前版本', style: TextStyle(fontSize: Screen.width(30))),
                trailing: Text('v1.1', style: TextStyle(fontSize: Screen.width(28), color: Colors.grey)),
                onTap: () {},
              ),
              Container(height: Screen.width(20),  color: ColorGather.colorBg()),
              ListTitleComponent(
                crossAxisAlignment: CrossAxisAlignment.center,
                title: Text('退出登陆', style: TextStyle(fontSize: Screen.width(30), color: ColorGather.colorMain())),
                trailingShow: false,
                onTap: () {
                  DialogComponents.alertIos(
                      context,
                      content: [
                        Text('确定退出登录吗?', style: TextStyle(fontSize: Screen.width(28))),
                      ],
                      confirm: () {
                        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false, arguments: {
                          'autoLogin': false
                        });
                        // Api.logout();
                      }
                  );
                },
              ),


              SizedBox(height: Screen.width(50),),
            ],
          ),
        )
    );
  }
}