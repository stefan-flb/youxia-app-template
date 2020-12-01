import 'package:flutter/material.dart';

import '../../../../component/component.dart';
import '../../../../component/dialog.dart';
import '../../../../../services/utils.dart';
import '../../../../../services/state.dart';
import '../../../../../api/api.dart';


class TracesDetails extends StatefulWidget{
  var arguments;
  @override
  TracesDetails({this.arguments});
  createState() => _TracesDetails(this.arguments);
}
class _TracesDetails extends State {
  var arguments;
  _TracesDetails(this.arguments);

  var details = {
    'lottery_name': '游戏名称',
    'method_name': '玩法名称',
    'start_issue': '开始期号',
    'is_challenge': '是否单挑',
    'total_price': '追号金额',
    'created_at': '追号时间',
    'bet_prize_group': '奖  金  组',
    'mode': '模        式',
    'finished_bonus': '中奖金额',
    'win_stop': '追中即停',
    'total_issues': '追号期数',
    'bet_number_view': '追号内容'
  };
  var detailsList = [];

  //
  var allCancelTracesFlag = false;
  @override
  initState() {
    super.initState();
    arguments.forEach((key, val) {
      if(details[key] != null) {
        var temp = val;
        if(key == 'is_challenge' || key == 'win_stop') {
          val > 0 ? temp = '是' : temp = '否';
        }
        detailsList.add({'name': details[key], 'value': temp});
      }
    });

    arguments['tracesList'].forEach((v) {
      if(v['status'] == 0) {
        setState(() {
          allCancelTracesFlag = true;
        });
      }
    });
  }

  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: HeadersComponent.Appbars(Text('订单详情', style: TextStyle(fontSize: Screen.width(32)),)),
      body: ListView(
        children: <Widget>[
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
                      Text('123     ', style: TextStyle(fontSize: Screen.width(27)),),
                      Expanded(child: Text('123', style: TextStyle(fontSize: Screen.width(26)),),)
                    ],
                  ),
                );
              }).toList()
            ),
          ),

          Container(
            margin: EdgeInsets.only(top: Screen.width(30)),
            padding: EdgeInsets.only(left: Screen.width(15), top: Screen.width(15)),
            color: Colors.white,
            child: Row(
              children: <Widget>[
                Text('追号记录', style: TextStyle(fontSize: Screen.width(30)),),
                SizedBox(width: Screen.width(60), height: 0,),
                Offstage(
                  offstage: !allCancelTracesFlag,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Text('停止所有追号', style: TextStyle(fontSize: Screen.width(26), decoration: TextDecoration.underline, color: Colors.red),),
                    onTap: () {
                      DialogComponents.alertIos(
                          context,
                          content: [
                            Text('确定撤销 所有订单 吗 ?', style: TextStyle(fontSize: Screen.width(28))),
                          ],
                          confirm: () async{
                            Navigator.pop(context, 'confirm');
                            // var data = {
                            //   'trace_id': arguments['id']
                            // };
                            // var response = await Api.cancelTrace(data);
                            // if(response['success']) {
                            //   arguments['tracesList'].forEach((v) {
                            //     if(v['status'] == 0) {
                            //       setState(() {
                            //         v['status'] = 1;
                            //       });
                            //     }
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
            padding: EdgeInsets.only(bottom: Screen.width(15), top: Screen.width(15), left: Screen.width(15)),
            color: Colors.white,
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: Text('期号', style: TextStyle(fontSize: Screen.width(27)),),
                ),
                Expanded(
                  child: Text('状态', style: TextStyle(fontSize: Screen.width(27)),),
                ),
                Expanded(
                  child: Text('订单编号', style: TextStyle(fontSize: Screen.width(27)),),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: Screen.width(15), top: Screen.width(15)),
            color: Colors.white,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: arguments['tracesList'].map<Widget>((val) {
                  return Container(
                    margin: EdgeInsets.only(bottom: Screen.width(8)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child:GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              child: _issue(val),
                              onTap: () {
                                if(val['status'] != 0) {return;}

                                DialogComponents.alertIos(
                                    context,
                                    content: [
                                      Text('确定撤销  123  订单吗 ?', style: TextStyle(fontSize: Screen.width(28))),
                                    ],
                                    confirm: () async{
                                      Navigator.pop(context, 'confirm');
                                      // var data = {
                                      //   'trace_detail_id': val['id']
                                      // };
                                      // var response = await Api.cancelTraceDetail(data);
                                      // if(response['success']) {
                                      //   setState(() {
                                      //     val['status'] = 1;
                                      //   });
                                      //   DialogComponents.toast(context, content: response['msg']);
                                      // }
                                    }
                                );

                              }
                          ),
                        ),
                        Expanded(
                          child: _tracesStatus(val)
                        ),
                        Expanded(
                          child: _orderId(val)
                        )
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

  // 追号状态
  _tracesStatus(item) {
    if(item['status'] == 0) {
      return Text('等待追号', style: TextStyle(fontSize: Screen.width(27), color: Colors.orange),);
    } else if(item['status'] == 1) {
      return Text('玩家撤销', style: TextStyle(fontSize: Screen.width(27)),);
    } else if(item['status'] == 2) {
      return Text('系统撤销', style: TextStyle(fontSize: Screen.width(27)),);
    } else if(item['status'] == 3) {
      return Text('中奖停止', style: TextStyle(fontSize: Screen.width(27), color: Colors.orange),);
    } else if(item['status'] == 4 && double.parse(item['bonus']) > 0) {
      return Text('已中奖', style: TextStyle(fontSize: Screen.width(27), color: Colors.red),);
    } else if(item['status'] == 4 && double.parse(item['bonus']) <= 0) {
      return Text('追号完成', style: TextStyle(fontSize: Screen.width(27)),);
    }
  }

  _issue(item) {
    var color = Colors.black87;
    if(item['status'] == 0 || item['status'] == 3) {
      color = Colors.orange;
    } else if(item['status'] == 4 && double.parse(item['bonus']) > 0) {
      color = Colors.red;
    }
    return Text('${item["issue"]}', style: TextStyle(fontSize: Screen.width(27), color: color, decoration: item['status'] == 0 ? TextDecoration.underline : TextDecoration.none),);
  }

  _orderId (item) {
    var color = Colors.black87;
    if(item['status'] == 0 || item['status'] == 3) {
      color = Colors.orange;
    } else if(item['status'] == 4 && double.parse(item['bonus']) > 0) {
      color = Colors.red;
    }
    return Text('${item["id"]}', style: TextStyle(fontSize: Screen.width(27), color: color),);
  }

  // 撤销订单
  _cancelTraceDetail(item) async{

  }
}