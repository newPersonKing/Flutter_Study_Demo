import 'package:first_flutter_app/page/account/account_router.dart';
import 'package:first_flutter_app/page/goods/goods_router.dart';
import 'package:first_flutter_app/page/home/home_page.dart';
import 'package:first_flutter_app/page/login/LoginRouter.dart';
import 'package:first_flutter_app/page/order/order_router.dart';
import 'package:first_flutter_app/page/setting/setting_router.dart';
import 'package:first_flutter_app/page/shop/shop_router.dart';
import 'package:first_flutter_app/page/statistics/statistics_router.dart';
import 'package:first_flutter_app/page/store/store_router.dart';
import 'package:first_flutter_app/router/router_init.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

class Routes {
  static String home = "/home";
  static String webViewPage = "/webview";

  static List<IRouterProvider> _listRouter = [];

  static void configureRoutes(Router router) {

    router.define(home, handler: Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) => Home()));

    _listRouter.add(LoginRouter());
    _listRouter.add(StoreRouter());
    _listRouter.add(ShopRouter());
    _listRouter.add(OrderRouter());
    _listRouter.add(GoodsRouter());
    _listRouter.add(StatisticsRouter());
    _listRouter.add(AccountRouter());
    _listRouter.add(SettingRouter());
    /// 初始化路由
    _listRouter.forEach((routerProvider){
      routerProvider.initRouter(router);
    });

  }
}
