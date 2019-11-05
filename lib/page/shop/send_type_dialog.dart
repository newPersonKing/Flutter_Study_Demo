
import 'package:first_flutter_app/res/styles.dart';
import 'package:first_flutter_app/router/fluro_navigator.dart';
import 'package:first_flutter_app/util/image_utils.dart';
import 'package:first_flutter_app/widgets/base_dialog.dart';
import 'package:flutter/material.dart';

class SendTypeDialog extends StatefulWidget{

  SendTypeDialog({
    Key key,
    this.onPressed,
  }) : super(key : key);

  final Function(int, String) onPressed;
  
  @override
  _SendTypeDialog createState() => _SendTypeDialog();
  
}

class _SendTypeDialog extends State<SendTypeDialog>{

  int _value = 0;
  var _list = ["运费满免配置", "运费比例配置"];

  Widget getItem(int index){
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        child: Container(
          height: 42.0,
          child: Row(
            children: <Widget>[
              Gaps.hGap16,
              Expanded(
                child: Text(
                  _list[index],
                  style: _value == index ? TextStyles.textMain14 : TextStyles.textDark14,
                ),
              ),
              Offstage(
                  offstage: _value != index,
                  child: loadAssetImage("order/ic_check", width: 16.0, height: 16.0)),
              Gaps.hGap16,
            ],
          ),
        ),
        onTap: (){
          if (mounted) {
            setState(() {
              _value = index;
            });
          }
        },
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: "运费配置",
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          getItem(0),
          getItem(1),
        ],
      ),
      onPressed: (){
        NavigatorUtils.goBack(context);
        widget.onPressed(_value, _list[_value]);
      },
    );
  }
}