import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../services/utils.dart';
import 'dart:async';

//showDialog(
//  context: context, //BuildContext对象
//  builder: (BuildContext context) {
//  return null;
//});
class DialogComponents{
  static var toastOverlayEntry;
  static var toastOverlay;
//  DialogComponents.alert(context, content: '请先设置资金密码！！！', confirm: () {
//  });
  static alert(context, {title, content, cancelText, confirmText, confirm, cancel, cancelShow = true, textAlign, fontSize, textColor}) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            titlePadding: EdgeInsets.only(top: Screen.width(25), bottom: 0),
            contentPadding: EdgeInsets.only(top: Screen.width(25), bottom: 0, left: Screen.width(25), right: Screen.width(25)),
            title: Text(title ?? '提示', textAlign: TextAlign.center, style: TextStyle(fontSize: Screen.width(34))),
            content: ConstrainedBox(
              constraints: BoxConstraints(
                minWidth: Screen.width(300),
                minHeight: Screen.width(120)
              ),
              child: Text(content, style: TextStyle(fontSize: Screen.width(fontSize ?? 28), color: textColor ?? Colors.black), textAlign: textAlign ?? TextAlign.center,),
            ),
            actions: <Widget>[
              Offstage(
                offstage: !cancelShow,
                child: FlatButton(
                  child: Text(cancelText ?? '取消', style: TextStyle(fontSize: Screen.width(30), color: ColorGather.colorMain())),
                  onPressed: cancel != null ? cancel : () {Navigator.pop(context, 'cancel');},
                ),
              ),
              FlatButton(
                child: Text(confirmText ?? '确认', style: TextStyle(fontSize: Screen.width(30), color: ColorGather.colorMain())),
                onPressed: confirm != null ? confirm : () {Navigator.pop(context, 'confirm');},
              ),
            ],
          );
        }
    );
  }

//  DialogComponents.alertIos(
//  context,
//  content: [
//  Text('123', style: TextStyle(fontSize: Screen.width(28))),
//  ],
//  confirm: () {
//  Navigator.pop(context, 'confirm');
//  }
//  );
  static alertIos(context, {content, title, confirm, cancel, cancelShow = true, cancelText, confirmText}) {
    return showCupertinoDialog(
        context: context,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Container(
              padding: EdgeInsets.only(bottom: Screen.width(15)),
              child: Text(title ?? '提示', style: TextStyle(fontSize: Screen.width(32))),
            ),
            content: ListBody(
              children: content
            ),
            actions: alertIosBtn(context, cancelShow, cancelText, cancel, confirmText, confirm)
          );
        }
    );
  }


//    选择框
//  DialogComponents.select(context,
//    item: [
//      SimpleDialogOption(
//        child: Text('选择1', style: TextStyle(fontSize: Screen.width(28))),
//        onPressed: () {Navigator.pop(context, '选择');},
//      ),
//    ],
//    callBack: (val) {
//      print(val);
//    }
//  );
  static select(context, {title, item = const [], callBack(val)}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text(title ?? '选择', style: TextStyle(fontSize: Screen.width(32)), textAlign: TextAlign.center,),
          titlePadding: EdgeInsets.only(left: Screen.width(20), right: 0, top: Screen.width(20), bottom: 0),
          contentPadding: EdgeInsets.only(left: 0, right: 0, top: Screen.width(15), bottom: Screen.width(20)),
          children: item,
        );
      },
    ).then((val) {
      callBack ?? print('0');
    });
  }

  // 中间弹出空白自定义框
//  DialogComponents.centerCostomInformation(
//  context,
//  content: Container(
//  padding: EdgeInsets.all(Screen.width(20)),
//  color: Colors.white,
//  child: Column(
//  children: <Widget>[
//  Text('zxcvbnm123456', style: TextStyle(fontSize: Screen.width(30), decoration: TextDecoration.none, color: Colors.black, fontWeight: FontWeight.normal)),
//  ],
//  )
//  ),
//  );
  static centerCostomInformation (context, {width, height, content}) {
    showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel: '',
        barrierColor: Colors.black.withOpacity(.5),
        transitionDuration: Duration(milliseconds: 400),
        transitionBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation, Widget child) {
          return ScaleTransition(scale: animation, child: child);
        },
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              content
            ],
          );
        });
  }

// 底部弹出
//  DialogComponents.sheet(
//  context,
//  content: Container(
//  height: Screen.width(615),
//  child: Column(
//  children: <Widget>[
//  Text('当前倍数', style: TextStyle(fontSize: Screen.width(28))),
//  ],
//  ),
//  )
//  );

//  showModalBottomSheet与BottomSheet的区别是 showBottomSheet充满屏幕，showModalBottomSheet半屏
  static sheet(context, {item = const [], callBack, bgColor = Colors.white, content, mode = 'showModalBottomSheet'}) {
    mode == 'showModalBottomSheet' ? showModalBottomSheet(
      backgroundColor: bgColor,
      context: context,
      builder: (BuildContext context) {
        return content;
      },
    ) : showBottomSheet(
      backgroundColor: bgColor,
      context: context,
      builder: (BuildContext context) {
        return content;
      },
    );
  }


//  StatefulBuilder(
//  builder: (context, changeState) {
//  return '内容'
//  },
//  )
//  changeState(() {whichState = 1;print(whichState); Navigator.pop(context);});
//  setState(() {whichState = 1;print(whichState); Navigator.pop(context);});

//  DialogComponents.customSheetHalfBottle(
//  context,
//  content: // '内容'
//  );

  // 底部弹出内容列表, 带标题
  static customSheetHalfBottle(context, {title, cancelText, content, color, isScroll = false}) {
    return showDialog(
        context: context,
        builder: (context) {
          return  Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                width: double.infinity,
                height: Screen.width(75),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: color ?? Color.fromRGBO(236,236,236, 1),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
                ),
                child: Text(title ?? '选择', style: TextStyle(fontSize: Screen.width(28), decoration: TextDecoration.none, fontWeight: FontWeight.normal, color: Colors.black),),
              ),
              Divider(height: 0,),
              isScroll ? Expanded(
                child: Container(
                  color: color ?? Color.fromRGBO(236,236,236, 1),
                  padding: EdgeInsets.only(top:Screen.width(15), bottom: Screen.width(10)),
                  child: ListView(
                    children: <Widget>[
                      Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: color ?? Color.fromRGBO(236,236,236, 1),
                          ),
                          child: content
                      ),
                    ],
                  )
                )
              ) : Container(
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(top:Screen.width(15), bottom: Screen.width(10)),
                    decoration: BoxDecoration(
                      color: color ?? Color.fromRGBO(236,236,236, 1),
                    ),
                    child: content
              ),

              GestureDetector(
                behavior: HitTestBehavior.opaque,
                child: Container(
                  margin: EdgeInsets.only(top: Screen.width(15)),
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top:Screen.width(20), bottom: Screen.width(20)),
                  decoration: BoxDecoration(color: Colors.white),
                  child: Text(cancelText ?? '取消', style: TextStyle(fontSize: Screen.width(30), decoration: TextDecoration.none, fontWeight: FontWeight.normal, color: Colors.black),),
                ),
                onTap: () {Navigator.pop(context);},
              )
            ],
          );
        }
    );
  }

//  StatefulBuilder(
//  builder: (context, changeState) {
//  return '内容'
//  },
//  )
//  changeState(() {whichState = 1;print(whichState); Navigator.pop(context);});
//  setState(() {whichState = 1;print(whichState); Navigator.pop(context);});

//  DialogComponents.customSheetIos(
//  context,
//  content: Column(
//  children: <Widget>[
//  GestureDetector(
//  behavior: HitTestBehavior.opaque,
//  child: Container(
//  alignment: Alignment.center,
//  width: double.infinity, height: Screen.width(95),
//  child: Text('代理', style: TextStyle(fontSize: Screen.width(30), decoration: TextDecoration.none, fontWeight: FontWeight.normal, color: Colors.black)),
//  ),
//  onTap: () {
//  setState(() {openType = 0; Navigator.pop(context);});
//  },
//  ),
//  Divider(height: 0,),
//  ],
//  )
//  );
  // 底部弹出选择列表, 不带标题
  static customSheetIos(context, {cancelText, content}) {
    return showDialog(
        context: context,
        builder: (context) {
          return  Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                    color: Color.fromRGBO(255,255,255, .93),
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(12), topRight: Radius.circular(12))
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10))
                        ),
                        child: content
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        margin: EdgeInsets.only(top: Screen.width(20)),
                        width: double.infinity,
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(top:Screen.width(20), bottom: Screen.width(20)),
                        decoration: BoxDecoration(color: Colors.white),
                        child: Text(cancelText ?? '取消', style: TextStyle(fontSize: Screen.width(30), decoration: TextDecoration.none, fontWeight: FontWeight.normal, color: Colors.black),),
                      ),
                      onTap: () {Navigator.pop(context);},
                    )
                  ],
                ),
              ),
            ],
          );
        }
    );
  }

// 提示语状态
//  DialogComponents.toast(context, content: '123');
  static toast(context, {content, mask = true, seconds, position = '', opacity, noTime = false}) {
    // ignore: missing_return
    positionToast() {
      switch(position) {
        case 'top':
          return EdgeInsets.only(bottom: Screen.weightHeight(context) * .6);
          break;
        case 'center':
          return EdgeInsets.only(top: 0);
          break;
        case 'bottom':
          return EdgeInsets.only(top: Screen.weightHeight(context) * .7);
          break;
      }
    }
    _fn() {
      return Center(
        child: Container(
            margin: positionToast(),
            padding: EdgeInsets.only(left: Screen.width(28), right: Screen.width(28), top: Screen.width(20), bottom: Screen.width(10)),
            decoration: BoxDecoration(
                color: Color.fromRGBO(0, 0, 0, opacity ?? 1.0),
                borderRadius: BorderRadius.circular(Screen.width(8))
            ),
            height: Screen.width(82),
            child: Column(
              children: <Widget>[
                Text(content, style: TextStyle(fontSize: Screen.width(28), color: Colors.white, decoration: TextDecoration.none, fontWeight: FontWeight.normal), textAlign: TextAlign.center,),
              ],
            )
        ),
      );
    }
    toastOverlay = Overlay.of(context);
    toastOverlayEntry = OverlayEntry(
        builder: (context) => Positioned(
            child: mask ? Material(
                type: MaterialType.transparency,
                child: _fn()
            ) : _fn()
        )
    );
    toastOverlay.insert(toastOverlayEntry);
    if(!noTime) {
      Timer(Duration(seconds: seconds ?? 2), () {
        toastOverlayEntry?.remove();
      });
    }
  }
  static toastDismiss() {
    toastOverlayEntry?.remove();
  }

}

// alertIos的按钮
alertIosBtn(context, cancelShow, cancelText, cancel, confirmText, confirm) {
  if(!cancelShow) {
    return [
      CupertinoDialogAction(
          child: Text(confirmText ?? '确认', style: TextStyle(fontSize: Screen.width(30), color: ColorGather.colorMain())),
          onPressed: confirm ?? () {Navigator.pop(context);}
      ),
    ];
  } else {
    return [
      CupertinoDialogAction(
        child: Text(cancelText ?? '取消', style: TextStyle(fontSize: Screen.width(30), color: ColorGather.colorMain())),
        onPressed: cancel ?? () {Navigator.pop(context);},
      ),
      CupertinoDialogAction(
          child: Text(confirmText ?? '确认', style: TextStyle(fontSize: Screen.width(30), color: ColorGather.colorMain())),
          onPressed: confirm ?? () {Navigator.pop(context);}
      ),
    ];
  }
}