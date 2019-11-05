

import 'package:first_flutter_app/res/colors.dart';
import 'package:first_flutter_app/res/dimens.dart';
import 'package:first_flutter_app/res/styles.dart';
import 'package:first_flutter_app/router/fluro_navigator.dart';
import 'package:flutter/material.dart';

class BaseDialog extends StatelessWidget{

  const BaseDialog({
    Key key,
    this.title,
    this.onPressed,
    this.hiddenTitle : false,
    @required this.child
  }) : super(key : key);

  final String title;
  final Function onPressed;
  final Widget child;
  final bool hiddenTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(//创建透明层
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,/*透明层*/
      // 键盘弹出收起动画过渡
      body: AnimatedContainer(
        alignment: Alignment.center,
        height: MediaQuery.of(context).size.height - MediaQuery.of(context).viewInsets.bottom,/*系统UI 的高度 这里一般是指软键盘的高度*/
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeInCubic,
        child: Container(/*container 不设置宽高 默认是充满全屏的 如果有child 适应child的大小*/
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
            ),
            width: 270.0,
            padding: const EdgeInsets.only(top: 24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Offstage(
                  offstage: hiddenTitle,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      hiddenTitle ? "" : title,
                      style: TextStyles.textBoldDark18,
                    ),
                  ),
                ),
                Flexible(child: child),
                Gaps.vGap8,
                Gaps.line,
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Container(
                        height: 48.0,
                        child: FlatButton(
                          child: const Text(
                            "取消",
                            style: TextStyle(
                                fontSize: Dimens.font_sp18
                            ),
                          ),
                          textColor: Colours.text_gray,
                          onPressed: (){
                            NavigatorUtils.goBack(context);
                          },
                        ),
                      ),
                    ),
                    Container(
                      height: 48.0,
                      width: 0.6,
                      color: Colours.line,
                    ),
                    Expanded(
                      child: Container(
                        height: 48.0,
                        child: FlatButton(
                          child: const Text(
                            "确定",
                            style: TextStyle(
                                fontSize: Dimens.font_sp18
                            ),
                          ),
                          textColor: Colours.app_main,
                          onPressed: (){
                            onPressed();
                          },
                        ),
                      ),
                    )
                  ],
                )
              ],
            )
        ),
      ),
    );
  }
}