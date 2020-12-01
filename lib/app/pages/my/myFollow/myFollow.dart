import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../services/utils.dart';
import '../../../component/component.dart';

class FollowPages extends StatefulWidget{
  FollowPages({Key key});
  _FollowPages createState() => _FollowPages();
}

class _FollowPages extends State {
  var searchVal = TextEditingController();
  @override
  initState() {
    super.initState();
  }
  Widget build(BuildContext context) {
    Screen.init(context);
    // TODO: implement build
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {FocusScope.of(context).requestFocus(FocusNode());},
        child: Scaffold(
          appBar: HeadersComponent.Appbars(Text('我的关注', style: TextStyle(fontSize: Screen.width(32)),)),
          body: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minWidth: 0, minHeight: Screen.weightHeight(context) - Screen.appbarHeight(),),
              child: Container(
                color: ColorGather.colorBg(),
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    Container(
                      height: Screen.width(90),
                      color: Colors.white,
                      alignment: Alignment.center,
                      child: Text('最多可关注100个会员', style: TextStyle(fontSize: Screen.width(28)),),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: Screen.width(25), bottom: Screen.width(25)),
                        padding: EdgeInsets.only(left: Screen.width(25)),
                        width: Screen.weightWidth(context) - Screen.width(60),
                        height: Screen.width(110),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(Screen.width(50))),
                        ),
                        alignment: Alignment.center,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: InputComponent.text(
                                  hintText: '搜索', labelText: '搜索', color: Color.fromRGBO(0, 0, 0, 0), controller: searchVal,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(18)
                                  ]),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: Screen.width(20), right: Screen.width(20)),
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                child: Icon(Icons.search, size: Screen.width(50),),
                                onTap: () {
                                  searchVal.text = '';
                                },
                              ),
                            )
                          ],
                        )
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}