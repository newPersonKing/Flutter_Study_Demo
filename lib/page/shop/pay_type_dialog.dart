
import 'package:first_flutter_app/res/styles.dart';
import 'package:first_flutter_app/router/fluro_navigator.dart';
import 'package:first_flutter_app/util/image_utils.dart';
import 'package:first_flutter_app/util/toast.dart';
import 'package:first_flutter_app/widgets/base_dialog.dart';
import 'package:flutter/material.dart';

class PayTypeDialog extends StatefulWidget{

  PayTypeDialog({
    Key key,
    this.value,
    this.onPressed,
  }) : super(key : key);

  final List<int> value;
  final Function(List) onPressed;
  
  @override
  _PayTypeDialog createState() => _PayTypeDialog();
  
}

class _PayTypeDialog extends State<PayTypeDialog>{

  List _selectValue;
  var _list = ["线上支付", "对公转账", "货到付款"];

  Widget getItem(int index){
    _selectValue = widget.value ?? [0];
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
                  style: TextStyles.textDark14,
                ),
              ),
              loadAssetImage(_selectValue.contains(index) ? "shop/xz" : "shop/xztm", width: 16.0, height: 16.0),
              Gaps.hGap16,
            ],
          ),
        ),
        onTap: (){
          if (mounted) {
            if (index == 0){
              Toast.show("线上支付为必选项");
              return;
            }
            setState(() {
              if (_selectValue.contains(index)){
                _selectValue.remove(index);
              }else{
                _selectValue.add(index);
              }
            });
          }
        },
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: "支付方式(多选)",
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          getItem(0),
          getItem(1),
          getItem(2),
        ],
      ),
      onPressed: (){
        NavigatorUtils.goBack(context);
        widget.onPressed(_selectValue);
      },
    );
  }
}