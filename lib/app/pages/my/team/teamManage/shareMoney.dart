import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../services/utils.dart';
import '../../../../../api/api.dart';
import '../../../../component/component.dart';
import '../../../../component/dialog.dart';

class ShareMoneyPages extends StatefulWidget{
  var arguments;
  ShareMoneyPages({this.arguments});
  createState() => _ShareMoneyPages(this.arguments);
}

class _ShareMoneyPages extends State {
  var arguments;

  var shareMoney = TextEditingController();
  var shareData = {};


  _ShareMoneyPages(this.arguments);
  @override
  initState() {
    super.initState();
    print(arguments);

    _init();
  }
  _init() async{
    shareMoney.text = '0';
    // var data = {
    //   'hash_id': arguments['hash_id']
    // };
    // var response = await Api.childsDividend(data);
    // if(response['success']) {
    //   setState(() {
    //     shareData = response['data'];
    //   });
    // }
  }
  Widget build(BuildContext context) {
    Screen.init(context);
    // TODO: implement build
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {FocusScope.of(context).requestFocus(FocusNode());},
      child: Scaffold(
          appBar: HeadersComponent.Appbars(Text('分红设置', style: TextStyle(fontSize: Screen.width(32)),)),
          body: Container(
            width: double.infinity,
            color: ColorGather.colorBg(),
            child: ListView(
              children: <Widget>[
                SizedBox(height: Screen.width(60),),
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                      style: TextStyle(fontSize: Screen.width(32), color: Colors.black87),
                      children: [
                        TextSpan(text: '上级用户名: '),
                        TextSpan(text: 'test1999', style: TextStyle(color: ColorGather.colorMain())),
                        TextSpan(text: '  上级分红比例: '),
                        TextSpan(text: '1%', style: TextStyle(color: ColorGather.colorMain())),
                      ]
                  ),
                ),
                SizedBox(height: Screen.width(20),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('分红比例:  ', style: TextStyle(fontSize: Screen.width(27)),),

                    Container(
                      width: Screen.width(200),
                      height: Screen.width(70),
                      child: TextField(
                        controller: shareMoney,
                        scrollPadding: EdgeInsets.all(0),
                        style: TextStyle(fontSize: Screen.width(27), height: Screen.width(2.5)),
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(3)
                        ],
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.only(top: 0, bottom: 0, right: 0, left: Screen.width(10)),
                          border: OutlineInputBorder(
                              borderSide: BorderSide(width: Screen.width(1), color: Colors.grey),
                              borderRadius: BorderRadius.circular(Screen.width(8))
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                        ),
                      ),
                    ),

                    Text(' %', style: TextStyle(fontSize: Screen.width(32)),),
                  ],
                ),
                SizedBox(height: Screen.width(10),),
                Text('最小:  1 % - 最大: 5} %', style: TextStyle(fontSize: Screen.width(27), color: Colors.grey), textAlign: TextAlign.center,),
                SizedBox(height: Screen.width(40),),

                ButtonComponent.material(title: '确认', width: .6, pressed: () async{
                  if(arguments['bonus_percentage'] is String && arguments['bonus_percentage'].indexOf('.') != -1) {
                    arguments['bonus_percentage'] = arguments['bonus_percentage'].substring(0, arguments['bonus_percentage'].indexOf('.'));
                  }
                  if(arguments['bonus_percentage'] is String) {
                    arguments['bonus_percentage'] = int.parse(arguments['bonus_percentage']);
                  }
                  if(int.parse(shareMoney.text) < arguments['bonus_percentage']) {
                    DialogComponents.toast(context, content: '不能低于最小值');
                    return;
                  }
                  // var data = {
                  //   'id': arguments['hash_id'],
                  //   'rate': int.parse(shareMoney.text)
                  // };
                  // var response = await Api.bonusSet(data);
                  // if(response['success']) {
                  //   DialogComponents.toast(context, content: response['msg']);
                  //   Navigator.pop(context);
                  // }
                },),
              ],
            ),
          )
      ),
    );
  }
}