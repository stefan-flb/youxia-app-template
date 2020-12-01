import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../services/utils.dart';
import '../../../../../api/api.dart';
import '../../../../component/component.dart';
import '../../../../component/dialog.dart';

class DailyWagesPages extends StatefulWidget{
  var arguments;
  DailyWagesPages({this.arguments});
  createState() => _DailyWagesPages(this.arguments);
}

class _DailyWagesPages extends State {
  var arguments;

  var dailyWage = TextEditingController();
  var dailyWageData = {
    'father_name': '',
    'father_salary': ''
  };


  _DailyWagesPages(this.arguments);
  @override
  initState() {
    super.initState();
    print(arguments);

    _init();
  }
  _init() async{
    dailyWage.text = '0';
    // var data = {
    //   'hash_id': arguments['hash_id']
    // };
    // var response = await Api.childsDividend(data);
    // if(response['success']) {
    //   setState(() {
    //     dailyWageData = response['data'];
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
          appBar: HeadersComponent.Appbars(Text('日工资设置', style: TextStyle(fontSize: Screen.width(32)),)),
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
                        TextSpan(text: '${dailyWageData["father_name"] ?? ''}', style: TextStyle(color: ColorGather.colorMain())),
                        TextSpan(text: '  上级日工资比例: '),
                        TextSpan(text: '${dailyWageData["father_salary"] ?? ''}%', style: TextStyle(color: ColorGather.colorMain())),
                      ]
                  ),
                ),
                SizedBox(height: Screen.width(20),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('日工资比例:  ', style: TextStyle(fontSize: Screen.width(27)),),

                    Container(
                      width: Screen.width(200),
                      height: Screen.width(70),
                      child: TextField(
                        controller: dailyWage,
                        scrollPadding: EdgeInsets.all(0),
                        style: TextStyle(fontSize: Screen.width(27), height: Screen.width(2.5)),
                        inputFormatters: [
                          WhitelistingTextInputFormatter(RegExp('[0-9.]')),
                          LengthLimitingTextInputFormatter(9)
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
                Text('最小:  ${arguments['salary_percentage']} % - 最大: ${dailyWageData["father_salary"] ?? ''} %', style: TextStyle(fontSize: Screen.width(27), color: Colors.grey), textAlign: TextAlign.center,),
                SizedBox(height: Screen.width(40),),

                ButtonComponent.material(title: '确认', width: .6, pressed: () async{
//                  if(arguments['salary_percentage'] is String && arguments['salary_percentage'].indexOf('.') != -1) {
//                    arguments['salary_percentage'] = arguments['salary_percentage'].substring(0, arguments['salary_percentage'].indexOf('.'));
//                  }
//                  if(arguments['salary_percentage'] is String) {
//                    arguments['salary_percentage'] = int.parse(arguments['salary_percentage']);
//                  }
//                  if(int.parse(dailyWage.text) < arguments['salary_percentage']) {
//                    DialogComponents.toast(context, content: '不能低于最小值');
//                    return;
//                  }
//                   var data = {
//                     'id': arguments['hash_id'],
//                     'rate': dailyWage.text
//                   };
//                   var response = await Api.salarySet(data);
//                   print(response);
//                   if(response['success']) {
//                     DialogComponents.toast(context, content: response['msg']);
//                     Navigator.pop(context);
//                   }
                },),
              ],
            ),
          )
      ),
    );
  }
}