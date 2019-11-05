

import 'package:first_flutter_app/page/mvp/base_page_presenter.dart';
import 'package:first_flutter_app/page/net/api.dart';
import 'package:first_flutter_app/page/net/dio_utils.dart';
import 'package:first_flutter_app/page/order/model/search_entity.dart';
import 'package:first_flutter_app/widgets/state_layout.dart';

import '../order_search_page.dart';

class OrderSearchPresenter extends BasePagePresenter<OrderSearchState> {

  Future search(String text, int page, bool isShowDialog) async{
   
    Map<String, String> params = Map();
    params["q"] = text;
    params["page"] = page.toString();
    params["l"] = "Dart";
    await request<SearchEntity>(Method.get,
      url: Api.search,
      queryParameters: params,
      isShow: isShowDialog,
      onSuccess: (data){
        if(data != null){
          /// 一页30条数据，等于30条认为有下一页
          /// 具体的处理逻辑根据具体的接口情况处理，这部分可以抽离出来
          view.provider.setHasMore(data.items.length == 30);
          if (page == 1){
            /// 刷新
            view.provider.list.clear();
            if (data.items.isEmpty){
              view.provider.setStateType(StateType.order);
            }else{
              view.provider.addAll(data.items);
            }
          }else{
            view.provider.addAll(data.items);
          }
        }else{
          /// 加载失败
          view.provider.setHasMore(false);
          view.provider.setStateType(StateType.network);
        }
      },
      onError: (_, __){
        /// 加载失败
        view.provider.setHasMore(false);
        view.provider.setStateType(StateType.network);
      }
    );
  }
 
}