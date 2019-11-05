import 'package:first_flutter_app/router/fluro_navigator.dart';
import 'package:first_flutter_app/widgets/MyButton.dart';
import 'package:first_flutter_app/widgets/search_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_2d_amap/flutter_2d_amap.dart';

class AddressSelectPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddressSelectPageState();
  }
}

class _AddressSelectPageState extends State<AddressSelectPage>{

  List<PoiSearch> _list = [];
  int _index = 0;
  ScrollController scrollController = new ScrollController();
  AMap2DController aMap2DController ;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /// iOS配置key
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      Flutter2dAMap.setApiKey("4327916279bf45a044bb53b947442387");
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,/*可以通过设置 这个属性 防止键盘 覆盖内容 或者 键盘 撑起内容*/
      appBar: SearchBar(
        hintText: "搜索地址",
        onPressed: (text){
          _index = 0;

          if (aMap2DController != null){
            aMap2DController.search(text);
          }
        },
      ),
      body: Column(
        children: <Widget>[
          Expanded(
              flex: 9,
              child: AMap2DView(
                onPoiSearched: (result){

                  _index = 0;
                  _list = result;
                  /*这个需要在list 有数据之后调用 否则 会 报错 不往下执行*/
                  scrollController.animateTo(0.0, duration: Duration(milliseconds: 10), curve: Curves.ease);
                  setState(() {

                  });
                },
                onAMap2DViewCreated: (controller){
                  aMap2DController = controller;
                },
              )
          ),
          Expanded(
              flex: 11,
              child: _list.isEmpty ?
              Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ):
              ListView.separated(
                  controller: scrollController,
                  shrinkWrap: false,/*没看出 这个属性值改变有什么效果*/
                  separatorBuilder: (_,index)=>Divider(height: 6.0,),
                  itemBuilder: (_,index){
                    return InkWell(
                      onTap: (){
                        _index = index;
                        if(aMap2DController !=null){
                          aMap2DController.move(_list[index].latitude, _list[index].longitude);
                        }
                        setState(() {});
                      },
                      child: Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        height: 50.0,
                        child: Row(
                          children: <Widget>[
                            Expanded(
                                child: Text(
                                    _list[index].provinceName+" "+
                                        _list[index].cityName+" "+
                                        _list[index].adName+" "+
                                        _list[index].title
                                )
                            ),
                            Opacity(
                              opacity: _index == index ? 1 :0,
                              child: Icon(Icons.done,color: Colors.blue),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: _list.length
              )
          ),
          SafeArea(
            child: MyButton(
              onPressed: (){
                NavigatorUtils.goBackWithParams(context, _list[_index]);
              },
              text: "确认选择地址",
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }
}