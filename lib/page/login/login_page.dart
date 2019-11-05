import 'dart:async';

import 'package:first_flutter_app/common/common.dart';
import 'package:first_flutter_app/page/store/store_router.dart';
import 'package:first_flutter_app/res/colors.dart';
import 'package:first_flutter_app/res/styles.dart';
import 'package:first_flutter_app/router/fluro_navigator.dart';
import 'package:first_flutter_app/util/utils.dart';
import 'package:first_flutter_app/widgets/MyButton.dart';
import 'package:first_flutter_app/widgets/app_bar.dart';
import 'package:first_flutter_app/widgets/text_field.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:flutter/services.dart';
import 'package:flustars/flustars.dart';

import 'LoginRouter.dart';


class Login extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _LoginState();
  }
}

class _LoginState extends State<Login>{

  /*定义两个textController*/
  TextEditingController userNameController = TextEditingController();
  TextEditingController passWordController = TextEditingController();

  StreamController streamController =  new StreamController();

  final FocusNode _nodeText1 = FocusNode();
  final FocusNode _nodeText2 = FocusNode();

  KeyboardActionsConfig _config;
  bool _isClick = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    //监听输入改变
    userNameController.addListener(_verify);
    passWordController.addListener(_verify);
    userNameController.text = SpUtil.getString("18088888888");
    _config = Utils.getKeyboardActionsConfig([_nodeText1, _nodeText2]);
  }

  void _verify(){
    String name = userNameController.text;
    String password = passWordController.text;
    bool isClick = true;
    if (name.isEmpty || name.length < 11) {
      isClick = false;
    }
    if (password.isEmpty || password.length < 6) {
      isClick = false;
    }

    /// 状态不一样在刷新，避免重复不必要的setState
    if (isClick != _isClick){
      setState(() {
        _isClick = isClick;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(
        isBack: false,
        actionName: "验证码登录",
        onPressed: (){
          NavigatorUtils.push(context, LoginRouter.smsLoginPage);
        },
      ),
      body: defaultTargetPlatform == TargetPlatform.iOS ? FormKeyboardActions(
        child: _buildBody(),
      ) : SingleChildScrollView(
        child: _buildBody(),
      ),
    );
  }

  _buildBody(){
    return Padding(
      padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const Text(
            "密码登录",
            style:  TextStyles.textBoldDark26,
          ),
          SizedBox(width: double.infinity,height: 16.0,),
          MyTextField(
            focusNode: _nodeText1,
            controller: userNameController,
            maxLength: 11,
            keyboardType: TextInputType.phone,
            hintText: "请输入账号",
          ),
          Gaps.vGap8,
          MyTextField(
            focusNode: _nodeText2,
            config: _config,
            isInputPwd: true,
            controller: passWordController,
            maxLength: 16,
            hintText: "请输入密码",
          ),
          Gaps.vGap10,
          Gaps.vGap15,
          MyButton(
            onPressed: _isClick ? _login : null,
            text: "登录",
          ),
          Container(
            height: 40.0,
            alignment: Alignment.centerRight,
            child: GestureDetector(
              child: const Text(
                '忘记密码',
                style: TextStyles.textGray12,
              ),
              onTap: (){
                NavigatorUtils.push(context, LoginRouter.resetPasswordPage);
              },
            ),
          ),
          Gaps.vGap16,
          Container(
              alignment: Alignment.center,
              child: GestureDetector(
                child: const Text(
                  '还没账号？快去注册',
                  style: TextStyle(
                      color: Colours.text_blue
                  ),
                ),
                onTap: (){
                  NavigatorUtils.push(context, LoginRouter.registerPage);
                },
              )
          )
        ],
      ),
    );
  }


  void _login(){
    SpUtil.putString(Constant.phone, userNameController.text);
    NavigatorUtils.push(context, StoreRouter.auditPage);
  }
}