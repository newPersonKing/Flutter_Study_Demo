
import 'package:first_flutter_app/res/styles.dart';
import 'package:first_flutter_app/router/fluro_navigator.dart';
import 'package:first_flutter_app/widgets/base_dialog.dart';
import 'package:flutter/material.dart'
;
class GoodsSizeDialog extends StatefulWidget{

  GoodsSizeDialog({
    Key key,
    this.onPressed,
  }) : super(key : key);

  final Function(String) onPressed;
  
  @override
  _GoodsSizeDialog createState() => _GoodsSizeDialog();
  
}

class _GoodsSizeDialog extends State<GoodsSizeDialog>{

  TextEditingController _controller = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return BaseDialog(
      title: "规格名称",
      child: Container(
        height: 34.0,
        margin: const EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 0.0),
        decoration: BoxDecoration(
          color: Color(0xFFFAFAFA),
          borderRadius: BorderRadius.circular(2.0),
        ),
        child: TextField(
          autofocus: true,
          style: TextStyles.textDark14,
          controller: _controller,
          maxLines: 1,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
            border: InputBorder.none,
            hintText: "输入文字…",
            hintStyle: TextStyles.textGrayC14,
          ),
        ),
      ),
      onPressed: (){
        NavigatorUtils.goBack(context);
        widget.onPressed(_controller.text);
      },
    );
  }
}