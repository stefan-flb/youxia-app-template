import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:date_format/date_format.dart';
import '../../services/utils.dart';

final double kPickerHeight = 200.0;
final double kItemHeight = 40.0;
const Color kBtnColor = Color(0xFF323232);//50
const Color kTitleColor = Color(0xFF787878);//120
const double kTextFontSize = 17.0;

typedef StringClickCallback = void Function(int selectIndex,Object selectStr);
typedef ArrayClickCallback = void Function( List<int> selecteds,List<dynamic> strData);
typedef DateClickCallback = void Function(dynamic selectDateStr,dynamic selectDate);

enum DateType {
  YMD,        // y, m, d
  YM,        // y ,m
  YMD_HM,     // y, m, d, hh, mm
  YMD_AP_HM,  // y, m, d, ap, hh, mm
}
//单列选择器
//var aa = ["11","22","33","44"];
//
//PickerTool.showStringPicker(context,
//data: aa,
//// normalIndex: 2,
//// title: "请选择2",
//clickCallBack: (index, str){
//print(index);
//print(str);
//}
//);

//多列选择器
//var bb = [["11","22"],["33","44"],["55","66"]];
//
//PickerTool.showArrayPicker(context,
//data: bb,
//// title: "请选择2",
//// normalIndex: [0,1,0],
//clickCallBack:(index, strData){
//print(index);
//print(strData);
//}
//);
//


//日期选择器
//PickerTool.showDatePicker(context,
//// dateType: DateType.YMD,
//// dateType: DateType.YM,
//// dateType: DateType.YMD_HM,
//// dateType: DateType.YMD_AP_HM,
//// title: "请选择2",
//// minValue: DateTime(2020,10,10),
//// maxValue: DateTime(2023,10,10),
//// value: DateTime(2020,10,10),
//clickCallback: (str, time){
//print(str);
//print(time);
//}
//);
//日期选择器
//PickerTool.showDatePicker(context,
//clickCallback: (str, time){
//print(str);
//print(time);
//}
//);


//PickerTool.showPickerDateRange(context, callBack: (start, end) {
//setState(() {
//startTime = start;
//endTime = end;
//});
//});

class PickerTool {

  /** 单列 **/
  static void showStringPicker<T>(
      BuildContext context, {
        @required List<T> data,
        String title,
        int normalIndex,
        PickerDataAdapter adapter,
        @required StringClickCallback clickCallBack,
      }) {

    openModalPicker(context,
        adapter: adapter ??  PickerDataAdapter( pickerdata: data, isArray: false),
        clickCallBack:(Picker picker, List<int> selecteds){
          //          print(picker.adapter.text);
          clickCallBack(selecteds[0],data[selecteds[0]]);
        },
        selecteds: [normalIndex??0] ,
        title: title);
  }

  /** 多列 **/
  static void showArrayPicker<T>(
      BuildContext context, {
        @required List<T> data,
        String title,
        List<int> normalIndex,
        PickerDataAdapter adapter,
        @required ArrayClickCallback clickCallBack,
      }) {
    openModalPicker(context,
        adapter: adapter ??  PickerDataAdapter( pickerdata: data, isArray: true),
        clickCallBack:(Picker picker, List<int> selecteds){
          clickCallBack(selecteds,picker.getSelectedValues());
        },
        selecteds: normalIndex,
        title: title);

  }

  static void openModalPicker(
      BuildContext context, {
        @required PickerAdapter adapter,
        String title,
        List<int> selecteds,
        @required PickerConfirmCallback clickCallBack,
      }) {
    new Picker(
        adapter: adapter,
        title: new Text(title ?? "请选择",
            style: TextStyle(color: kTitleColor, fontSize: kTextFontSize)),
        selecteds: selecteds,
        cancelText: '取消',
        confirmText: '确定',
        cancelTextStyle: TextStyle(color: kBtnColor, fontSize: kTextFontSize),
        confirmTextStyle: TextStyle(color: kBtnColor, fontSize: kTextFontSize),
        textAlign: TextAlign.right,
        itemExtent: kItemHeight,
        height: kPickerHeight,
        selectedTextStyle: TextStyle(color: Colors.black),
        onConfirm: clickCallBack
    ).showModal(context);
  }
  static showPickerDateRange(BuildContext context, {callBack(startTime, endTime)}) {
    print("canceltext: ${PickerLocalizations.of(context).cancelText}");
    var startTime;
    var endTime;
    Picker ps = new Picker(
        hideHeader: true,
        adapter: new DateTimePickerAdapter(type: PickerDateTimeType.kYMD, isNumberMonth: true),
        onConfirm: (Picker picker, List value) {
          var time = (picker.adapter as DateTimePickerAdapter).value;
          startTime = formatDate(time, [yyyy, '-', mm, '-', dd]);
        }
    );

    Picker pe = new Picker(
        hideHeader: true,
        adapter: new DateTimePickerAdapter(type: PickerDateTimeType.kYMD, isNumberMonth: true),
        onConfirm: (Picker picker, List value) {
          var time = (picker.adapter as DateTimePickerAdapter).value;
          endTime = formatDate(time, [yyyy, '-', mm, '-', dd]);
          callBack(startTime, endTime);
        }
    );

    List<Widget> actions = [
      FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: new Text('取消', style: TextStyle(fontSize: Screen.width(28), color: ColorGather.colorMain()))),
      FlatButton(
          onPressed: () {
            Navigator.pop(context);
            ps.onConfirm(ps, ps.selecteds);
            pe.onConfirm(pe, pe.selecteds);
          },
          child: new Text('确认', style: TextStyle(fontSize: Screen.width(28), color: ColorGather.colorMain())))
    ];

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: Text("选择时间", style: TextStyle(fontSize: Screen.width(30)),),
            actions: actions,
            content: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("开始时间:", style: TextStyle(fontSize: Screen.width(28)),),
                  ps.makePicker(),
                  Text("结束时间:", style: TextStyle(fontSize: Screen.width(28)),),
                  pe.makePicker()
                ],
              ),
            ),
          );
        });
  }

  /** 日期选择器 **/
  static void showDatePicker(
      BuildContext context, {
        DateType dateType,
        String title,
        DateTime maxValue,
        DateTime minValue,
        DateTime value,
        DateTimePickerAdapter adapter,
        @required DateClickCallback clickCallback,
      }) {

    int timeType;
    if(dateType == DateType.YM){
      timeType =  PickerDateTimeType.kYM;
    }else if(dateType == DateType.YMD_HM){
      timeType =  PickerDateTimeType.kYMDHM;
    }else if(dateType == DateType.YMD_AP_HM){
      timeType =  PickerDateTimeType.kYMD_AP_HM;
    }else{
      timeType =  PickerDateTimeType.kYMD;
    }

    openModalPicker(context,
        adapter: adapter ??
            DateTimePickerAdapter(
              type: timeType,
              isNumberMonth: true,
              yearSuffix: "年",
              monthSuffix: "月",
              daySuffix: "日",
              strAMPM: const["上午", "下午"],
              maxValue: maxValue ,
              minValue: minValue,
              value: value ?? DateTime.now(),
            ),
        title: title,
        clickCallBack:(Picker picker, List<int> selecteds){

          var time = (picker.adapter as DateTimePickerAdapter).value;
          var timeStr;
          if(dateType == DateType.YM){
            timeStr =time.year.toString()+"年"+time.month.toString()+"月";
          }else if(dateType == DateType.YMD_HM){
            timeStr =time.year.toString()+"年"+time.month.toString()+"月"+time.day.toString()+"日"+time.hour.toString()+"时"+time.minute.toString()+"分";
          }else if(dateType == DateType.YMD_AP_HM){
            var str = formatDate(time, [am])=="AM" ? "上午":"下午";
            timeStr =time.year.toString()+"年"+time.month.toString()+"月"+time.day.toString()+"日"+str+time.hour.toString()+"时"+time.minute.toString()+"分";
          }else{
            timeStr =time.year.toString()+"年"+time.month.toString()+"月"+time.day.toString()+"日";
          }
//          print(formatDate(DateTime(1989, 02, 21), [yyyy, '-', mm, '-', dd]));
          clickCallback(timeStr,picker.adapter.text);

        }

    );

  }
}