import 'package:flutter/cupertino.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../../services/utils.dart';
import '../../../../../api/api.dart';
import '../../../../component/component.dart';
import '../../../../component/dialog.dart';

class OpenAccountPages extends StatefulWidget{
  createState() => _OpenAccountPages();
}

class _OpenAccountPages extends State with SingleTickerProviderStateMixin {
  var tabController;
  // 账号开户
  var openUser = TextEditingController();
  var openType = 2;
  var openPassword = TextEditingController();
  var openPrize= TextEditingController();

  // 链接开户
  var validityTimeList = [];
  var linkList = [];
  var validityTime = 0;
  var channel = TextEditingController();
  @override
  initState() {
    super.initState();
    _getLinkData();
    tabController = TabController(length: 2, vsync: this, initialIndex: 0);
    tabController.addListener(() {
      openType = 2; validityTime = 0;
      openPrize.text = openUser.text = openPassword.text = openPrize.text = channel.text = '';
    });
  }
  dispose() {
    super.dispose();
    tabController.dispose();
  }
  // 获取链接数据
  _getLinkData() async{
    // var response = await Api.inviteLinkList();
    // if(response['success']) {
    //   var data = response['data']['links']['data'];
    //   for(var i = 0; i < data.length; i++) {
    //     data[i]['flag'] = false;
    //   }
    //   setState(() {
    //     linkList = data;
    //     validityTimeList = response['data']['expire_option'];
    //   });
    // }
  }
  Widget build(BuildContext context) {
    Screen.init(context);
    // TODO: implement build
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {FocusScope.of(context).requestFocus(FocusNode());},
        child: Scaffold(
            appBar: HeadersComponent.Appbars(Text('下级开户', style: TextStyle(fontSize: Screen.width(32)))),
            body: Container(
                width: double.infinity,
                color: ColorGather.colorBg(),
                child: Column(
                  children: <Widget>[
                    Container(
                      color: Colors.white,
                      height: Screen.width(80),
                      child: TabBar(
                        labelPadding: EdgeInsets.all(0),
                        controller: tabController,
                        indicatorColor: ColorGather.colorMain(),
                        tabs: <Widget>[
                          Tab(child: Text('账号开户', style: TextStyle(fontSize: Screen.width(28,), color: Colors.black))),
                          Tab(child: Text('链接开户', style: TextStyle(fontSize: Screen.width(28,), color: Colors.black)))
                        ],
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: tabController,
                        children: <Widget>[
                          ListView(
                            children: <Widget>[
                              SizedBox(height: Screen.width(20),),
                              InputComponent.text(
                                  hintText: '开户账号', labelText: '开户账号', obscureText: false, controller: openUser,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(18)
                                  ]),
                              Divider(height: 0,),
                              InputComponent.text(
                                  hintText: '开户密码', labelText: '开户密码', obscureText: true, controller: openPassword,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(18)
                                  ]),
                              SizedBox(height: Screen.width(20),),
                              InputComponent.text(
                                  hintText: '奖金组', labelText: '奖金组', controller: openPrize,
                                  inputFormatters: [
                                    WhitelistingTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(18)
                                  ]),
                              Divider(height: 0,),
                              ListTitleComponent(
                                title: Row(
                                  children: <Widget>[
                                    Text('用户组', style: TextStyle(fontSize: Screen.width(28), color: Colors.grey)),
                                    SizedBox(width: Screen.width(50),),
                                    Row(
                                      children: <Widget>[
                                        Text('${openType == 2 ? '代理' : '会员'}', style: TextStyle(fontSize: Screen.width(28), color: Colors.black)),
                                        Icon(Icons.keyboard_arrow_down, size: Screen.width(45),)
                                      ],
                                    )
                                  ],
                                ),
                                trailingShow: false,
                                onTap: () {
                                  DialogComponents.customSheetIos(
                                      context,
                                      content: Column(
                                        children: <Widget>[
                                          GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: double.infinity, height: Screen.width(95),
                                              child: Text('代理', style: TextStyle(fontSize: Screen.width(30), decoration: TextDecoration.none, fontWeight: FontWeight.normal, color: Colors.black87)),
                                            ),
                                            onTap: () {
                                              setState(() {openType = 2; Navigator.pop(context);});
                                            },
                                          ),
                                          Divider(height: 0,),     GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: double.infinity, height: Screen.width(95),
                                              child: Text('会员', style: TextStyle(fontSize: Screen.width(30), decoration: TextDecoration.none, fontWeight: FontWeight.normal, color: Colors.black87)),
                                            ),
                                            onTap: () {
                                              setState(() {openType = 1; Navigator.pop(context);});
                                            },
                                          ),
                                        ],
                                      )
                                  );
                                },
                              ),
                              SizedBox(height: Screen.width(20),),
                              ButtonComponent.material(title: '确认开户', pressed: () async{
                                if(openPassword.text.isEmpty) {
                                  DialogComponents.toast(context, content: '请填写正确的开户账号');
                                  return;
                                } else if(openPassword.text.isEmpty || openPassword.text.length < 7) {
                                  DialogComponents.toast(context, content: '请填写正确的开户密码');
                                  return;
                                } else if(openPrize.text.isEmpty) {
                                  DialogComponents.toast(context, content: '请填写正确的奖金组');
                                  return;
                                } else if(int.parse(openPrize.text) < 1800) {
                                  DialogComponents.toast(context, content: '奖金组不能小于1800');
                                  return;
                                }
                                var data = {
                                  'password': Utils.password(openPassword.text),
                                  'prize_group': openPrize.text,
                                  'register_type': 1,
                                  'user_type': openType,
                                  'username': openUser.text
                                };
                                // var response = await Api.addChild(data);
                                // print(response);
                                // if(response['success']) {
                                //   DialogComponents.toast(context, content: response['msg']);
                                //   setState(() {
                                //     openPrize.text = openUser.text = openPassword.text = '';
                                //     openType = 2;
                                //   });
                                // }
                              },),
                            ],
                          ),

                          ListView(
                            children: <Widget>[
                              SizedBox(height: Screen.width(20),),
                              ListTitleComponent(
                                title: Row(
                                  children: <Widget>[
                                    Text('有效期', style: TextStyle(fontSize: Screen.width(28), color: Colors.grey)),
                                    SizedBox(width: Screen.width(50),),
                                    Row(
                                      children: <Widget>[
                                        Text('${validityTime == 0 ? "永久有效" : validityTime.toString() + "天" }', style: TextStyle(fontSize: Screen.width(28), color: Colors.black)),
                                        Icon(Icons.keyboard_arrow_down, size: Screen.width(45),)
                                      ],
                                    )
                                  ],
                                ),
                                trailingShow: false,
                                onTap: () {
                                  DialogComponents.customSheetIos(
                                      context,
                                      content: Column(
                                        children: <Widget>[
                                          Column(
                                            children: <Widget>[],
                                          ),
                                          GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: double.infinity, height: Screen.width(95),
                                              child: Text('永久有效', style: TextStyle(fontSize: Screen.width(30), decoration: TextDecoration.none, fontWeight: FontWeight.normal, color: Colors.black)),
                                            ),
                                            onTap: () {
                                              setState(() {validityTime = 0; Navigator.pop(context);});
                                            },
                                          ),
                                          Divider(height: 0,),
                                          GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: double.infinity, height: Screen.width(95),
                                              child: Text('7天', style: TextStyle(fontSize: Screen.width(30), decoration: TextDecoration.none, fontWeight: FontWeight.normal, color: Colors.black)),
                                            ),
                                            onTap: () {
                                              setState(() {validityTime = 7; Navigator.pop(context);});
                                            },
                                          ),
                                          Divider(height: 0,),
                                          GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: double.infinity, height: Screen.width(95),
                                              child: Text('30天', style: TextStyle(fontSize: Screen.width(30), decoration: TextDecoration.none, fontWeight: FontWeight.normal, color: Colors.black)),
                                            ),
                                            onTap: () {
                                              setState(() {validityTime = 30; Navigator.pop(context);});
                                            },
                                          ),
                                          Divider(height: 0,),
                                          GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: double.infinity, height: Screen.width(95),
                                              child: Text('90天', style: TextStyle(fontSize: Screen.width(30), decoration: TextDecoration.none, fontWeight: FontWeight.normal, color: Colors.black)),
                                            ),
                                            onTap: () {
                                              setState(() {validityTime = 90; Navigator.pop(context);});
                                            },
                                          ),
                                        ],
                                      )
                                  );
                                },
                              ),
                              Divider(height: 0,),
                              InputComponent.text(
                                  hintText: '例如 QQ推广渠道', labelText: '来   源', controller: channel,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(18)
                                  ]),
                              Divider(height: 0,),
                              InputComponent.text(
                                  hintText: '奖金组', labelText: '奖金组', controller: openPrize,
                                  inputFormatters: [
                                    WhitelistingTextInputFormatter.digitsOnly,
                                    LengthLimitingTextInputFormatter(18)
                                  ]),
                              Divider(height: 0,),
                              ListTitleComponent(
                                title: Row(
                                  children: <Widget>[
                                    Text('用户组', style: TextStyle(fontSize: Screen.width(28), color: Colors.grey)),
                                    SizedBox(width: Screen.width(50),),
                                    Row(
                                      children: <Widget>[
                                        Text('${openType == 2 ? '代理' : '会员'}', style: TextStyle(fontSize: Screen.width(28), color: Colors.black)),
                                        Icon(Icons.keyboard_arrow_down, size: Screen.width(45),)
                                      ],
                                    )
                                  ],
                                ),
                                trailingShow: false,
                                onTap: () {
                                  DialogComponents.customSheetIos(
                                      context,
                                      content: Column(
                                        children: <Widget>[
                                          GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: double.infinity, height: Screen.width(95),
                                              child: Text('代理', style: TextStyle(fontSize: Screen.width(30), decoration: TextDecoration.none, fontWeight: FontWeight.normal, color: Colors.black87)),
                                            ),
                                            onTap: () {
                                              setState(() {openType = 2; Navigator.pop(context);});
                                            },
                                          ),
                                          Divider(height: 0,),     GestureDetector(
                                            behavior: HitTestBehavior.opaque,
                                            child: Container(
                                              alignment: Alignment.center,
                                              width: double.infinity, height: Screen.width(95),
                                              child: Text('会员', style: TextStyle(fontSize: Screen.width(30), decoration: TextDecoration.none, fontWeight: FontWeight.normal, color: Colors.black87)),
                                            ),
                                            onTap: () {
                                              setState(() {openType = 0; Navigator.pop(context);});
                                            },
                                          ),
                                        ],
                                      )
                                  );
                                },
                              ),

                              SizedBox(height: Screen.width(20),),
                              ButtonComponent.material(title: '确认开户', pressed: () async{
                                if(channel.text.isEmpty) {
                                  DialogComponents.toast(context, content: '请填写来源');
                                  return;
                                } else if(openPrize.text.isEmpty) {
                                  DialogComponents.toast(context, content: '请填写正确的奖金组');
                                  return;
                                } else if(int.parse(openPrize.text) < 1800) {
                                  DialogComponents.toast(context, content: '奖金组不能小于1800');
                                  return;
                                }
                                // var data = {
                                //   'channel': channel.text,
                                //   'prize_group': openPrize.text,
                                //   'expire': validityTime,
                                //   'user_type': openType,
                                // };
                                // var response = await Api.addInviteLink(data);
                                // print(response);
                                // if(response['success']) {
                                //   _getLinkData();
                                //   DialogComponents.toast(context, content: response['msg']);
                                //   setState(() {
                                //     openPrize.text = channel.text = '';
                                //     openType = 2; validityTime = 0;
                                //   });
                                // }
                              },),
                              SizedBox(height: Screen.width(40),),
                              // 数据标题
                              Container(
                                padding: EdgeInsets.only(top: Screen.width(20), bottom: Screen.width(16)),
                                color: Colors.white,
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                      child: Text('渠道', style: TextStyle(fontSize: Screen.width(28)),),
                                      width: Screen.weightWidth(context) / 5,
                                      alignment: Alignment.center,
                                    ),
                                    Container(
                                      child: Text('类型', style: TextStyle(fontSize: Screen.width(28)),),
                                      width: Screen.weightWidth(context) / 6.7,
                                      alignment: Alignment.center,
                                    ),
                                    Container(
                                      child: Text('注册数', style: TextStyle(fontSize: Screen.width(28)),),
                                      width: Screen.weightWidth(context) / 6.7,
                                      alignment: Alignment.center,
                                    ),
                                    Container(
                                      child: Text('链接', style: TextStyle(fontSize: Screen.width(28)),),
                                      width: Screen.weightWidth(context) / 6.7,
                                      alignment: Alignment.center,
                                    ),
                                    Container(
                                      child: Text('操作', style: TextStyle(fontSize: Screen.width(28)),),
                                      width: Screen.weightWidth(context) / 2.856,
                                      alignment: Alignment.center,
                                    ),
                                  ],
                                ),
                              ),
                              linkList.length > 0 ? Container(
                                color: Colors.white,
                                child:  ListView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: linkList.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: <Widget>[
                                        Container(
                                           height: Screen.width(75),
                                           color: Colors.white,
                                           child: Row(
                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                             children: <Widget>[
                                               Container(
                                                 child: Text('${linkList[index]["channel"]}', style: TextStyle(fontSize: Screen.width(28))),
                                                 width: Screen.weightWidth(context) / 5,
                                                 alignment: Alignment.center,
                                               ),
                                               Container(
                                                 child: Text('${ linkList[index]["is_agent"] == 0 ? "会员" : "代理"}', style: TextStyle(fontSize: Screen.width(28))),
                                                 width: Screen.weightWidth(context) / 6.7,
                                                 alignment: Alignment.center,
                                               ),
                                               Container(
                                                 child: Text('${linkList[index]["total_register"]}', style: TextStyle(fontSize: Screen.width(28))),
                                                 width: Screen.weightWidth(context) / 6.7,
                                                 alignment: Alignment.center,
                                               ),
                                               GestureDetector(
                                                 behavior: HitTestBehavior.opaque,
                                                 child: Container(
                                                   child: Text('复制', style: TextStyle(fontSize: Screen.width(28), color: ColorGather.colorMain(), decoration: TextDecoration.underline)),
                                                   width: Screen.weightWidth(context) / 6.7,
                                                   alignment: Alignment.center,
                                                 ),
                                                 onTap: () {
                                                   var data = ClipboardData(text: 'http://m.play322.com/register/${linkList[index]["url"]}');
                                                   Clipboard.setData(data);
                                                   DialogComponents.toast(context, content: '复制成功');
                                                 },
                                               ),
                                               Container(
                                                 width: Screen.weightWidth(context) / 2.856,
                                                 child: Row(
                                                   children: <Widget>[
                                                     GestureDetector(
                                                       behavior: HitTestBehavior.opaque,
                                                       child: Text('详情', style: TextStyle(fontSize: Screen.width(28), color: ColorGather.colorMain(), decoration: TextDecoration.underline)),
                                                       onTap: () {
                                                         setState(() {
                                                           linkList[index]['flag'] = !linkList[index]['flag'];
                                                         });
                                                       },
                                                     ),
                                                     GestureDetector(
                                                       behavior: HitTestBehavior.opaque,
                                                       child: Text('删除', style: TextStyle(fontSize: Screen.width(28), color: ColorGather.colorMain(), decoration: TextDecoration.underline)),
                                                       onTap: () async {
                                                         DialogComponents.alertIos(
                                                             context,
                                                             content: [
                                                               Text('确认删除吗', style: TextStyle(fontSize: Screen.width(28))),
                                                             ],
                                                             confirm: () async{
                                                               var data = {
                                                                 'id': linkList[index]['id']
                                                               };
                                                               // var response = await Api.delInviteLink(data);
                                                               // print(response);
                                                               // if(response['success']) {
                                                               //   DialogComponents.toast(context, content: response['msg']);
                                                               //   setState(() {
                                                               //     linkList.removeAt(index);
                                                               //   });
                                                               // }
                                                               Navigator.pop(context, 'confirm');
                                                             });
                                                       },
                                                     ),
                                                   ],
                                                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                 ),
                                               )
                                             ],
                                           ),
                                         ),
                                        Offstage(
                                          offstage: linkList[index]['flag'] == false,
                                          child: Container(
                                            padding: EdgeInsets.only(top: Screen.width(10), bottom: Screen.width(10)),
                                            child: Column(
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: <Widget>[
                                                    Text('有效期', style: TextStyle(fontSize: Screen.width(26))),
                                                    Text('${linkList[index]["expired_at"]}', style: TextStyle(fontSize: Screen.width(26))),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: <Widget>[
                                                    Text('奖金组', style: TextStyle(fontSize: Screen.width(26))),
                                                    Text('${linkList[index]["prize_group"]}', style: TextStyle(fontSize: Screen.width(26))),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: <Widget>[
                                                    Text('生成时间', style: TextStyle(fontSize: Screen.width(26))),
                                                    Text('${linkList[index]["created_at"]}', style: TextStyle(fontSize: Screen.width(26))),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: <Widget>[
                                                    Text('链接', style: TextStyle(fontSize: Screen.width(26))),
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                  children: <Widget>[
                                                    Text('http://m.play322.com/register/${linkList[index]["url"]}', style: TextStyle(fontSize: Screen.width(26))),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            decoration: BoxDecoration(
                                              border: Border(
                                                top: BorderSide(width: Screen.width(1), color: Colors.grey),
                                                bottom: BorderSide(width: Screen.width(1), color: Colors.grey),
                                              )
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ) : Container(
                                padding: EdgeInsets.only(top: Screen.width(30)),
                                child: Text('暂无下级', style: TextStyle(fontSize: Screen.width(28)), textAlign: TextAlign.center,),
                              ),
                              SizedBox(height: Screen.width(20),),
                              Offstage(
                                offstage: linkList.length <= 4,
                                child: GestureDetector(
                                  child: Text('更多开户链接  >>>', style: TextStyle(fontSize: Screen.width(28), color: ColorGather.colorMain()), textAlign: TextAlign.center,),
                                  onTap: () {
                                    Navigator.pushNamed(context, '/linkOpenAccount').then((data) {
                                      _getLinkData();
                                    });
                                  },
                                ),
                              ),
                              SizedBox(height: Screen.width(30),)
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                )
            )
        )
    );
  }
}