

import 'package:first_flutter_app/router/router_init.dart';
import 'package:fluro/fluro.dart';
import 'package:fluro/src/router.dart';

import 'order_info_page.dart';
import 'order_page.dart';
import 'order_search_page.dart';
import 'order_track_page.dart';

class OrderRouter extends IRouterProvider{

  static String orderPage = "/order";
  static String orderInfoPage = "/order/info";
  static String orderSearchPage = "/order/search";
  static String orderTrackPage = "/order/track";


  @override
  void initRouter(Router router) {
    router.define(orderPage, handler: Handler(handlerFunc: (_, params) => Order()));
    router.define(orderInfoPage, handler: Handler(handlerFunc: (_, params) => OrderInfo()));
    router.define(orderSearchPage, handler: Handler(handlerFunc: (_, params) => OrderSearch()));
    router.define(orderTrackPage, handler: Handler(handlerFunc: (_, params) => OrderTrack()));
  }
}