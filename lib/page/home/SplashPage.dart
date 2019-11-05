
import 'dart:async';

import 'package:first_flutter_app/common/common.dart';
import 'package:first_flutter_app/page/login/LoginRouter.dart';
import 'package:first_flutter_app/router/fluro_navigator.dart';
import 'package:first_flutter_app/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:first_flutter_app/util/AppNavigator.dart';
import 'package:common_utils/common_utils.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flustars/flustars.dart';


class SplashPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return __SplashPageState();
  }
}

class __SplashPageState extends State<SplashPage>{

  var _status = 0;

  List<String> _guideList = [
    "app_start_1",
    "app_start_2",
    "app_start_3",
  ];

  StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();
    _initSplash();
  }

  void _initSplash(){

    _subscription =  Observable.just(1).delay(Duration(seconds: 2)).listen((data){
      _initAsync();
    });

  }

  void _initAsync() async{
    print("ccccccccccc_initAsync");
    await SpUtil.getInstance();
    print("ccccccccbool=="+SpUtil.getBool(Constant.key_guide, defValue: true).toString());
    if (SpUtil.getBool(Constant.key_guide, defValue: true)) {
      SpUtil.putBool(Constant.key_guide, false);
      _initGuide();
    } else {
      _goLogin();
    }
  }

  _initGuide(){
    /*显示导航页*/
    print("cccccc_initGuide");
    setState(() {
      _status = 1;
    });
  }

  /*不是第一次登录直接 去登录*/
  _goLogin(){
    NavigatorUtils.push(context,LoginRouter.loginPage,replace: true);
  }

  @override
  void dispose() {
    super.dispose();
    if(_subscription !=null){
      _subscription.cancel();
    }
  }

  @override
  Widget build(BuildContext context) {

    return Material(
      child: Stack(
        children: <Widget>[
          Offstage(
            offstage: !(_status == 0),
            child: Image.asset(
              Utils.getImgPath("start_page", format: "jpg"),
              width: double.infinity,
              fit: BoxFit.fill,
              height: double.infinity,
            ),
          ),
          Offstage(
            offstage: !(_status == 1),
            child:Swiper(
              itemCount: _guideList.length,
              loop:false,
              itemBuilder: (context,index){
                return Image.asset(
                  Utils.getImgPath(_guideList[index]),
                  width: double.infinity,
                  fit: BoxFit.fill,
                  height: double.infinity,
                );
              },
              onTap: (index){
                if(index == _guideList.length -1){
                  _goLogin();
                }
              },
            ),
          )
        ],
      ),
    );
  }
}