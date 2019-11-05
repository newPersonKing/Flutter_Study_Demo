

import 'package:first_flutter_app/res/colors.dart';
import 'package:first_flutter_app/res/dimens.dart';
import 'package:first_flutter_app/res/styles.dart';
import 'package:first_flutter_app/router/fluro_navigator.dart';
import 'package:first_flutter_app/util/image_utils.dart';
import 'package:first_flutter_app/util/utils.dart';
import 'package:first_flutter_app/widgets/my_card.dart';
import 'package:first_flutter_app/widgets/my_flexible_space_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'order_list.dart';
import 'order_router.dart';

class Order extends StatefulWidget {
  @override
  _OrderState createState() => _OrderState();
}

class _OrderState extends State<Order> with AutomaticKeepAliveClientMixin<Order>, SingleTickerProviderStateMixin{

  @override
  bool get wantKeepAlive => true;

  TabController _tabController;
  int _index = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 5);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          /// 像素对齐问题的临时解决方法
          const SafeArea(
            child: const SizedBox(
              height: 105,
              width: double.infinity,
              child: const DecoratedBox(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Color(0xFF5793FA), Color(0xFF4647FA)])
                  )
              ),
            ),
          ),
          NestedScrollView(
            physics: ClampingScrollPhysics(),
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return _sliverBuilder(context);
            },
            body: PageView.builder(
              itemCount: 5,
              onPageChanged: (index) {
                if (_isPageCanChanged) {
                  _onPageChange(index);
                }
              },
              controller: _pageController,
              itemBuilder: (_, index) {
                return OrderList(index: index, tabIndex: _index);
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _sliverBuilder(BuildContext context) {
    return <Widget>[
      SliverOverlapAbsorber(
        handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
        child: SliverAppBar(
          leading: Container(),
          actions: <Widget>[
            IconButton(
              onPressed: (){
                NavigatorUtils.push(context, OrderRouter.orderSearchPage);
              },
              icon: loadAssetImage("order/icon_search",
                width: 22.0,
                height: 22.0,
              ),
            )
          ],
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          centerTitle: false,
          expandedHeight: 100.0,/*设置title 动画的高度 100 就差不多*/
          floating: false, // 不随着滑动隐藏标题 如果为true 随着滑动会隐藏SliverPersistentHeader
          pinned: true, // 固定在顶部 如果为false SliverOverlapAbsorber 会随着滑动 划出屏幕 SliverPersistentHeader 不会划出屏幕
          flexibleSpace: MyFlexibleSpaceBar(/*这个会填充到app 背后 高度跟appbar的 高度一样*/
            background: loadAssetImage("order/order_bg",
              width: double.infinity,
              height: 113.0,/*这个高度 设置的好像没有什么作用*/
              fit: BoxFit.fill,
            ),
            centerTitle: true,
            titlePadding: const EdgeInsetsDirectional.only(start: 16.0, bottom: 14.0),
            collapseMode: CollapseMode.pin,
            title: Text('订单'),
          ),
        ),
      ),
      SliverPersistentHeader(
        pinned: true,/*反正这里设置为false 这个高度还是显示的 就是内容看不见*/
        delegate: SliverAppBarDelegate(
            DecoratedBox(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(Utils.getImgPath("order/order_bg1")),
                      fit: BoxFit.fill
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: MyCard(
                  child: Container(
                    height: 80.0,//这个值如果设置的比SliverPersistentHeader 的高度小 那么内容会被SliverOverlapAbsorber 覆盖
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TabBar(
                      labelPadding: const EdgeInsets.symmetric(horizontal: 0),
                      controller: _tabController,
                      labelColor: Colours.text_dark,
                      unselectedLabelColor: Colours.text_dark,
                      labelStyle: TextStyles.textBoldDark14,
                      unselectedLabelStyle: TextStyles.textDark14,
                      indicatorColor: Colors.transparent,
                      tabs: <Widget>[
                        _buildTabView(0, "order/xdd_s", "order/xdd_n", '新订单'),
                        _buildTabView(1, "order/dps_s", "order/dps_n", '待配送'),
                        _buildTabView(2, "order/dwc_s", "order/dwc_n", '待完成'),
                        _buildTabView(3, "order/ywc_s", "order/ywc_n", '已完成'),
                        _buildTabView(4, "order/yqx_s", "order/yqx_n", '已取消'),
                      ],
                      onTap: (index){
                        if (!mounted){
                          return;
                        }
                        _pageController.jumpToPage(index);
                      },
                    ),
                  ),
                ),
              ),
            )
            , 80.0 /*这个80 定义header的高度*/
        ),
      ),

    ];
  }

  var _isPageCanChanged = true;
  PageController _pageController = PageController(initialPage: 0);
  _onPageChange(int index, {PageController p, TabController t}) async {

    if (p != null) {//判断是哪一个切换
      _isPageCanChanged = false;
      await _pageController.animateToPage(index, duration: Duration(milliseconds: 300), curve: Curves.ease);//等待pageview切换完毕,再释放pageivew监听
      _isPageCanChanged = true;
    } else {
      _tabController.animateTo(index);//切换Tabbar
    }
    _index = index;
    setState(() {

    });
  }

  Widget _buildTabView(int index, String selImg, String unImg, String text){
    return Stack(
      children: <Widget>[
        Container(
          width: 46.0,
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              loadAssetImage(_index == index ? selImg : unImg, width: 24.0, height: 24.0,),
              Gaps.vGap4,
              Text(text)
            ],
          ),
        ),
        Positioned(
          right: 0.0,
          child: index < 3 ? DecoratedBox(
            decoration: BoxDecoration(
              color: Colours.text_red,
              borderRadius: BorderRadius.circular(11.0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.5, vertical: 2.0),
              child: Text("10", style: TextStyle(color: Colors.white, fontSize: Dimens.font_sp12),),
            ),
          ) : Gaps.empty,
        )
      ],
    );
  }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final Widget widget;
  final double height;
  SliverAppBarDelegate(this.widget, this.height);

  // minHeight 和 maxHeight 的值设置为相同时，header就不会收缩了
  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;/*这个值 不要设置大于  自己设置的高度 也就是上面设置的内容高度80*/

  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    return widget;
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return true;
  }
}