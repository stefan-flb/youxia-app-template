import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/utils.dart';
import '../../services/state.dart';
import '../component/component.dart';
import '../component/dialog.dart';
import '../../api/api.dart';

import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:marquee_flutter/marquee_flutter.dart';

class IndexPages extends StatefulWidget{
   createState() => _IndexPages();
}

class _IndexPages extends State {
  var current = -1;

  var banner = [];
  var popularLottery = List();
  var popularLottery2 = List();
  var noticeList = Map();

  var list = [
    {'name': '英雄联盟', 'series': 'ssc'},
    {'name': '英雄联盟', 'series': 'yxlm'},
  ];
  @override
  initState() {
    super.initState();
    noticeList['type_desc'] = '';
    _init();
  }

  Widget build(BuildContext context) {
    Screen.init(context);
    globeBuildContext = context;
    final states = Provider.of<Providers>(context);
    // TODO: implement build
    return Scaffold(
      appBar: HeadersComponent.Appbars(
          Text('logo', style: TextStyle(fontSize: Screen.width(32)),),
          showLeading: false
      ),
      body: Container(
        color: ColorGather.colorBg(),
        child: ListView(
          children: <Widget>[
            // 轮播图
            Container(
              height: Screen.width(300),
              child: Swiper(
                  itemBuilder: (BuildContext context,int index){
                    // return Image.network("${getBaseConfig['system_pic_base_url']}/${banner[index]['img']}", fit: BoxFit.fill,);
                    return Image.asset('images/home/banner_01.jpg', fit: BoxFit.fill,);
                  },
                  itemCount: 3,
                  pagination: SwiperPagination(
                    margin: EdgeInsets.all(Screen.width(8)),
                    builder: DotSwiperPaginationBuilder(
                      activeColor: ColorGather.colorMain()
                    )
                  ),
                  onTap: (index) {},
                  duration: 500,
                  autoplay: true,
              ),
            ),

            // 滚动公告
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              child: Row(
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    height: Screen.width(100),
                    child: Image.asset('images/home/index_01.png', width: Screen.width(70),),
                    padding: EdgeInsets.only(left: Screen.width(30), right: Screen.width(10)),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      color: Colors.white,
                      width: Screen.width(600),
                      height: Screen.width(100),
                      child: MarqueeWidget(
                        text: '英雄联盟英雄联盟英雄联盟英雄联盟英雄联盟英雄联盟英雄联盟英雄联盟英雄联盟英雄联盟英雄联盟',
                        textStyle: TextStyle(fontSize: Screen.width(28)),
                        scrollAxis: Axis.horizontal,
                        ratioOfBlankToScreen: 1,
                      ),
                    ),
                  )
                ],
              ),
              onTap: () {
                Navigator.pushNamed(context, '/message');
              },
            ),

            // 四个导航
            Container(
              padding: EdgeInsets.only(top: Screen.width(20), bottom: Screen.width(20)),
              margin: EdgeInsets.only(top: Screen.width(30), bottom: Screen.width(30)),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Column(
                      children: <Widget>[
                        Image.asset('images/home/index_02.png', width: Screen.width(100),),
                        SizedBox(height: Screen.width(15),),
                        Text('签到有礼', style: TextStyle(fontSize: Screen.width(28)),),
                      ],
                    ),
                    onTap: () {
                      DialogComponents.centerCostomInformation(
                        context,
                        content: Container(
                          height: Screen.width(830),
                          child: Stack(
                            children: <Widget>[
                              Positioned(
                                top: Screen.width(180),
                                child: Container(
                                    padding: EdgeInsets.only(top: Screen.width(50)),
                                    width: Screen.width(650),
                                    height: Screen.width(700),
                                    color: Colors.white,
                                    child: Column(
                                      children: <Widget>[
                                        Wrap(
                                            spacing: Screen.width(10),
                                            runSpacing: Screen.width(10),
                                            alignment: WrapAlignment.center,
                                            children: signIn()
                                        ),
                                        SizedBox(height: Screen.width(30),),
                                        ButtonComponent.material(title: '领取奖励', width: .8, pressed: () {},),
                                      ],
                                    )
                                ),
                              ),
                              Container(
                                alignment: Alignment.topCenter,
                                padding: EdgeInsets.only(top: Screen.width(75)),
                                width: Screen.width(650),
                                height: Screen.width(300),
                                decoration: BoxDecoration(
                                    image: DecorationImage(image: AssetImage('images/home/index_06.png'), fit: BoxFit.contain, alignment: Alignment.topCenter)
                                ),
                                child: Text('每日签到', style: TextStyle(fontSize: Screen.width(36), decoration: TextDecoration.none, color: Colors.white, fontWeight: FontWeight.normal)),
                              ),
                              Positioned(
                                  top: Screen.width(15),
                                  right: Screen.width(15),
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    child: Image.asset('images/home/index_close.png', width: Screen.width(55)),
                                    onTap: () {Navigator.pop(context);},
                                  )
                              ),
                            ],
                          ),
                        )
                      );
                    },
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Column(
                      children: <Widget>[
                        Image.asset('images/home/index_03.png', width: Screen.width(100),),
                        SizedBox(height: Screen.width(15),),
                        Text('有奖任务', style: TextStyle(fontSize: Screen.width(28)),),
                      ],
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, '/taskCenter');
                    },
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Column(
                      children: <Widget>[
                        Image.asset('images/home/index_04.png', width: Screen.width(100),),
                        SizedBox(height: Screen.width(15),),
                        Text('购买记录', style: TextStyle(fontSize: Screen.width(28)),),
                      ],
                    ),
                    onTap: () {Navigator.pushNamed(context, '/orderType');},
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Column(
                      children: <Widget>[
                        Image.asset('images/home/index_05.png', width: Screen.width(100),),
                        SizedBox(height: Screen.width(15),),
                        Text('立即充值', style: TextStyle(fontSize: Screen.width(28)),),
                      ],
                    ),
                    onTap: () {Navigator.pushNamed(context, '/recharge');},
                  ),
                ],
              ),
            ),

            // 热门游戏
            ListTitleComponent(
              title: Row(
                children: <Widget>[
                  Text('热门游戏', style: TextStyle(fontSize: Screen.width(30)),),
                  SizedBox(width: Screen.width(30),),
                  Text('官方热门推荐', style: TextStyle(fontSize: Screen.width(26), color: Colors.grey),),
                ],
              ),
              trailingShow: false,
            ),
            Divider(height: 0,),
            Container(
              padding: EdgeInsets.only(top: Screen.width(15), bottom: Screen.width(15)),
              color: Colors.white,
              child: GridView.builder(
                padding: EdgeInsets.all(0),
                  itemCount: list.length,
                  shrinkWrap: true,
                  physics: new NeverScrollableScrollPhysics(),
                  //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //横轴元素个数
                    crossAxisCount: 2,
                    //纵轴间距
                    mainAxisSpacing: 0.0,
                    //横轴间距
                    crossAxisSpacing: 0.0,
                    childAspectRatio: 8 / 2,
                  ),
                  itemBuilder: (BuildContext context, int index) {
                    //Widget Function(BuildContext context, int index)
                    return ListTitleComponent(
                      leadingLeft: 20,
                      leadingRight: 15,
                      title: Text('${list[index]['name']}', style: TextStyle(fontSize: Screen.width(26)),),
                      subTitle: Text('火热购买中...', style: TextStyle(fontSize: Screen.width(24), color: Colors.red),),
                      trailingShow: false,
                      onTap: () {
                        states.currentGame['series'] = list[index]['series'];
                        // Navigator.pushNamed(context, '/games');
                      },
                    );
                  }),
            ),


            SizedBox(height: Screen.width(30),),
            ListTitleComponent(
              title: Row(
                children: <Widget>[
                  Text('游戏娱乐', style: TextStyle(fontSize: Screen.width(30)),),
                  SizedBox(width: Screen.width(30),),
                  Text('现场美女 高质量服务', style: TextStyle(fontSize: Screen.width(26), color: Colors.grey),),
                ],
              ),
              trailingShow: false,
            ),
            Divider(height: 0,),
            Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: Screen.width(30), bottom: Screen.width(30)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: Screen.width(340),
                      height: Screen.width(200),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Screen.width(10)),
                        image: DecorationImage(
                            image: AssetImage('images/home/banner_01.jpg'),
                            fit: BoxFit.cover
                        )
                      ),
                    ),
                  ),
                  SizedBox(width: Screen.width(15),),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      width: Screen.width(340),
                      height: Screen.width(200),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(Screen.width(10)),
                        image: DecorationImage(
                            image: AssetImage('images/home/banner_01.jpg'),
                            fit: BoxFit.cover
                        )
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: Screen.width(30),),
            ListTitleComponent(
              title: Text('更多游戏', style: TextStyle(fontSize: Screen.width(30)),),
              trailing: Text('更多 >>>', style: TextStyle(fontSize: Screen.width(28), color: Colors.grey),),
            ),
            Divider(height: 0,),
            Container(
              padding: EdgeInsets.only(top: Screen.width(30), bottom: Screen.width(30)),
              color: Colors.white,
              child: GridView.builder(
                // itemCount: popularLottery.length,
                itemCount: 10,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //横轴元素个数
                  crossAxisCount: 3,
                  //纵轴间距
                  mainAxisSpacing: 10,
                  //横轴间距
                  crossAxisSpacing: 1,
                  childAspectRatio: 6 / 4
                ),
                itemBuilder: (BuildContext context, int index) {
                  //Widget Function(BuildContext context, int index)
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Image.asset('images/home/banner_01.jpg'),
                        width: Screen.width(100),
                        height: Screen.width(100),
                      ),
                      SizedBox(height: Screen.width(10),),
                      Text('英雄联盟', style: TextStyle(fontSize: Screen.width(26)),)
                    ],
                  );
                })
            ),
            SizedBox(height: Screen.width(30),),
          ],
        ),
      ),
    );
  }

  _init() async{
    if(getBaseConfig.length <= 0) {
//      var response = await Api.baseConfig();
      // 更新配置
//      if(response['success']) {
//        setState(() {
//          getBaseConfig = response['data'];
//          banner = getBaseConfig['home_banner'];
//          popularLottery = getBaseConfig['popular_lottery'];
//          popularLottery2.add(getBaseConfig['popular_lottery'][0]);
//          popularLottery2.add(getBaseConfig['popular_lottery'][1]);
//          noticeList = getBaseConfig["notice_list"]["data"][0];
//        });
//      }
    } else {
      banner = getBaseConfig['home_banner'];
      popularLottery = getBaseConfig['popular_lottery'];
      popularLottery2.add(getBaseConfig['popular_lottery'][0]);
      popularLottery2.add(getBaseConfig['popular_lottery'][1]);
      noticeList = getBaseConfig["notice_list"]["data"][0];
    }
  }
  // 签到
  signIn() {
    var list = [1, 2, 3, 4, 5, 6, 7];
    var tempList = list.asMap().map((index, item) {
       return MapEntry(index, StatefulBuilder(
         builder: (context, changeState) {
           return GestureDetector(
             behavior: HitTestBehavior.opaque,
             child: Container(
               width: Screen.width(140),
               height: Screen.width(210),
               decoration: BoxDecoration(
                   image: DecorationImage(image: AssetImage(current == index ? 'images/home/index_07.png' : 'images/home/index_08.png' ), fit: BoxFit.contain, alignment: Alignment.topCenter)
               ),
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: <Widget>[
                   Text('第${index + 1}天', style: TextStyle(fontSize: Screen.width(26), decoration: TextDecoration.none, color: current == index ? Color.fromRGBO(51,164,138, 1): Color.fromRGBO(148,91,38, 1), fontWeight: FontWeight.normal)),
                   Container(
                     width: Screen.width(70), margin: EdgeInsets.only(top: Screen.width(10), bottom: Screen.width(10)),
                     child: Image.asset('images/home/index_09.png'),
                   ),
                   Text('2金币', style: TextStyle(fontSize: Screen.width(26), decoration: TextDecoration.none, color: current == index ? Color.fromRGBO(51,164,138, 1): Color.fromRGBO(148,91,38, 1), fontWeight: FontWeight.normal)),
                 ],
               ),
             ),

             onTap: () {
               changeState(() {current = index;});
               setState(() {current = index;});
               print(current);
             },
           );
         },
       )
      );
    }
    ).values.toList();
    return tempList;
  }
}