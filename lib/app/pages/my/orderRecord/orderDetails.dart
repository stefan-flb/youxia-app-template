import 'package:flutter/material.dart';

import '../../../component/component.dart';
import '../../../component/dialog.dart';
import '../../../../services/utils.dart';
import '../../../../services/state.dart';
import '../../../../api/api.dart';


class OrderDetails extends StatefulWidget{
  var arguments;
  @override
  OrderDetails({this.arguments});
  createState() => _OrderDetails(this.arguments);
}
class _OrderDetails extends State {
  var arguments;
  _OrderDetails(this.arguments);

  var details = {
    'method_name': '玩法名称',
    'is_challenge': '是否单挑',
    'hash_id': '订  单  号',
    'total_cost': '购买金额',
    'time_bought': '购买时间',
    'bet_prize_group': '奖  金  组',
    'mode': '购买模式',
    'times': '购买倍数',
    'bet_number_view': '购买内容',
  };
  var detailsList = [];
  @override
  initState() {
    super.initState();
    arguments.forEach((key, val) {
      if(details[key] != null) {
        var temp;
        temp = val;
        if(key == 'is_challenge') {
          val > 0 ? temp = '是' : temp = '否';
        }
        detailsList.add({'name': details[key], 'value': temp});
      }
    });
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: HeadersComponent.Appbars(Text('订单详情', style: TextStyle(fontSize: Screen.width(32)),)),
      body: ListView(
        children: <Widget>[
          ListTitleComponent(
            height: 160,
            leading: Image.network('${getBaseConfig["system_pic_base_url"]}/${arguments["icon_path"]}', width: Screen.width(100),),
            title: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('${arguments["lottery_name"]}', style: TextStyle(fontSize: Screen.width(26))),
                  SizedBox(width: 0, height: Screen.width(2),),
                  RichText(
                    text: TextSpan(
                        style: TextStyle(fontSize: Screen.width(28), color: Colors.grey),
                        children: [
                          TextSpan(text: '购买号码: '),
                          _winingNumber()
                        ]
                    ),
                  ),
                  SizedBox(width: 0, height: Screen.width(1),),
                  RichText(
                    text: TextSpan(
                        style: TextStyle(fontSize: Screen.width(28), color: Colors.grey),
                        children: [
                          TextSpan(text: '中奖金额: '),
                          _winingMoney()
                        ]
                    ),
                  )
                ]
            ),
            subPaddingTop: 10,
            trailing: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                SizedBox(width: 0, height: Screen.width(20),),
                Text('${arguments["issue"]}期', style: TextStyle(fontSize: Screen.width(24)), textAlign: TextAlign.right,),
                SizedBox(width: 0, height: Screen.width(10),),
                Offstage(
                  offstage: arguments["status"] != 0,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Text('撤销订单', style: TextStyle(fontSize: Screen.width(24), color: Colors.red, decoration: TextDecoration.underline)),
                    onTap: () {
                      if (arguments['status'] != 0 && arguments['status'] != 1) {return;}
                      DialogComponents.alertIos(
                          context,
                          content: [
                            Text('确定撤销这个订单吗 ?', style: TextStyle(fontSize: Screen.width(28))),
                          ],
                          confirm: () async{
                            Navigator.pop(context, 'confirm');
                            // var data = {
                            //   'project_id': arguments['hash_id']
                            // };
                            // var response = await Api.cancelProject(data);
                            // if(response['success']) {
                            //   setState(() {
                            //     arguments['status'] = 1;
                            //   });
                            //   DialogComponents.toast(context, content: response['msg']);
                            // }

                          }
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: Screen.width(30)),
            padding: EdgeInsets.only(left: Screen.width(15), top: Screen.width(15)),
            color: Colors.white,
            child: Text('订单详情', style: TextStyle(fontSize: Screen.width(30)),),
          ),
          Container(
            padding: EdgeInsets.only(left: Screen.width(25), top: Screen.width(15)),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: detailsList.map<Widget>((val) {
                return Container(
                  margin: EdgeInsets.only(bottom: Screen.width(8)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('${val["name"]}     ', style: TextStyle(fontSize: Screen.width(27)),),
                      Expanded(child: Text('${val["value"]}', style: TextStyle(fontSize: Screen.width(26)),),)
                    ],
                  ),
                );
              }).toList()
            ),
          ),


          Container(
            margin: EdgeInsets.only(top: Screen.width(25)),
            padding: EdgeInsets.only(left: Screen.width(25), top: Screen.width(10), bottom: Screen.width(10), right: Screen.width(25)),
            color: Colors.white,
            child: ButtonComponent.material(title: '再来一单', pressed: () {

            },),
          )
        ],
      ),
    );
  }

  // 中奖金额
  _winingNumber() {
    if(arguments['status'] == 0) {
      return TextSpan(text: '待开奖');
    } else if(arguments['status'] == 1) {
      return TextSpan(text: '已撤销');
    } else {
      return TextSpan(text: '${arguments['open_number']}', style: TextStyle(color: Colors.red));
    }
  }
  // 中奖金额
  _winingMoney() {
    if(arguments['status'] == 0) {
      return TextSpan(text: '待开奖');
    } else if(arguments['status'] == 1) {
      return TextSpan(text: '已撤销');
    } else if(arguments['is_win'] == 1) {
      return TextSpan(text: '${arguments['bonus']}元', style: TextStyle(color: Colors.red));
    } else if(arguments['is_win'] == 2) {
      return TextSpan(text: '未中奖', style: TextStyle(color: Colors.green));
    }
  }
}