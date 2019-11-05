import 'package:first_flutter_app/res/colors.dart';
import 'package:first_flutter_app/res/styles.dart';
import 'package:first_flutter_app/util/number_text_input_formatter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class TextFieldItem extends StatelessWidget{

  TextFieldItem({
    Key key,
    this.controller,
    @required this.title,
    this.textInputType : TextInputType.text,
    this.hintText:"",
    this.focusNode,
    this.keyboardActionsConfig
  });

  TextEditingController controller;

  String title;

  String hintText;

  TextInputType textInputType;

  FocusNode focusNode;

  KeyboardActionsConfig keyboardActionsConfig;

  @override
  Widget build(BuildContext context) {

    if (keyboardActionsConfig != null && defaultTargetPlatform == TargetPlatform.iOS){
      // 因Android平台输入法兼容问题，所以只配置IOS平台
      FormKeyboardActions.setKeyboardActions(context, keyboardActionsConfig);
    }

    return Container(
      height: 50.0,
      margin: const EdgeInsets.only(left: 16.0),
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border(
              bottom: Divider.createBorderSide(context,color: Colours.line,width: 0.6)
          )
      ),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Text(title,style: TextStyles.textDark14,),
          ),
          Expanded(
              flex: 1,
              child:TextField(
                  focusNode: focusNode,
                  keyboardType: textInputType,
                  controller: controller,
                  inputFormatters: _getInputFormatters(),
                  decoration: InputDecoration(
                      hintText: hintText,
                      border: InputBorder.none, //去掉下划线
                      hintStyle: TextStyles.textGrayC14
                  )
              )
          )
        ],
      ),
    );
  }

  _getInputFormatters(){
    if (textInputType == TextInputType.numberWithOptions(decimal: true)){
      return [UsNumberTextInputFormatter()];
    }
    if (textInputType == TextInputType.number || textInputType == TextInputType.phone){
      return [WhitelistingTextInputFormatter.digitsOnly];
    }
    return null;
  }
}

