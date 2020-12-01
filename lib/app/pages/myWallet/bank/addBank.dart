import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:xw/api/api.dart';

import '../../../../services/utils.dart';
import '../../../component/picker.dart';
import '../../../component/component.dart';
import '../../../component/dialog.dart';



class AddBankPages extends StatefulWidget{
  var arguments;
  AddBankPages({Key key, this.arguments});
  _AddBankPages createState() => _AddBankPages(this.arguments);
}

class _AddBankPages extends State {
  // 开户城市列表
  var cityData = [];
  // 开户银行
  var openBank = '请选择开户银行';
  var openBankIndex = 0;
  // 开户省份
  var openProvinces = '请选择开户省份';
  var openProvincesIndex = 0;
  // 开户城市
  var openCity = '请选择开户城市';
  var openCityIndex = 0;
  // 支行名称
  var bankName = TextEditingController();
  // 开户姓名
  var userName = TextEditingController();
  // 银行账号
  var bankNumber = TextEditingController();
  // 确认银行账号
  var configBankNumber = TextEditingController();

  var arguments;
  _AddBankPages(this.arguments);
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
            appBar: HeadersComponent.Appbars(Text('添加银行卡', style: TextStyle(fontSize: Screen.width(32)),)),
            body: Container(
              alignment: Alignment.centerLeft,
              width: double.infinity,
              color: ColorGather.colorBg(),
              child: ListView(
                children: <Widget>[
                  ListTitleComponent(
                    trailingShow: false,
                    leading: Text('开户银行:', style: TextStyle(fontSize: Screen.width(28))),
                    title: Row(
                      children: <Widget>[
                        Text('${openBank}', style: TextStyle(fontSize: Screen.width(28))),
                        SizedBox(width: Screen.width(20),),
                        Icon(Icons.keyboard_arrow_down, size: Screen.width(50), color: Colors.grey,)
                      ],
                    ),
                    onTap: () {
                      var list = [arguments['bank_list'].map((val) {
                        return val['title'];
                      }).toList()];
                      PickerTool.showArrayPicker(context,
                          data: list, normalIndex: [0],
                          clickCallBack:(index, strData){
                            print(index); print(strData);
                           setState(() {
                             openBankIndex = index[0];
                             openBank = '${strData[0]}';
                           });
                          }
                      );
                    },
                  ),
                  Divider(height: 0,),
                  ListTitleComponent(
                    trailingShow: false,
                    leading: Text('开户省份:', style: TextStyle(fontSize: Screen.width(28))),
                    title: Row(
                      children: <Widget>[
                        Text('${openProvinces}', style: TextStyle(fontSize: Screen.width(28))),
                        SizedBox(width: Screen.width(20),),
                        Icon(Icons.keyboard_arrow_down, size: Screen.width(50), color: Colors.grey,)
                      ],
                    ),
                    onTap: () async{
                      var list = [arguments['province'].map((val) {
                        return val['region_name'];
                      }).toList()];
                      PickerTool.showArrayPicker(context,
                          data: list, normalIndex: [0],
                          clickCallBack:(index, strData) async{
                            print(index); print(strData);
                            setState(() {
                              openProvincesIndex = index[0];
                              openProvinces = '${strData[0]}';
                              openCity = '请选择开户城市';
                            });

                            // var data = {
                            //   'region_id': arguments['province'][openProvincesIndex]['region_id']
                            // };
                            // var response = await Api.getCityList(data);
                            // print(response['data']);
                            // if(response['success']) {
                            //   setState(() {
                            //     cityData = response['data'];
                            //   });
                            // }
                          }
                      );
                    },
                  ),
                  Divider(height: 0,),
                  ListTitleComponent(
                    trailingShow: false,
                    leading: Text('开户城市:', style: TextStyle(fontSize: Screen.width(28))),
                    title: Row(
                      children: <Widget>[
                        Text('${openCity}', style: TextStyle(fontSize: Screen.width(28))),
                        SizedBox(width: Screen.width(20),),
                        Icon(Icons.keyboard_arrow_down, size: Screen.width(50), color: Colors.grey,)
                      ],
                    ),
                    onTap: () {
                      var list = [cityData.map((val) {
                        return val['region_name'];
                      }).toList()];
                      PickerTool.showArrayPicker(context,
                          data: list, normalIndex: [0],
                          clickCallBack:(index, strData){
                            print(index); print(strData);
                            setState(() {
                              openCityIndex = index[0];
                              openCity = '${strData[0]}';
                            });
                          }
                      );
                    },
                  ),
                  SizedBox(height: Screen.width(20),),
                  InputComponent.text(
                      labelText: '支行名称:', hintText: '1至20个字符或汉字', controller: bankName, labelColor: Colors.black,
                      inputFormatters: [
                        WhitelistingTextInputFormatter(RegExp(r"[\u4e00-\u9fa5]")),
                        LengthLimitingTextInputFormatter(20)
                      ]),
                  Divider(height: 0,),
                  InputComponent.text(
                      labelText: '开户姓名:', hintText: '1至20个字符或汉字', controller: userName, labelColor: Colors.black,
                      inputFormatters: [
                        WhitelistingTextInputFormatter(RegExp(r"[\u4e00-\u9fa5]")),
                        LengthLimitingTextInputFormatter(20)
                      ]),
                  SizedBox(height: Screen.width(20),),
                  InputComponent.text(
                      labelText: '银行账号:', hintText: '卡号由16位或19位数字组成', controller: bankNumber, labelColor: Colors.black,
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(19)
                      ]),
                  Divider(height: 0,),
                  InputComponent.text(
                      labelText: '确认账号:', hintText: '卡号由16位或19位数字组成', controller: configBankNumber, labelColor: Colors.black,
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(19)
                      ]),
                  SizedBox(height: Screen.width(30),),
                  ButtonComponent.material(title: '确认添加', pressed: () async{
                    if(openBank == '') {
                      DialogComponents.toast(context, content: '请填写开户银行');
                      return;
                    } else if(openProvinces == '') {
                      DialogComponents.toast(context, content: '请填写开户省份');
                      return;
                    } else if(openCity == '') {
                      DialogComponents.toast(context, content: '请填写开户城市');
                      return;
                    } else if(bankName.text == '') {
                      DialogComponents.toast(context, content: '请填写支行名称');
                      return;
                    } else if(bankName.text.length < 4) {
                      DialogComponents.toast(context, content: '支行名称最小四位');
                      return;
                    } else if(userName.text == '') {
                      DialogComponents.toast(context, content: '请填写开户姓名');
                      return;
                    } else if(userName.text.length < 3) {
                      DialogComponents.toast(context, content: '开户姓名最少两位');
                      return;
                    } else if(bankNumber.text == '' || configBankNumber.text == '') {
                      DialogComponents.toast(context, content: '请填写银行账号');
                      return;
                    } else if(bankNumber.text != configBankNumber.text) {
                      DialogComponents.toast(context, content: '两次填写的银行账号不一致');
                      return;
                    } else if(bankNumber.text.length != 16 && bankNumber.text.length != 19) {
                      DialogComponents.toast(context, content: '请正确的16位或19位卡号');
                      return;
                    }
                    var data = {
                      'bank_name': openBank,
                      'bank_sign': arguments['bank_list'][openBankIndex]['code'],
                      'branch': bankName.text,
                      'card_number': bankNumber.text,
                      'owner_name': userName.text,
                      'city_id': cityData[openCityIndex]['region_id'],
                      'province_id': arguments['province'][openProvincesIndex]['region_id'],
                    };

                    // var response = await Api.bindBankCard(data);
                    // if (response['success']) {
                    //   DialogComponents.toast(context, content: response['msg']);
                    //   Navigator.pop(context);
                    // }
                  },),
                ],
              ),
            )
        )
    );
  }
}