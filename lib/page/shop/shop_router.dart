
import 'package:first_flutter_app/page/shop/select_address_page.dart';
import 'package:first_flutter_app/page/shop/shop_page.dart';
import 'package:first_flutter_app/page/shop/shop_setting_page.dart';
import 'package:first_flutter_app/router/router_init.dart';
import 'package:fluro/fluro.dart';

import 'freight_config_page.dart';
import 'message_page.dart';

class ShopRouter implements IRouterProvider{

  static String shopPage = "/shop";
  static String shopSettingPage = "/shop/shopSetting";
  static String messagePage = "/shop/message";
  static String freightConfigPage = "/shop/freightConfig";
  static String addressSelectPage = "/shop/addressSelect";

  @override
  void initRouter(Router router) {
    router.define(shopPage, handler: Handler(handlerFunc: (_, params) => Shop()));
    router.define(shopSettingPage, handler: Handler(handlerFunc: (_, params) => ShopSettingPage()));
    router.define(messagePage, handler: Handler(handlerFunc: (_, params) => MessagePage()));
    router.define(freightConfigPage, handler: Handler(handlerFunc: (_, params) => FreightConfigPage()));
    router.define(addressSelectPage, handler: Handler(handlerFunc: (_, params) => AddressSelectPage()));
  }

}