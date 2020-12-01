import 'package:flutter/material.dart';
import '../../services/utils.dart';

// header头部
class HeadersComponent{
  static Appbars(content, {leading, bottom, actions, showLeading}) {
    return AppBar(
      leading: leading,
      title: content,
      backgroundColor: ColorGather.colorMain(), // 导航栏颜色
      centerTitle: true, // 是否居中
      elevation: 0, // 导航栏下边的阴影
      automaticallyImplyLeading: showLeading ?? true,
      actions: actions ?? <Widget>[],
      bottom: bottom,
    );
  }
}

// form表单
//    InputComponent.text(
//        labelText: '请输入新密码', controller: passwordNew,
//        inputFormatters: [
//          LengthLimitingTextInputFormatter(18)
//        ]),
class InputComponent{
  static text({hintText, color, labelText, labelColor, obscureText, changed, controller, inputFormatters, maxLength, maxLines}) {
    return Container(
        color: color ?? Colors.white,
        width: double.infinity,
        padding: EdgeInsets.only(left: Screen.width(20)),
        child: TextField(
          inputFormatters: inputFormatters ?? [],
          obscureText: obscureText ?? false,
          style: TextStyle(fontSize: Screen.width(28), height: Screen.width(2.1)),
          decoration: InputDecoration(hintText: hintText ?? labelText, border: InputBorder.none, labelText: labelText ?? '', labelStyle: TextStyle(color: labelColor ?? Colors.grey),),
          onChanged: changed,
          controller: controller,
          maxLines: maxLines ?? 1,
          maxLength: maxLength,
        )
    );
  }
}

// 按钮
class ButtonComponent{
  //    ButtonComponent.material(title: '确认修改', pressed: () {},),
  static material({width, height, title, color, textColor, fontSize, elevation, radius, pressed}) {
    return FractionallySizedBox(
      widthFactor: width ?? .97,
      child: MaterialButton(
          padding: EdgeInsets.all(0),
          height: Screen.width(height ?? 85),
          color: color ?? ColorGather.colorMain(),
          textColor: textColor ?? Colors.white,
          elevation: elevation ?? 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(Screen.width(radius ?? 8)))
          ),
          child: Text(title ?? '确认', style: TextStyle(fontSize: Screen.width(fontSize ?? 30)),),
          onPressed: pressed ?? () {},
        ),
    );
  }

  // 边框按钮
//  ButtonComponent.outline(
//  title: '+ 添加银行卡',
//  pressed: () { Navigator.pushNamed(context, '/addBank');
//  },)
  static outline({width, height, title, textColor, color, fontSize, highlightedBorderColor, radius, pressed, mLeft, mRight, mTop, mBottom}) {
    return FractionallySizedBox(
      widthFactor: width ?? .97,
      child: Container(
        margin: EdgeInsets.only(left: Screen.width(mLeft ?? 0), right: Screen.width(mRight ?? 0), top: Screen.width(mTop ?? 0), bottom: Screen.width(mBottom ?? 0),),
        height: Screen.width(height ?? 85),
        child: OutlineButton(
          padding: EdgeInsets.all(0),
          textColor: textColor ?? Colors.white,
          focusColor: Colors.grey,
          highlightedBorderColor: highlightedBorderColor ?? Colors.grey,
          borderSide: BorderSide(color: color ?? ColorGather.colorMain(), width: Screen.width(1)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(Screen.width(radius ?? 8))),
          ),
          child: Text(title ?? '确认', style: TextStyle(fontSize: Screen.width(fontSize ?? 30)),),
          onPressed: pressed ?? () {},
        ),
      )
    );
  }
}

// ListTitle
// color: null,
//ListTitleComponent(
//  leading: Image.asset('images/my/my_2.png', width: Screen.width(55)),
//  title: Text('我的钱包', style: TextStyle(fontSize: Screen.width(30))),
//),
class ListTitleComponent extends StatelessWidget {
  var color;
  var height;
  var leading;
  var leadingRight;
  var leadingLeft;
  var crossAxisAlignment;
  var trailing;
  var trailingShow;
  var title;
  var subTitle;
  var subPaddingTop;
  var onTap;
  ListTitleComponent({this.color = '', this.height, this.leading = '', this.onTap, this.crossAxisAlignment, this.title, this.subTitle, this.subPaddingTop, this.trailing, this.trailingShow = true, this.leadingRight, this.leadingLeft});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: Screen.width(height ?? 110),
        decoration: BoxDecoration(color: color != '' ? color : Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            leading != '' ? Container(margin: EdgeInsets.only(left: Screen.width(leadingLeft ?? 25), right: Screen.width(leadingRight ?? 30)), child: leading) : SizedBox(width: Screen.width(leadingLeft ?? 25), height: 0,),
            Expanded(
              flex: 1,
              child: Column(
                crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  title,
                  subTitle != null ? Container(
                    padding: EdgeInsets.only(top: Screen.width(subPaddingTop ?? 5)),
                    child: subTitle,
                  ) : SizedBox(width: 0, height: 0,)
                ],
              ),
            ),
            Offstage(
              offstage: trailingShow == false,
              child: Container(
                  margin: EdgeInsets.only(right: Screen.width(25)),
                  child: trailingHandler()
              ),
            )
          ],
        ),
      ),
      onTap: onTap,
    );
  }
  subTitleHandler() {
    if(subTitle) {
     return Container(
       padding: EdgeInsets.only(top: Screen.width(10)),
       child: subTitle,
      );
    } else {
      return SizedBox(width: 0, height: 0,);
    }
  }
  trailingHandler() {
    if(trailingShow) {
      return trailing ?? Container(margin: EdgeInsets.only(left: Screen.width(15)), child: Icon(Icons.arrow_forward_ios, size: Screen.width(26), color: Colors.grey),);
    }
  }
}
