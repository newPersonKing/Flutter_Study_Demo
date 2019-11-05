

import 'package:first_flutter_app/page/login/register_page.dart';
import 'package:first_flutter_app/page/login/reset_password_page.dart';
import 'package:first_flutter_app/page/login/sms_login_page.dart';
import 'package:first_flutter_app/page/login/update_password_page.dart';
import 'package:first_flutter_app/router/router_init.dart';
import 'package:fluro/fluro.dart';
import 'package:fluro/src/router.dart';

import 'login_page.dart';

class LoginRouter extends IRouterProvider{

  static String loginPage = "/login";
  static String registerPage = "/login/register";
  static String smsLoginPage = "/login/smsLogin";
  static String resetPasswordPage = "/login/resetPassword";
  static String updatePasswordPage = "/login/updatePassword";

  @override
  void initRouter(Router router) {

    router.define(loginPage, handler: Handler(handlerFunc: (context,params){
      return Login();
    }));

    router.define(registerPage, handler: Handler(handlerFunc: (context,param){
      return Register();
    }));

    router.define(smsLoginPage, handler: Handler(handlerFunc: (context,param){
      return SMSLogin();
    }));

    router.define(resetPasswordPage, handler: Handler(handlerFunc: (context,param){
      return ResetPassword();
    }));

    router.define(updatePasswordPage, handler: Handler(handlerFunc: (context,param){
      return UpdatePasswordPage();
    }));
  }
}