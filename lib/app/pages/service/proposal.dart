import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../services/utils.dart';
import '../../component/component.dart';
import '../../component/dialog.dart';


class ProposalPages extends StatefulWidget{
  createState() => _ProposalPages();
}

class _ProposalPages extends State {
  var proposal = TextEditingController();
  var phone = TextEditingController();
  var proposalType = 0;

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
            appBar: HeadersComponent.Appbars(Text('意见反馈', style: TextStyle(fontSize: Screen.width(32)),)),
            body: Container(
                width: double.infinity,
                color: ColorGather.colorBg(),
                child: ListView(
                  children: <Widget>[
                    InputComponent.text(
                        labelText: '请输入遇到的问题和建议', controller: proposal, maxLines: 9, maxLength: 200
                    ),

                    SizedBox(height: Screen.width(30),),
                    InputComponent.text(
                        labelText: '请输入联系电话方便我们联系你', controller: phone,
                        inputFormatters: [
                          WhitelistingTextInputFormatter.digitsOnly
                        ]),
                    Divider(height: 0,),
                    ListTitleComponent(
                      title: Text('反馈类型', style: TextStyle(fontSize: Screen.width(28), color: Colors.grey)),
                      trailing: Row(
                        children: <Widget>[
                          Text('${proposalType == 0 ? '建议' : '投诉'}', style: TextStyle(fontSize: Screen.width(28), color: Colors.grey)),
                          Icon(Icons.keyboard_arrow_down, size: Screen.width(55), color: Colors.grey,),
                        ],
                      ),
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
                                    child: Text('建议', style: TextStyle(fontSize: Screen.width(30), decoration: TextDecoration.none, fontWeight: FontWeight.normal, color: Colors.black)),
                                  ),
                                  onTap: () {
                                    setState(() {proposalType = 0; Navigator.pop(context);});
                                  },
                                ),
                                Divider(height: 0,),
                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: double.infinity, height: Screen.width(95),
                                    child: Text('投诉', style: TextStyle(fontSize: Screen.width(30), decoration: TextDecoration.none, fontWeight: FontWeight.normal, color: Colors.black)),
                                  ),
                                  onTap: () {
                                    setState(() {proposalType = 1; Navigator.pop(context);});
                                  },
                                ),
                              ],
                            )
                        );
                      },
                    ),
                    SizedBox(height: Screen.width(50),),
                    ButtonComponent.material(title: '确认发送', width: .8, pressed: () {

                    },),
                    SizedBox(height: Screen.width(50),),
                  ],
                )
            )
        )
    );
  }
}