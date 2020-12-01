import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xw/api/api.dart';

import '../../../../services/utils.dart';
import '../../../../services/state.dart';
import '../../../component/component.dart';


class ActivityContentPages extends StatefulWidget{
  var sign;
  ActivityContentPages({this.sign});
  createState() => _ActivityContentPages({sign: this.sign});
}

class _ActivityContentPages extends State {
  var sign;
  _ActivityContentPages(this.sign);

  var list = [];

  @override
  initState() {
    super.initState();
    print(sign);
    if(sign['newest'] != null) {
      _getData();
    } else if (sign['all'] != null) {
    } else if (sign['history'] != null) {

    }
  }
  Widget build(BuildContext context) {
    Screen.init(context);
    // TODO: implement build
    return Container(
      padding: EdgeInsets.only(bottom: Screen.width(20)),
      child: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: Container(
                margin: EdgeInsets.only(left: Screen.width(20), right: Screen.width(20), top: Screen.width(20)),
                child: Column(
                  children: <Widget>[
                    Image.asset('images/home/banner_01.jpg', fit: BoxFit.fill),
                    ListTitleComponent(
                        height: 85,
                        title: Text('123', style: TextStyle(fontSize: Screen.width(28),))
                    )
                  ],
                ),
              ),
              onTap: () {
                Navigator.pushNamed(context, '/details', arguments: {
                  'title': '活动详情',
                  'contentTitle': Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only( top: Screen.width(15)),
                    child: Text('标题', style: TextStyle(fontSize: Screen.width(30)),),
                  ),
                  'time': Container(
                    alignment: Alignment.bottomRight,
                    margin: EdgeInsets.only(top: Screen.width(30), right: Screen.width(30)),
                    child: Text('2020-01-01 15:00:00', style: TextStyle(fontSize: Screen.width(28)),),
                  ),
                  'content': '英雄联盟英雄联盟英雄联盟英雄联盟'
                });
              },
            );
          }
      ),
    );
  }

  _getData() {
    // Api.getLists().then((response) {
    //   if(response['success']) {
    //     print(response['data']);
    //     setState(() {
    //       list = response['data'];
    //     });
    //   }
    // });
  }
}