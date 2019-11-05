

import 'package:first_flutter_app/page/mvp/base_page_state.dart';
import 'package:first_flutter_app/page/order/presenter/order_search_presenter.dart';
import 'package:first_flutter_app/page/provider/base_list_provider.dart';
import 'package:first_flutter_app/widgets/my_refresh_list.dart';
import 'package:first_flutter_app/widgets/search_bar.dart';
import 'package:first_flutter_app/widgets/state_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/search_entity.dart';


class OrderSearch extends StatefulWidget {
  @override
  OrderSearchState createState() => OrderSearchState();

}

class OrderSearchState extends BasePageState<OrderSearch, OrderSearchPresenter> {

  BaseListProvider<SearchItem> provider = BaseListProvider<SearchItem>();

  String _keyword;
  int _page = 1;

  @override
  void initState() {
    /// 默认为加载中状态，本页面场景默认为空
    provider.setStateTypeNotNotify(StateType.empty);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BaseListProvider<SearchItem>>(/*ChangeNotifierProvider 用来做监听provider数据改变 刷新数据*/
      builder: (_) => provider,
      child: Scaffold(
        appBar: SearchBar(
          hintText: "请输入手机号或姓名查询",
          onPressed: (text){
            if (text.isEmpty){
              showToast("搜索关键字不能为空！");
              return;
            }
            FocusScope.of(context).requestFocus(FocusNode());
            _keyword = text;
            provider.setStateType(StateType.loading);
            _page = 1;
            presenter.search(_keyword, _page, true);
          },
        ),
        body: Consumer<BaseListProvider<SearchItem>>(/*Consumer这个widget不做任何事情 他只是用来提供provider 避免调用Provider.of<Foo>(context).value context 引用错误*/
          builder: (_, provider, __) {
            return DeerListView(
              itemCount: provider.list.length,
              stateType: provider.stateType,
              onRefresh: _onRefresh,
              loadMore: _loadMore,
              itemExtent: 50.0,
              hasMore: provider.hasMore,
              itemBuilder: (_, index){
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: Text(provider.list[index].name),
                );
              },
            );
          }
        ),
      ),
    );
  }

  Future _onRefresh() async {
    _page = 1;
    await presenter.search(_keyword, _page, false);
  }

  Future _loadMore() async {
    _page++;
    await presenter.search(_keyword, _page, false);
  }

  @override
  OrderSearchPresenter createPresenter() {
    return OrderSearchPresenter();
  }
}
