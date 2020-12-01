import 'package:flutter/material.dart';
import '../../../../../services/utils.dart';
import '../../../../component/component.dart';

class TeamDetailsPages extends StatefulWidget{
  var arguments;
  TeamDetailsPages({this.arguments});
  createState() => _TeamDetailsPages(this.arguments);
}

class _TeamDetailsPages extends State {
  var arguments;
  _TeamDetailsPages(this.arguments);
  @override
  initState() {
    super.initState();
    print(arguments);
  }
  Widget build(BuildContext context) {
    Screen.init(context);
    // TODO: implement build
    return Scaffold(
        appBar: HeadersComponent.Appbars(Text('会员详情', style: TextStyle(fontSize: Screen.width(32)),)),
        body: Container(
          width: double.infinity,
          color: ColorGather.colorBg(),
          child: ListView(
            children: <Widget>[
              SizedBox(height: Screen.width(20),),
              ListTitleComponent(
                title: Text('账号', style: TextStyle(fontSize: Screen.width(28))),
                trailing: Text('1', style: TextStyle(fontSize: Screen.width(28))),
              ),
              Divider(height: 0,),
              ListTitleComponent(
                title: Text('直属(人数)', style: TextStyle(fontSize: Screen.width(28))),
                trailing: Text('1', style: TextStyle(fontSize: Screen.width(28))),
              ),
              Divider(height: 0,),
              ListTitleComponent(
                title: Text('团队(人数)', style: TextStyle(fontSize: Screen.width(28))),
                trailing: Text('1', style: TextStyle(fontSize: Screen.width(28))),
              ),
              Divider(height: 0,),
              ListTitleComponent(
                title: Text('直属购买', style: TextStyle(fontSize: Screen.width(28))),
                trailing: Text('1', style: TextStyle(fontSize: Screen.width(28))),
              ),
              Divider(height: 0,),
              ListTitleComponent(
                title: Text('团队购买', style: TextStyle(fontSize: Screen.width(28))),
                trailing: Text('1', style: TextStyle(fontSize: Screen.width(28))),
              ),
              Divider(height: 0,),
              ListTitleComponent(
                title: Text('返点率(%)', style: TextStyle(fontSize: Screen.width(28))),
                trailing: Text('1', style: TextStyle(fontSize: Screen.width(28))),
              ),
              Divider(height: 0,),
              ListTitleComponent(
                title: Text('团队中奖', style: TextStyle(fontSize: Screen.width(28))),
                trailing: Text('1', style: TextStyle(fontSize: Screen.width(28))),
              ),
              Divider(height: 0,),
              ListTitleComponent(
                title: Text('盈利总额', style: TextStyle(fontSize: Screen.width(28))),
                trailing: Text('1', style: TextStyle(fontSize: Screen.width(28))),
              ),
              Divider(height: 0,),
              ListTitleComponent(
                title: Text('团队总充值', style: TextStyle(fontSize: Screen.width(28))),
                trailing: Text('1', style: TextStyle(fontSize: Screen.width(28))),
              ),
              Divider(height: 0,),
              ListTitleComponent(
                title: Text('团队总提款', style: TextStyle(fontSize: Screen.width(28))),
                trailing: Text('1', style: TextStyle(fontSize: Screen.width(28))),
              ),
              Divider(height: 0,),
              ListTitleComponent(
                title: Text('团队总返水', style: TextStyle(fontSize: Screen.width(28))),
                trailing: Text('1', style: TextStyle(fontSize: Screen.width(28))),
              ),
              Divider(height: 0,),
              ListTitleComponent(
                title: Text('最后登陆IP', style: TextStyle(fontSize: Screen.width(28))),
                trailing: Text('1', style: TextStyle(fontSize: Screen.width(28))),
              ),

              SizedBox(height: Screen.width(20),),
              ButtonComponent.material(title: '确定', pressed: () {Navigator.pop(context);},),
              SizedBox(height: Screen.width(60),),
            ],
          ),
        )
    );
  }
}