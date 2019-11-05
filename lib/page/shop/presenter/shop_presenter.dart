
import 'package:first_flutter_app/page/mvp/base_page_presenter.dart';
import 'package:first_flutter_app/page/net/api.dart';
import 'package:first_flutter_app/page/net/dio_utils.dart';
import 'package:first_flutter_app/page/shop/model/user_entity.dart';
import 'package:flutter/material.dart';

import '../shop_page.dart';

class ShopPagePresenter extends BasePagePresenter<ShopState> {

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      /// 接口请求例子
      /// get请求参数queryParameters  post请求参数params
      requestNetwork<UserEntity>(Method.get,
        url: Api.users,
        onSuccess: (data){
          view.setUser(data);
          // 或
          // view.provider.setUser(data);
        },
      );
    });
  }
 
}