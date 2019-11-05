

import 'package:first_flutter_app/router/router_init.dart';
import 'package:fluro/fluro.dart';

import 'goods_statistics_page.dart';
import 'order_statistics_page.dart';

class StatisticsRouter implements IRouterProvider{

  static String orderStatisticsPage = "/statistics/order";
  static String goodsStatisticsPage = "/statistics/goods";

  @override
  void initRouter(Router router) {
    router.define(orderStatisticsPage, handler: Handler(handlerFunc: (_, params){
      int index = int.parse(params['index']?.first);
      return OrderStatisticsPage(index);
    }));
    router.define(goodsStatisticsPage, handler: Handler(handlerFunc: (_, params) => GoodsStatisticsPage()));
  }

}