
import 'package:first_flutter_app/res/styles.dart';
import 'package:first_flutter_app/router/fluro_navigator.dart';
import 'package:first_flutter_app/util/image_utils.dart';
import 'package:first_flutter_app/widgets/base_dialog.dart';
import 'package:flutter/material.dart';

class PayTypeDialog extends StatefulWidget{

  PayTypeDialog({
    Key key,
    this.onPressed,
  }) : super(key : key);

  final Function(int, String) onPressed;
  
  @override
  _PayTypeDialog createState() => _PayTypeDialog();
  
}

class _PayTypeDialog extends State<PayTypeDialog>{

  int _value = 0;
  var _list = ["未收款", "支付宝", "微信", "现金"];

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
      title: "收款方式",
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          getItem(0),
          getItem(1),
          getItem(2),
          getItem(3),
        ],
      ),
      onPressed: (){
        NavigatorUtils.goBack(context);
        widget.onPressed(_value, _list[_value]);
      },
    );
  }
}