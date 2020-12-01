import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../services/utils.dart';
import '../../../../services/state.dart';
import '../../../component/component.dart';
import '../../../component/dialog.dart';

class AvatarPages extends StatefulWidget{
  var arguments;
  AvatarPages({this.arguments});
  createState() => _AvatarPages(this.arguments);
}

class _AvatarPages extends State {
  var arguments;
  _AvatarPages(this.arguments);
  var currentIndex = -1;
  @override
  initState() {
    super.initState();
  }
  Widget build(BuildContext context) {
    Screen.init(context);
    // TODO: implement build
    return Scaffold(
        appBar: HeadersComponent.Appbars(Text('选择头像', style: TextStyle(fontSize: Screen.width(32)),)),
        body: Container(
          child: ListView(
            children: <Widget>[
              SizedBox(height: Screen.width(30),),
              GridView.builder(
                shrinkWrap: true,
                physics: new NeverScrollableScrollPhysics(),
                padding: EdgeInsets.only(left: Screen.width(20), right: Screen.width(20)),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: Screen.width(30),
                    mainAxisSpacing: Screen.width(20),
                    childAspectRatio: 1
                ),
                itemCount: arguments['avatar_option'].length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: <Widget>[
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        child: ClipOval(child: Image.network('${getBaseConfig['system_pic_base_url']}/${arguments['avatar_option'][index]['path']}', width: Screen.width(125), height: Screen.width(125),)),
                        onTap: () {
                         setState(() {
                           currentIndex = index;
                         });
                        },
                      ),
                      Positioned(
                        right: Screen.width(0),
                        top: Screen.width(0),
                        child: Offstage(
                          offstage: currentIndex != index,
                          child: Icon(Icons.check_circle, size: Screen.width(45), color: Colors.green,),
                        ),
                      ),
                    ],
                  );
                },
              ),
              SizedBox(height: Screen.width(50),),
              ButtonComponent.material(title: '确认选择', width: .92, pressed: () {
                if(currentIndex != -1) {
                  Navigator.pop(context, '${arguments['avatar_option'][currentIndex]['path']}');
                  Storage.getString('userDetail').then((response) {
                    if(response != null) {
                      var data = json.decode(response);
                      data['user_icon'] = '${arguments['avatar_option'][currentIndex]['path']}';
                      Storage.setString('userDetail', json.encode(data));
                    }
                  });
                  DialogComponents.toast(context, content: '设置成功 !');

                } else {
                  DialogComponents.toast(context, content: '请选择头像 !');
                }

              },),
            ],
          ),
        )
    );
  }
}