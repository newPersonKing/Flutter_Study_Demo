
import 'package:flutter/material.dart';

class AppNavigator{

  static push(BuildContext context,Widget scene){

    /*新的页面压入栈*/
    Navigator.push(context,
        MaterialPageRoute(
            builder: (context){
              return scene;
            }
        )
    );
  }

  /*替换页面 当新的页面 进入后 之前的页面执行dispose 方法*/
  static pushReplacement(BuildContext context,Widget scene){

    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context){
          return scene;
        })
    );
  }

  /*指定页面加入路由 并将其他所有的页面移除*/
  static pushAndRemoveUntil(BuildContext context,Widget scene){

    /*第三个参数的 意思是说移除到符合某个条件的时候 停止*/
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context){
          return scene;
        }),
        ModalRoute.withName("/"));
  }


  static pushResult(BuildContext context, Widget scene, Function(Object) function) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => scene,
      ),
    ).then((result){
      // 页面返回result为null
      if (result == null){
        return;
      }
      function(result);
    }).catchError((error) {
      print("$error");
    });
  }

  //返回上一级
  static void goBack(BuildContext context){
    Navigator.pop(context);
  }

  /// 带参数返回
  static void goBackWithParams(BuildContext context, result) {
    Navigator.pop(context, result);
  }

}
