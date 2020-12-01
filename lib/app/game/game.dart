import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../component/component.dart';
import '../component/dialog.dart';
import '../../services/utils.dart';
import '../../services/state.dart';
import '../../services/eventBus.dart';
import 'gameTop/gameTop.dart';
import 'gameBottom/gameBottom.dart';
import 'gameCenter/gameCenter.dart';
import '../../methods/menus.js';


class GamePages extends StatefulWidget{
  @override
  createState() => _GamePages();
}
class _GamePages extends State {
  var states = Provider.of<Providers>(globeBuildContext);
  List menusList;
  var methods = {
    'name': '',
    'name2': '',
    'index': 0,
    'index2': -1,
  };
  var childMethods = {
    'name': '',
    'name2': '',
    'index': 0,
    'index2': -1,
  };
  var grandSonMethods = {
    'name': '',
    'name2': '',
    'index': 0,
    'index2': -1,
  };

  var menusShow = false;
  @override
  initState() {
    super.initState();
    _menus();
  }
  Widget build(BuildContext context) {
    var states = Provider.of<Providers>(context);
    // TODO: implement build
    return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
          setState(() {
            menusShow = false;
            _currentMenus();
          });
        },
        child: Scaffold(
          backgroundColor: ColorGather.colorBg(),
          resizeToAvoidBottomPadding: false,
          appBar: HeadersComponent.Appbars(
            Container(
              height: Screen.width(65),
              child: OutlineButton(
                padding: EdgeInsets.only(left: Screen.width(15), right: Screen.width(15), top: 0, bottom: 0),
                textColor: Colors.white,
                child: Text('${methods['name2']}-${childMethods['name2']}-${grandSonMethods['name2']}', style: TextStyle(fontSize: Screen.width(26)),),
                highlightedBorderColor: Colors.grey,
                borderSide: BorderSide(color: Colors.white),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(Screen.width(8))),
                ),
                onPressed: () {
                  setState(() {
                    menusShow = !menusShow;
                  });
                },
             )
           ),
          ),
          body: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.topLeft,
                child: GameTopPages(),
              ),
              Positioned(
                top: Screen.width(190),
                child: GameCenterPages(),
              ),
              Positioned(
                bottom: 0,
                child: GameBottomPages(),
              ),
              // 游戏菜单
              Offstage(
                offstage: !menusShow,
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    setState(() {
                      menusShow = true;
                    });
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(bottom: Screen.width(20)),
                    decoration: BoxDecoration(
                        color: Colors.white
                    ),
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        SizedBox(height: Screen.width(20),),
                        GridView.builder(
                            itemCount:
                            menusList != null &&
                                menusList.length > 0
                                ?
                            menusList.length : 0,
                            shrinkWrap: true,
                            physics: new NeverScrollableScrollPhysics(),
                            //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              //横轴元素个数
                                crossAxisCount: 4,
                                //纵轴间距
                                mainAxisSpacing: 8.0,
                                //横轴间距
                                crossAxisSpacing: 0.0,
                                //子组件宽高长度比例
                                childAspectRatio: 3),
                            itemBuilder: (BuildContext context, int index) {
                              //Widget Function(BuildContext context, int index)
                              return ButtonComponent.outline(
                                  title: '${menusList[index]['name_cn']}', textColor: methods['index2'] == index ? ColorGather.colorMain() : Colors.black, fontSize: menusList[index]['name_cn'].length > 5 ? 18 : 24, height: 50, width: .9, color: methods['index2'] == index ? ColorGather.colorMain() : Colors.black,
                                  pressed: () {
                                    setState(() {
                                      methods['index'] = index;
                                      methods['index2'] = index;
                                      childMethods['index'] = 0;
                                      childMethods['index2'] = -1;
                                      grandSonMethods['index'] = 0;
                                      grandSonMethods['index2'] = -1;
                                      methods['name'] = menusList[methods['index']]['name_cn'];


                                      if(states.currentGame['methodsName'].isNotEmpty) {
                                        if(methods['name'] == states.currentGame['methodsName']) {
                                          _currentMenus();
                                        }
                                      } else {
                                        if(methods['index'] == 0 && methods['index2'] == 0) {
                                          _currentMenus();
                                        }
                                      }


                                      if(
                                      menusList != null &&
                                          menusList.length > 0 &&
                                          menusList[methods['index']]['children'] != null &&
                                          menusList[methods['index']]['children'].length > 0
                                      ) {
                                        childMethods['name'] = menusList[methods['index']]['children'][0]['name_cn'];
                                      }
                                      if(
                                      menusList != null &&
                                          menusList.length > 0 &&
                                          menusList[methods['index']]['children'] != null &&
                                          menusList[methods['index']]['children'].length > 0 &&
                                          menusList[methods['index']]['children'][0]['children'] != null &&
                                          menusList[methods['index']]['children'][0]['children'].length > 0
                                      ) {
                                        grandSonMethods['name'] = menusList[methods['index']]['children'][0]['children'][0]['name_cn'];
                                      }

                                    });

                                  });
                            }),

                        Offstage(
                          offstage:
                          menusList == null ||
                              menusList.length == 0 ||
                              menusList[methods['index']]['children'] == null ||
                              menusList[methods['index']]['children'].length == 0,
                          child: Container(
                            height: Screen.width(90),
                            child:  Stack(
                              children: <Widget>[
                                Positioned(
                                  top: Screen.width(45),
                                  child: Container(
                                    width: Screen.weightWidth(context),
                                    height: Screen.width(1),
                                    decoration: BoxDecoration(
                                        border: Border.all(width: Screen.width(1), color: ColorGather.colorMain())
                                    ),
                                  ),
                                ),
                                Positioned(
                                    top: Screen.width(24),
                                    child: Container(
                                      width: Screen.weightWidth(context),
                                      child: Center(
                                          child: Container(
                                            padding: EdgeInsets.only(left: Screen.width(30), right: Screen.width(30)),
                                            color: Colors.white,
                                            child: Text('${methods['name']}', style: TextStyle(fontSize: Screen.width(26)),),
                                          )
                                      ),
                                    )
                                )
                              ],
                            ),
                          ),
                        ),
                        GridView.builder(
                            itemCount:
                            menusList != null &&
                                menusList.length > 0 &&
                                menusList[methods['index']]['children'] != null &&
                                menusList[methods['index']]['children'].length > 0
                                ?
                            menusList[methods['index']]['children'].length : 0,
                            shrinkWrap: true,
                            physics: new NeverScrollableScrollPhysics(),
                            //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              //横轴元素个数
                                crossAxisCount: 4,
                                //纵轴间距
                                mainAxisSpacing: 8.0,
                                //横轴间距
                                crossAxisSpacing: 0.0,
                                //子组件宽高长度比例
                                childAspectRatio: 3),
                            itemBuilder: (BuildContext context, int index) {
                              //Widget Function(BuildContext context, int index)
                              return ButtonComponent.outline(
                                  title: '${menusList[methods['index']]['children'][index]['name_cn']}', textColor: childMethods['index2'] == index ? ColorGather.colorMain() : Colors.black, fontSize: menusList[methods['index']]['children'][index]['name_cn'].length > 5 ? 18 : 24, height: 50, width: .9, color: childMethods['index2'] == index ? ColorGather.colorMain() : Colors.black,
                                  pressed: () {
                                    setState(() {
                                      childMethods['index'] = index;
                                      childMethods['index2'] = index;
                                      grandSonMethods['index'] = 0;
                                      grandSonMethods['index2'] = -1;
                                      childMethods['name'] = menusList[methods['index']]['children'][index]['name_cn'];
                                      if(
                                      methods['name'] == states.currentGame['methodsName'] &&
                                          childMethods['name'] == states.currentGame['childMethodsName']
                                      ) {
                                        _currentMenus();
                                      }
                                      if(
                                      menusList[methods['index']]['children'][index]['children'] != null &&
                                          menusList[methods['index']]['children'][index]['children'].length > 0
                                      ) {
                                        grandSonMethods['name'] = menusList[methods['index']]['children'][index]['children'][0]['name_cn'];
                                      }

                                    });
                                  });
                            }),


                        Offstage(
                          offstage:
                          menusList[methods['index']]['children'] == null ||
                              menusList[methods['index']]['children'].length == 0 ||
                              menusList[methods['index']]['children'][childMethods['index']]['children'] == null ||
                              menusList[methods['index']]['children'][childMethods['index']]['children'].length == 0,
                          child: Container(
                            height: Screen.width(90),
                            child:  Stack(
                              children: <Widget>[
                                Positioned(
                                  top: Screen.width(45),
                                  child: Container(
                                    width: Screen.weightWidth(context),
                                    height: Screen.width(1),
                                    decoration: BoxDecoration(
                                        border: Border.all(width: Screen.width(1), color: ColorGather.colorMain())
                                    ),
                                  ),
                                ),
                                Positioned(
                                    top: Screen.width(24),
                                    child: Container(
                                      width: Screen.weightWidth(context),
                                      child: Center(
                                          child: Container(
                                            padding: EdgeInsets.only(left: Screen.width(30), right: Screen.width(30)),
                                            color: Colors.white,
                                            child: Text('${childMethods['name']}', style: TextStyle(fontSize: Screen.width(26)),),
                                          )
                                      ),
                                    )
                                )
                              ],
                            ),
                          ),
                        ),
                        GridView.builder(
                            itemCount:
                            menusList[methods['index']]['children'] != null &&
                                menusList[methods['index']]['children'].length > 0 &&
                                menusList[methods['index']]['children'][childMethods['index']]['children'] != null &&
                                menusList[methods['index']]['children'][childMethods['index']]['children'].length > 0
                                ?
                            menusList[methods['index']]['children'][childMethods['index']]['children'].length : 0,
                            shrinkWrap: true,
                            physics: new NeverScrollableScrollPhysics(),
                            //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              //横轴元素个数
                                crossAxisCount: 4,
                                //纵轴间距
                                mainAxisSpacing: 8.0,
                                //横轴间距
                                crossAxisSpacing: 0.0,
                                //子组件宽高长度比例
                                childAspectRatio: 3),
                            itemBuilder: (BuildContext context, int index) {
                              //Widget Function(BuildContext context, int index)
                              return ButtonComponent.outline(
                                  title: '${menusList[methods['index']]['children'][childMethods['index']]['children'][index]['name_cn']}', textColor: grandSonMethods['index2'] == index ? ColorGather.colorMain() : Colors.black, fontSize: menusList[methods['index']]['children'][childMethods['index']]['children'][index]['name_cn'].length > 5 ? 18 : 24, height: 50, width: .9, color: grandSonMethods['index2'] == index ? ColorGather.colorMain() : Colors.black,
                                  pressed: () {
                                    if(childMethods['index2'] == -1) {
                                      DialogComponents.alertIos(
                                          context, cancelShow: false,
                                          content: [
                                            Text('请先选择二级玩法 !!', style: TextStyle(fontSize: Screen.width(28))),
                                          ],
                                          confirm: () {
                                            Navigator.pop(context, 'confirm');
                                          }
                                      );
                                      return;
                                    }
                                    setState(() {
                                      grandSonMethods['index'] = index;
                                      grandSonMethods['index2'] = index;
                                      grandSonMethods['name'] = menusList[methods['index']]['children'][childMethods['index']]['children'][index]['name_cn'];
                                      states.currentGame['methods'] = menusList[methods['index']]['children'][childMethods['index']]['children'][index]['name_en'];


                                      states.currentGame['methodsName'] = methods['name2'] = methods['name'];
                                      states.currentGame['childMethodsName'] = childMethods['name2'] = childMethods['name'];
                                      states.currentGame['grandSonMethodsName'] = grandSonMethods['name2'] = grandSonMethods['name'];
                                      states.notifyListener();
                                      menusShow = false;
                                    });
                                  });
                            }),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        )
    );
  }

  // 游戏菜单
  _menus() {
    menusList = menus_data[states.currentGame['series']];

    _currentMenus();
    // 去除单式
    for(var i = 0; i < menusList.length; i++) {
      if(menusList[i]['name_cn'].indexOf('单') > -1) {
        menusList.removeAt(i);
      }

      for(var j = 0; j < menusList[i]['children'].length; j++) {
        if(menusList[i]['children'][j]['name_cn'].indexOf('单') > -1) {
          menusList[i]['children'].removeAt(j);
        }

        for(var k = 0; k < menusList[i]['children'][j]['children'].length; k++) {
          if(menusList[i]['children'][j]['children'][k]['name_cn'].indexOf('单') > -1) {
            menusList[i]['children'][j]['children'].removeAt(k);
          }
        }
      }
    }
  }

  // 切换游戏前判断当前游戏
  _currentMenus() {

    if(
        states.currentGame['methodsName'].isNotEmpty ||
        states.currentGame['childMethodsName'].isNotEmpty ||
        states.currentGame['grandSonMethodsName'].isNotEmpty
    ) {
      for(var i = 0; i < menusList.length; i++) {
        if(states.currentGame['methodsName'] == menusList[i]['name_cn']) {
          setState(() {
            methods['name2'] = menusList[i]['name_cn'];
            methods['index'] = i;
            methods['index2'] = i;
          });


          for(var j = 0; j < menusList[i]['children'].length; j++) {
            if(states.currentGame['childMethodsName'] == menusList[i]['children'][j]['name_cn']) {
              setState(() {
                childMethods['name2'] = menusList[i]['children'][j]['name_cn'];
                childMethods['index'] = j;
                childMethods['index2'] = j;
              });
            }

            for(var k = 0; k < menusList[i]['children'][j]['children'].length; k++) {
              if(states.currentGame['grandSonMethodsName'] == menusList[i]['children'][j]['children'][k]['name_cn']) {
                setState(() {
                  states.currentGame['methods'] = menusList[i]['children'][j]['children'][k]['name_en'];
                  grandSonMethods['name2'] = menusList[i]['children'][j]['children'][k]['name_cn'];
                  grandSonMethods['index'] = k;
                  grandSonMethods['index2'] = k;
                });
              }
            }
          }


        }
      }
    }
    else {
      setState(() {
        methods['name2'] = menusList[0]['name_cn'];
        methods['index'] = 0;
        methods['index2'] = 0;
      });

      if(menusList[methods['index']]['children'] != null && menusList[methods['index']]['children'].isNotEmpty) {
        setState(() {
          childMethods['name2'] = menusList[0]['children'][0]['name_cn'];
          childMethods['index'] = 0;
          childMethods['index2'] = 0;
        });

        if(menusList[methods['index']]['children'][0]['children'] != null && menusList[methods['index']]['children'][0]['children'].isNotEmpty) {
          setState(() {
            states.currentGame['methods'] = menusList[methods['index']]['children'][0]['children'][0]['name_cn'];
            grandSonMethods['name2'] = menusList[methods['index']]['children'][0]['children'][0]['name_cn'];
            grandSonMethods['index'] = 0;
            grandSonMethods['index2'] = 0;
          });
        }
      }
    }
  }


}