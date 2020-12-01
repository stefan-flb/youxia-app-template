import 'package:flutter/material.dart';
import '../../../../services/utils.dart';
import '../../../component/component.dart';

class OrderTypePages extends StatefulWidget{
  createState() => _OrderTypePages();
}

class _OrderTypePages extends State {
  @override
  initState() {
    super.initState();
  }
  Widget build(BuildContext context) {
    Screen.init(context);
    // TODO: implement build
    return Scaffold(
        appBar: HeadersComponent.Appbars(Text('订单记录', style: TextStyle(fontSize: Screen.width(32)),)),
        body: Container(
          width: double.infinity,
          color: ColorGather.colorBg(),
          child: ListView(
            children: <Widget>[
              ListTitleComponent(
                leading: Image.asset('images/myWallet/transformation.png', width: Screen.width(55)),
                title: Text('游戏tz', style: TextStyle(fontSize: Screen.width(30))),
                onTap: () {Navigator.pushNamed(context, '/orderRecord');},
              ),
              Divider(height: 0,),
              ListTitleComponent(
                leading: Image.asset('images/myWallet/transformation.png', width: Screen.width(55)),
                title: Text('游戏zh', style: TextStyle(fontSize: Screen.width(30))),
                onTap: () {Navigator.pushNamed(context, '/tracesRecord');},
              ),

              SizedBox(width: 0, height: Screen.width(25),),
              ListTitleComponent(
                leading: Image.asset('images/myWallet/transformation.png', width: Screen.width(55)),
                title: Text('qp', style: TextStyle(fontSize: Screen.width(30))),
                onTap: () {Navigator.pushNamed(context, '/orderRecord');},
              ),
              Divider(height: 0,),
              ListTitleComponent(
                leading: Image.asset('images/myWallet/transformation.png', width: Screen.width(55)),
                title: Text('dz', style: TextStyle(fontSize: Screen.width(30))),
                onTap: () {Navigator.pushNamed(context, '/orderRecord');},
              ),
              Divider(height: 0,),
              ListTitleComponent(
                leading: Image.asset('images/myWallet/transformation.png', width: Screen.width(55)),
                title: Text('zr', style: TextStyle(fontSize: Screen.width(30))),
                onTap: () {Navigator.pushNamed(context, '/orderRecord');},
              ),
              Divider(height: 0,),
              ListTitleComponent(
                leading: Image.asset('images/myWallet/transformation.png', width: Screen.width(55)),
                title: Text('by', style: TextStyle(fontSize: Screen.width(30))),
                onTap: () {Navigator.pushNamed(context, '/orderRecord');},
              ),
            ],
          ),
        )
    );
  }
}