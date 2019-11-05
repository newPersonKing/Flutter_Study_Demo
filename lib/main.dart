import 'dart:io';

import 'package:first_flutter_app/page/home/SplashPage.dart';
import 'package:first_flutter_app/res/colors.dart';
import 'package:first_flutter_app/router/Routes.dart';
import 'package:first_flutter_app/router/application.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:auto_size/auto_size.dart';
import 'package:flutter/services.dart';
/*国际化 有空在研究*/
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:oktoast/oktoast.dart';

/*屏幕适配 后两个参数 是设计的宽高*/
void main() {
  runAutoSizeApp(MyApp());
// 透明状态栏
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
    SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}


class MyApp extends StatelessWidget {

  MyApp(){
    final router = Router();
    /*设置路由*/
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return OKToast(
      child: MaterialApp(
        title: "FLUTTER DEER",
        theme: ThemeData(
          primaryColor: Colours.app_main,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: SplashPage(),
        onGenerateRoute:Application.router.generator,
      ),
        backgroundColor: Colors.black54,
        textPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        radius: 20.0,
        position: ToastPosition.bottom
    );
  }
}

